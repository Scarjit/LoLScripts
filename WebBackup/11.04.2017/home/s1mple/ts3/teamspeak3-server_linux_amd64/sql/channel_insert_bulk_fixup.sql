replace into channels(channel_id, server_id, channel_parent_id, org_channel_id) 
 select A.channel_id, A.server_id, B.channel_id, A.org_channel_id from channels A join channels B on B.org_channel_id = A.channel_parent_id
 where A.server_id=:server_id: and B.server_id=:server_id: and A.channel_parent_id <> 0;