<?php
	function hex2str($hex) {
	    $str = '';
	    for($i=0;$i<strlen($hex);$i+=2) $str .= chr(hexdec(substr($hex,$i,2)));
	    return $str;
	}

	function strToHex($string){
	    $hex = '';
	    for ($i=0; $i<strlen($string); $i++){
	        $ord = ord($string[$i]);
	        $hexCode = dechex($ord);
	        $c = substr('0'.$hexCode, -2);
	       	if($c != "00"){
	       		$hex .= $c;
	       	}
	    }
	    return strToUpper($hex);
	}

	if(!isset($_GET["c"])){
		print(base64_encode("INVALID_REQUEST"));
		die();
	}

	$c = $_GET["c"];

	$split = explode("||", $c);

	if(sizeof($split) != 3){
		print(base64_encode("INVALID_REQUEST"));
		die();
	}

	//Validate HMAC
	$hmac = $split[2];
	$hmac_key = "825A7039623881D48E8A80DBFC3DDFD3B690F408D";
	$message = $split[0]."||".$split[1];

	$hm = hash_hmac('sha256', $message, $hmac_key);

	if($hmac != $hm){
		print(base64_encode("DATA CORRUPTION"));
		die();
	}


	//DECRYPT
	$iv = $split[0];
	$ciphertext = $split[1];
	$key = "EDC7516732FF488531898428A8110869";

	$bin_iv = hex2bin($iv);
	$bin_key = hex2bin($key);
	$bin_cipjer = hex2bin($ciphertext);

	$rawplain = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $bin_key, $bin_cipjer, MCRYPT_MODE_CBC, $bin_iv);
	$x = bin2hex($rawplain);

	$plain = hex2str($x);

	$msg_splits = explode("||", $plain);

	if (sizeof($msg_splits) != 8){
		print(base64_encode("DATA PROCESSING FAILURE"));
		die();
	}

	$m_secretkey = "";
	$m_charName = "";
	$m_username = "";
	$m_authkey = "";
	$m_iv = "";
	$m_scriptkey = "";
	$m_hwid = "";

	foreach ($msg_splits as $key => $value) {
		$csplit = explode(":", $value);
		if (sizeof($csplit) > 1) {
			$k = $csplit[0];
			$v = $csplit[1];

			$v = hex2str(strToHex($v));

			switch ($k) {
				case 'secretkey':
					$m_secretkey = $v;
					break;
				case 'charName':
					$m_charName = $v;
					break;
				case 'username':
					$m_username = $v;
					break;
				case 'authkey':
					$m_authkey = $v;
					break;
				case 'iv':
					$m_iv = $v;
					break;
				case 'ScriptKey':
					$m_scriptkey = $v;
					break;
				case 'hwid':
					$m_hwid = $v;
				default:
					break;
			}
		}
	}

	if ($m_hwid != "" && $m_secretkey != "" && $m_charName != "" && $m_username != "" && $m_authkey != "" && $m_iv != "" && $m_scriptkey != "") {
		
	}else{
		print(base64_encode("DATA PROCESSING FAILURE"));
		die();
	}

	//Check IV
	if($iv != $m_iv){
		print(base64_encode("DATA CORRUPTION"));
		die();
	}

	//Get User Auth Status

	$user = "web27628762";
	$host = "localhost";
	$password = "9x7wKi4W";
	$dbname = "usr_web27628762_5";

	try{
	    $conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
	    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	    unset($host);
	    unset($user);
	    unset($password);
	    unset($dbname);

	    $sql_check_if_scriptkey_valid = $conn->prepare("SELECT script_id, is_beta FROM scripts WHERE ScriptKey = :sk");
	    $sql_check_if_scriptkey_valid->bindParam(':sk', $m_scriptkey);
	    $sql_check_if_scriptkey_valid->execute();
	    $sql_check_if_scriptkey_valid_fetched = $sql_check_if_scriptkey_valid->fetchAll();

	    if(sizeof($sql_check_if_scriptkey_valid_fetched) != 1){
	    	print(base64_encode("Invalid Script Key"));
	    	die();
	    }
		
		$return_message = "";
		
		//Check HWID Bans
		$sql_get_is_hwid_banned = $conn->prepare("SELECT id FROM hwid WHERE HWID = :hwid AND is_banned = 1");
		$sql_get_is_hwid_banned->bindParam(":hwid", $m_hwid);
		$sql_get_is_hwid_banned->execute();
		if(sizeof($sql_get_is_hwid_banned->fetchAll()) > 0){
			$return_message = "BANNED||HWID BAN";
		}else{
			//Insert HWID if not exists
			$sql_check_if_hwid_exists = $conn->prepare("SELECT id FROM hwid WHERE HWID = :hwid");
			$sql_check_if_hwid_exists->bindParam(":hwid", $m_hwid);
			$sql_check_if_hwid_exists->execute();
			if (sizeof($sql_check_if_hwid_exists->fetchAll()) == 0){
				$sql_insert_new_hwid = $conn->prepare("INSERT INTO hwid (id, HWID, user, date, is_banned) VALUES ('', :hwid, :user, CURRENT_TIMESTAMP, 0)");
				$sql_insert_new_hwid->bindParam(':hwid', $m_hwid);
				$sql_insert_new_hwid->bindParam(':user', $m_username);
				$sql_insert_new_hwid->execute();
			}
			
			$is_beta = $sql_check_if_scriptkey_valid_fetched[0]["is_beta"];
			if(!$is_beta){
				$sql_does_user_exist = $conn->prepare("SELECT * FROM users WHERE UserName = :uname");
				$sql_does_user_exist->bindParam(':uname', $m_username);
				$sql_does_user_exist->execute();
				$sql_does_user_exist_fetched = $sql_does_user_exist->fetchAll();
				
				$script_id = $sql_check_if_scriptkey_valid_fetched[0]["script_id"];

				
				$user_id = $sql_does_user_exist_fetched[0]["uid"];
				$db_authkey = $sql_does_user_exist_fetched[0]["db_authkey"];
				
				if(sizeof($sql_does_user_exist_fetched) > 0){
					//User exists
					
				}else{
					//User does not exist
					$sql_insert_new_user = $conn->prepare("INSERT INTO users (uid, UserName, db_authkey) VALUES (NULL, :uname, :akey)");
					$sql_insert_new_user->bindParam(':uname', $m_username);
					$sql_insert_new_user->bindParam(':akey', $m_authkey);
					$sql_insert_new_user->execute();
				}
				
				
				$sql_does_user_exist->execute();
				$sql_does_user_exist_fetched = $sql_does_user_exist->fetchAll();
				
				$user_id = $sql_does_user_exist_fetched[0]["uid"];
				$db_authkey = $sql_does_user_exist_fetched[0]["db_authkey"];

				$sql_get_auth_data = $conn->prepare("SELECT * FROM auths WHERE user_id = :uid and script_id = :sid");

				$sql_get_auth_data->bindParam(':uid', $user_id);
				$sql_get_auth_data->bindParam(':sid', $script_id);
				$sql_get_auth_data->execute();
				$sql_get_auth_data_fetched = $sql_get_auth_data->fetchAll();

				if(strlen($db_authkey) == 0){
					$sql_update_auth_key = $conn->prepare("UPDATE users SET db_authkey = :ak WHERE uid = :uid");
					$sql_update_auth_key->bindParam(':ak', $m_authkey);
					$sql_update_auth_key->bindParam(':uid', $user_id);
					$sql_update_auth_key->execute();
				}

				if(sizeof($sql_get_auth_data_fetched) == 0){
					//New Trial
					$sql_insert_new_trial = $conn->prepare("INSERT INTO auths (aid, user_id, script_id, Is_Authed, Is_Trial, Is_Banned, TrialTime) VALUES (NULL, :uid, :sid, false, true, false, :t)");
					$sql_insert_new_trial->bindParam(':uid', $user_id);
					$sql_insert_new_trial->bindParam(':sid', $script_id);
					$time = time()+72*60*60;
					$sql_insert_new_trial->bindParam('t', $time);
					$sql_insert_new_trial->execute();
					$return_message = "TRIAL||".$time;
				}else{
					$is_authed = $sql_get_auth_data_fetched[0]["Is_Authed"];
					$is_trial = $sql_get_auth_data_fetched[0]["Is_Trial"];
					$is_banned = $sql_get_auth_data_fetched[0]["Is_Banned"];
					$trial_time = $sql_get_auth_data_fetched[0]["TrialTime"];
					$ban_reason = $sql_get_auth_data_fetched[0]["BanReason"];
					
					if(strlen($ban_reason) == 0){
						$ban_reason = "Generic ";
					}

					if ($is_banned) {
						$return_message = "BANNED||".$ban_reason;
					}elseif ($is_authed) {
						$return_message = "AUTHED||Good Luck";
					}elseif ($is_trial){
						if($trial_time > time()){
							$return_message = "TRIAL||".$trial_time;
						}else{
							$return_message = "TRIALEX||Trial expired, please buy the Script to continue";
						}
					}else{
						$return_message = "ERROR||Try again";
					}
				}
			}else{
				$return_message = "AUTHED||Welcome to the Beta";
			}
		}
		
	    $return_message .= "||".$m_username."||";
		$hm_ret = hash_hmac('sha256', $return_message, $m_secretkey);
		print(base64_encode("<<<".$hm_ret."||".$return_message));
		

	}catch (PDOException $ex){
	    die(base64_encode("PDOException".$ex->getMessage()));
	}
?>