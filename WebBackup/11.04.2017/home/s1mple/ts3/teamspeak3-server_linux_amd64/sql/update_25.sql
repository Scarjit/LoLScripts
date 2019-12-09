Delete From bindings where ip = "0.0.0.0";
alter table groups_server add column org_group_id int;
alter table groups_channel add column org_group_id int;
alter table clients add column org_client_id int;
alter table channels add column org_channel_id int;
delete from instance_properties where string_id is null;