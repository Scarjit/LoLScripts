select distinct c.client_id, c.server_id from 
(clients c left outer join group_server_to_client g on g.id1=c.client_id join servers s on s.server_id=c.server_id) 
where 
g.id1 is NULL and 
s.server_machine_id=:server_machine_id: and 
c.server_id != 0 and 
c.client_unique_id != "ServerQuery" and 
c.client_lastconnected < :timestamp: 
limit 100;