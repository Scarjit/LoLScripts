 select client_id as id, 'client_unique_id' as ident, client_unique_id as value from clients where server_id=:server_id: union
 select client_id as id, 'client_nickname' as ident, client_nickname as value from clients  where server_id=:server_id: union
 select id, ident, value from client_properties where server_id=:server_id: 
 order by id;