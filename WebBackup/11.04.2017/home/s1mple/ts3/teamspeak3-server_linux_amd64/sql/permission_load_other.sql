 select 1 as table_type, id1, id2, perm_id, perm_negated, perm_skip, perm_value from perm_client where server_id=:server_id: union
 select 2 as table_type, id1, id2, perm_id, perm_negated, perm_skip, perm_value from perm_channel where server_id=:server_id:  union
 select 4 as table_type, id1, id2, perm_id, perm_negated, perm_skip, perm_value from perm_channel_clients where server_id=:server_id:;
