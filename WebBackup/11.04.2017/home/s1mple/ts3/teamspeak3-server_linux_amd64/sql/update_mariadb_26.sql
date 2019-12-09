alter table clients modify column client_lastip varchar(45);
alter table  bindings modify column ip varchar(45) NOT NULL;