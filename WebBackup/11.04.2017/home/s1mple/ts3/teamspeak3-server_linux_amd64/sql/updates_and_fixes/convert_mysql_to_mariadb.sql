-- fix some issues from the past that hinder conversion here:
ALTER TABLE channel_properties MODIFY ident VARCHAR(255), MODIFY value VARCHAR(8192);

-- do the actual conversions
ALTER TABLE channel_properties CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE channel_properties;
OPTIMIZE TABLE channel_properties;

ALTER TABLE channels CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE channels;
OPTIMIZE TABLE channels;

ALTER TABLE client_properties CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE client_properties;
OPTIMIZE TABLE client_properties;

ALTER TABLE clients CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE clients;
OPTIMIZE TABLE clients;

ALTER TABLE groups_channel CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE groups_channel;
OPTIMIZE TABLE groups_channel;

ALTER TABLE groups_server CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE groups_server;
OPTIMIZE TABLE groups_server;

ALTER TABLE group_server_to_client CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE group_server_to_client;
OPTIMIZE TABLE group_server_to_client;

ALTER TABLE group_channel_to_client CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE group_channel_to_client;
OPTIMIZE TABLE group_channel_to_client;

ALTER TABLE perm_channel CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE perm_channel;
OPTIMIZE TABLE perm_channel;

ALTER TABLE perm_channel_clients CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE perm_channel_clients;
OPTIMIZE TABLE perm_channel_clients;

ALTER TABLE perm_channel_groups CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE perm_channel_groups;
OPTIMIZE TABLE perm_channel_groups;

ALTER TABLE perm_client CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE perm_client;
OPTIMIZE TABLE perm_client;

ALTER TABLE perm_server_group CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE perm_server_group;
OPTIMIZE TABLE perm_server_group;

ALTER TABLE bindings CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE bindings;
OPTIMIZE TABLE bindings;

ALTER TABLE server_properties CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE server_properties;
OPTIMIZE TABLE server_properties;

ALTER TABLE servers CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE servers;
OPTIMIZE TABLE servers;

ALTER TABLE tokens CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE tokens;
OPTIMIZE TABLE tokens;

ALTER TABLE messages CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE messages;
OPTIMIZE TABLE messages;

ALTER TABLE complains CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE complains;
OPTIMIZE TABLE complains;

ALTER TABLE bans CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE bans;
OPTIMIZE TABLE bans;

ALTER TABLE instance_properties CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE instance_properties;
OPTIMIZE TABLE instance_properties;

ALTER TABLE custom_fields CONVERT TO CHARACTER SET 'utf8mb4', DEFAULT CHARACTER SET 'utf8mb4';
REPAIR TABLE custom_fields;
OPTIMIZE TABLE custom_fields;

CREATE TABLE teamspeak3_metadata(
  ident varchar(100) NOT NULL UNIQUE,
  value varchar(255)
) CHARACTER SET 'utf8mb4';

INSERT INTO teamspeak3_metadata(ident,value) VALUES('mysql5.5_ready', '1');
