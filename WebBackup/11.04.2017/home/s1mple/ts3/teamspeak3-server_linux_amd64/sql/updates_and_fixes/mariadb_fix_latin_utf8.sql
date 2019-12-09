-- script to fix the problem that utf8 data from ts3 client was interpreted as latin1.
-- note that this script requires a user that is allowed to create temporary tables

-- undo latin1->utf8 reencoding of utf8 data
UPDATE channel_properties SET
  ident = CONVERT(CAST(CONVERT(ident USING 'latin1') AS BINARY) USING 'utf8mb4'),
  value = CONVERT(CAST(CONVERT(value USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE client_properties SET
  ident = CONVERT(CAST(CONVERT(ident USING 'latin1') AS BINARY) USING 'utf8mb4'),
  value = CONVERT(CAST(CONVERT(value USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE clients SET
  client_unique_id = CONVERT(CAST(CONVERT(client_unique_id USING 'latin1') AS BINARY) USING 'utf8mb4'),
  client_nickname = CONVERT(CAST(CONVERT(client_nickname USING 'latin1') AS BINARY) USING 'utf8mb4'),
  client_login_name = CONVERT(CAST(CONVERT(client_login_name USING 'latin1') AS BINARY) USING 'utf8mb4'),
  client_login_password = CONVERT(CAST(CONVERT(client_login_password USING 'latin1') AS BINARY) USING 'utf8mb4'),
  client_lastip = CONVERT(CAST(CONVERT(client_lastip USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE groups_channel SET
  name = CONVERT(CAST(CONVERT(name USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE groups_server SET
  name = CONVERT(CAST(CONVERT(name USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE perm_channel SET
  perm_id = CONVERT(CAST(CONVERT(perm_id USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE perm_channel_clients SET
  perm_id = CONVERT(CAST(CONVERT(perm_id USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE perm_channel_groups SET
  perm_id = CONVERT(CAST(CONVERT(perm_id USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE perm_client SET
  perm_id = CONVERT(CAST(CONVERT(perm_id USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE perm_server_group SET
  perm_id = CONVERT(CAST(CONVERT(perm_id USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE bindings SET
  ip = CONVERT(CAST(CONVERT(ip USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE server_properties SET
  ident = CONVERT(CAST(CONVERT(ident USING 'latin1') AS BINARY) USING 'utf8mb4'),
  value = CONVERT(CAST(CONVERT(value USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE servers SET
  server_machine_id = CONVERT(CAST(CONVERT(server_machine_id USING 'latin1') AS BINARY) USING 'utf8mb4');
  
UPDATE tokens SET
  token_key = CONVERT(CAST(CONVERT(token_key USING 'latin1') AS BINARY) USING 'utf8mb4'),
  token_description = CONVERT(CAST(CONVERT(token_description USING 'latin1') AS BINARY) USING 'utf8mb4'),
  token_customset = CONVERT(CAST(CONVERT(token_customset USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE messages SET
  message_from_client_uid = CONVERT(CAST(CONVERT(message_from_client_uid USING 'latin1') AS BINARY) USING 'utf8mb4'),
  message_subject = CONVERT(CAST(CONVERT(message_subject USING 'latin1') AS BINARY) USING 'utf8mb4'),
  message_msg = CONVERT(CAST(CONVERT(message_msg USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE complains SET
  complain_message = CONVERT(CAST(CONVERT(complain_message USING 'latin1') AS BINARY) USING 'utf8mb4'),
  complain_hash = CONVERT(CAST(CONVERT(complain_hash USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE bans SET
  ban_ip = CONVERT(CAST(CONVERT(ban_ip USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_name = CONVERT(CAST(CONVERT(ban_name USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_uid = CONVERT(CAST(CONVERT(ban_uid USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_invoker_uid = CONVERT(CAST(CONVERT(ban_invoker_uid USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_invoker_name = CONVERT(CAST(CONVERT(ban_invoker_name USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_reason = CONVERT(CAST(CONVERT(ban_reason USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ban_hash = CONVERT(CAST(CONVERT(ban_hash USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE instance_properties SET
  string_id = CONVERT(CAST(CONVERT(string_id USING 'latin1') AS BINARY) USING 'utf8mb4'),
  ident = CONVERT(CAST(CONVERT(ident USING 'latin1') AS BINARY) USING 'utf8mb4'),
  value = CONVERT(CAST(CONVERT(value USING 'latin1') AS BINARY) USING 'utf8mb4');

UPDATE custom_fields SET
  ident = CONVERT(CAST(CONVERT(ident USING 'latin1') AS BINARY) USING 'utf8mb4'),
  value = CONVERT(CAST(CONVERT(value USING 'latin1') AS BINARY) USING 'utf8mb4');
  
-- deduplicate server and channelgroup names that could have occured because of truncation
CREATE TEMPORARY TABLE groups_server_dups ENGINE=MEMORY AS (select server_id, name from groups_server group by server_id, name having count(*)>1);

UPDATE groups_server u
    INNER JOIN groups_server_dups j ON
    j.server_id = u.server_id and j.name=u.name
    SET u.name = CONCAT(u.name,u.group_id);

DROP TABLE groups_server_dups;

CREATE TEMPORARY TABLE groups_channel_dups ENGINE=MEMORY AS (select server_id, name from groups_channel group by server_id, name having count(*)>1);

UPDATE groups_channel u
    INNER JOIN groups_channel_dups j ON
    j.server_id = u.server_id and j.name=u.name
    SET u.name = CONCAT(u.name,u.group_id);

DROP TABLE groups_channel_dups;
