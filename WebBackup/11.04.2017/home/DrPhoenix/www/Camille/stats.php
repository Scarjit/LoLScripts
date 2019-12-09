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
	$hmac_key = "E7BD8FDCC2B5427F700E796524EE0E98FF4158C1C";
	$message = $split[0]."||".$split[1];

	$hm = hash_hmac('sha256', $message, $hmac_key);

	if($hmac != $hm){
		print(base64_encode("DATA CORRUPTION"));
		die();
	}


	//DECRYPT
	$iv = $split[0];
	$ciphertext = $split[1];
	$key = "470EA7CEAEB70CF2E58E8CC24201A82D";

	$bin_iv = hex2bin($iv);
	$bin_key = hex2bin($key);
	$bin_cipjer = hex2bin($ciphertext);

	$rawplain = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $bin_key, $bin_cipjer, MCRYPT_MODE_CBC, $bin_iv);
	$x = bin2hex($rawplain);

	$plain = hex2str($x);

	$msg_splits = explode("||", $plain);

	if (sizeof($msg_splits) != 22){
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
	$m_x_session = "";
	
	//freaking stats
	$m_win = "";
	$CHAMPIONS_KILLED = "0";
	$NUM_DEATHS = "0";
	$ASSISTS = "0";
	$MINIONS_KILLED = "0";
	$GOLD_EARNED = "0";
	$PENTA_KILLS = "0";
	$QUADRA_KILLS = "0";
	$TRIPLE_KILLS = "0";
	$DOUBLE_KILLS = "0";
	$TURRETS_KILLED = "0";
	$LARGEST_KILLING_SPREE = "0";
	$level = "0";
	
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
					break;
				case 'x_session':
					$m_x_session = $v;
					break;
				case 'wl':
					$m_win = $v;
					break;
				case 'CHAMPIONS_KILLED':
					$CHAMPIONS_KILLED = $v;
					break;
				case 'NUM_DEATHS':
					$NUM_DEATHS = $v;
					break;
				case 'ASSISTS':
					$ASSISTS = $v;
					break;
				case 'MINIONS_KILLED':
					$MINIONS_KILLED = $v;
					break;
				case 'GOLD_EARNED':
					$GOLD_EARNED = $v;
					break;
				case 'PENTA_KILLS':
					$PENTA_KILLS = $v;
					break;
				case 'QUADRA_KILLS':
					$QUADRA_KILLS = $v;
					break;
				case 'TRIPLE_KILLS':
					$TRIPLE_KILLS = $v;
					break;
				case 'DOUBLE_KILLS':
					$DOUBLE_KILLS = $v;
					break;
				case 'TURRETS_KILLED':
					$TURRETS_KILLED = $v;
					break;
				case 'LARGEST_KILLING_SPREE':
					$LARGEST_KILLING_SPREE = $v;
					break;
				case 'level':
					$level = $v;
					break;
				default:
					break;
			}
		}
	}

	if ($m_hwid != "" && $m_secretkey != "" && $m_charName != "" && $m_username != "" && $m_authkey != "" && $m_iv != "" && $m_scriptkey != "" && $m_win != "" && $m_x_session != "") {
		
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
	$user = "root";
	$host = "localhost";
	$password = "86ajd63a8092_a";
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
		
		$valid_user = false;
		$x_user_id = 0;
		$x_script_id = 0;
		
		//Check HWID Bans
		$sql_get_is_hwid_banned = $conn->prepare("SELECT id FROM hwid WHERE HWID = :hwid AND is_banned = 1");
		$sql_get_is_hwid_banned->bindParam(":hwid", $m_hwid);
		$sql_get_is_hwid_banned->execute();
		if(sizeof($sql_get_is_hwid_banned->fetchAll()) > 0){
			$valid_user = false; //HWID ban
			$x_user_id = 0;
		}else{
			//Insert HWID if not exists
			$sql_check_if_hwid_exists = $conn->prepare("SELECT id FROM hwid WHERE HWID = :hwid");
			$sql_check_if_hwid_exists->bindParam(":hwid", $m_hwid);
			$sql_check_if_hwid_exists->execute();
			if (sizeof($sql_check_if_hwid_exists->fetchAll()) == 0){
				$sql_insert_new_hwid = $conn->prepare("INSERT INTO hwid (id, HWID, user, date, is_banned) VALUES (NULL, :hwid, :user, CURRENT_TIMESTAMP, 0)");
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
				$x_script_id = $script_id;

				
				$user_id = $sql_does_user_exist_fetched[0]["uid"];
				$x_user_id = $user_id;
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
					$sql_insert_new_trial = $conn->prepare("INSERT INTO auths (aid, user_id, script_id, Is_Authed, Is_Trial, Is_Banned, TrialTime,BanReason) VALUES (NULL, :uid, :sid, false, true, false, :t,'')");
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
						$valid_user = false; //BANNED
						$x_user_id = 0;
					}elseif ($is_authed) {
						$valid_user = true; //AUTHED
						$x_user_id = $user_id;
					}elseif ($is_trial){
						if($trial_time > time()){
							$valid_user = true; //TRIAL
							$x_user_id = $user_id;
						}else{
							$valid_user = false; //TRIALEX
							$x_user_id = 0;
						}
					}else{						
						$valid_user = false; //Generic
						$x_user_id = 0;
					}
				}
				
				
				
			}else{				
				$valid_user = false;
			}
		}
		
		//check valid session
		$sql_session_check = $conn->prepare("SELECT * FROM session_keys WHERE uid = :uid AND sid = :sid AND session_key = :skey");
		$sql_session_check->bindParam(':uid', $x_user_id);
		$sql_session_check->bindParam(':sid', $x_script_id);
		$sql_session_check->bindParam(':skey', $m_x_session);
		$sql_session_check->execute();
		$sql_session_check_f = $sql_session_check->fetchAll();
		if(sizeof($sql_session_check_f) == 0){
			die(base64_encode("Invalid Session:\r\n".$m_x_session));
		}else{
			$sql_delete_key = $conn->prepare("DELETE FROM session_keys WHERE uid = :uid AND sid = :sid");
			$sql_delete_key->bindParam(':uid', $x_user_id);
			$sql_delete_key->bindParam(':sid', $x_script_id);
			$sql_delete_key->execute();			
		}
		
		
		if($valid_user == true){
			//$m_win
			$wins_add = 0;
			$looses_add = 0;
			if($m_win == "1"){
				$wins_add = 1;
			}else{
				$looses_add = 1;
			}
			
			//Check if already exists
			$sql_check_if_stat_exists = $conn->prepare("SELECT statid FROM stats WHERE uid = :uid AND sid = :sid");
			$sql_check_if_stat_exists->bindParam(':uid', $x_user_id);
			$sql_check_if_stat_exists->bindParam(':sid', $x_script_id);
			$sql_check_if_stat_exists->execute();
			$sql_check_if_stat_exists_f = $sql_check_if_stat_exists->fetchAll();
			if(sizeof($sql_check_if_stat_exists_f) == 0){
				$sql_insert_new_stat = $conn->prepare("INSERT INTO stats (statid, uid, sid, wins, looses, CHAMPIONS_KILLED, NUM_DEATHS, ASSISTS, MINIONS_KILLED, GOLD_EARNED, PENTA_KILLS, QUADRA_KILLS, TRIPLE_KILLS, DOUBLE_KILLS, TURRETS_KILLED, LARGEST_KILLING_SPREE, level) VALUES (NULL, :uid, :sid, :wins, :looses, :CHAMPIONS_KILLED, :NUM_DEATHS, :ASSISTS, :MINIONS_KILLED, :GOLD_EARNED, :PENTA_KILLS, :QUADRA_KILLS, :TRIPLE_KILLS, :DOUBLE_KILLS, :TURRETS_KILLED, :LARGEST_KILLING_SPREE, :level)");
				$sql_insert_new_stat->bindParam(':uid', $x_user_id);
				$sql_insert_new_stat->bindParam(':sid', $x_script_id);
				$sql_insert_new_stat->bindParam(':wins', $wins_add);
				$sql_insert_new_stat->bindParam(':looses', $looses_add);
				$sql_insert_new_stat->bindParam(':CHAMPIONS_KILLED', $CHAMPIONS_KILLED);
				$sql_insert_new_stat->bindParam(':NUM_DEATHS', $NUM_DEATHS);
				$sql_insert_new_stat->bindParam(':ASSISTS', $ASSISTS);
				$sql_insert_new_stat->bindParam(':MINIONS_KILLED', $MINIONS_KILLED);
				$sql_insert_new_stat->bindParam(':GOLD_EARNED', $GOLD_EARNED);
				$sql_insert_new_stat->bindParam(':PENTA_KILLS', $PENTA_KILLS);
				$sql_insert_new_stat->bindParam(':QUADRA_KILLS', $QUADRA_KILLS);
				$sql_insert_new_stat->bindParam(':TRIPLE_KILLS', $TRIPLE_KILLS);
				$sql_insert_new_stat->bindParam(':DOUBLE_KILLS', $DOUBLE_KILLS);
				$sql_insert_new_stat->bindParam(':TURRETS_KILLED', $TURRETS_KILLED);
				$sql_insert_new_stat->bindParam(':LARGEST_KILLING_SPREE', $LARGEST_KILLING_SPREE);
				$sql_insert_new_stat->bindParam(':level', $level);
				
				$sql_insert_new_stat->execute();
				print(base64_encode("Inserted Win/Looses"));
			}else{
				$sql_update_stats = $conn->prepare("UPDATE stats SET wins = wins + :wins, looses = looses + :looses , CHAMPIONS_KILLED = CHAMPIONS_KILLED + :CHAMPIONS_KILLED, NUM_DEATHS = NUM_DEATHS + :NUM_DEATHS, ASSISTS = ASSISTS + :ASSISTS, MINIONS_KILLED = MINIONS_KILLED + :MINIONS_KILLED, GOLD_EARNED = GOLD_EARNED + :GOLD_EARNED, PENTA_KILLS = PENTA_KILLS + :PENTA_KILLS, QUADRA_KILLS = QUADRA_KILLS + :QUADRA_KILLS, TRIPLE_KILLS = TRIPLE_KILLS + :TRIPLE_KILLS, DOUBLE_KILLS = DOUBLE_KILLS + :DOUBLE_KILLS, TURRETS_KILLED = TURRETS_KILLED + :TURRETS_KILLED, LARGEST_KILLING_SPREE = LARGEST_KILLING_SPREE + :LARGEST_KILLING_SPREE, level = level + :level WHERE uid = :uid AND sid = :sid");
				$sql_update_stats->bindParam(':uid', $x_user_id);
				$sql_update_stats->bindParam(':sid', $x_script_id);
				$sql_update_stats->bindParam(':wins', $wins_add);
				$sql_update_stats->bindParam(':looses', $looses_add);
				$sql_update_stats->bindParam(':CHAMPIONS_KILLED', $CHAMPIONS_KILLED);
				$sql_update_stats->bindParam(':NUM_DEATHS', $NUM_DEATHS);
				$sql_update_stats->bindParam(':ASSISTS', $ASSISTS);
				$sql_update_stats->bindParam(':MINIONS_KILLED', $MINIONS_KILLED);
				$sql_update_stats->bindParam(':GOLD_EARNED', $GOLD_EARNED);
				$sql_update_stats->bindParam(':PENTA_KILLS', $PENTA_KILLS);
				$sql_update_stats->bindParam(':QUADRA_KILLS', $QUADRA_KILLS);
				$sql_update_stats->bindParam(':TRIPLE_KILLS', $TRIPLE_KILLS);
				$sql_update_stats->bindParam(':DOUBLE_KILLS', $DOUBLE_KILLS);
				$sql_update_stats->bindParam(':TURRETS_KILLED', $TURRETS_KILLED);
				$sql_update_stats->bindParam(':LARGEST_KILLING_SPREE', $LARGEST_KILLING_SPREE);
				$sql_update_stats->bindParam(':level', $level);
				$sql_update_stats->execute();
				print(base64_encode("Updated Win/Looses"));
			}
			
		}else{
			print(base64_encode("INVALID USER"));
		}
		
		$conn = null;
		

	}catch (PDOException $ex){
	    die(base64_encode("PDOException".$ex->getMessage()."\r\nLine: ".$ex->getLine()));
	}
?>