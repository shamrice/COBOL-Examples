
CREATE DATABASE IF NOT EXISTS cobol_db_example;

\c cobol_db_example ;

DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts ( 
	id serial not null, 
	first_name varchar not null, 
	last_name varchar not null, 
	phone varchar not null, 
	address varchar not null, 
	is_enabled varchar(1) not null default 'N', 
	create_dt timestamp default now(), 
	mod_dt timestamp default now(), 
	primary key (id) 
);

-- Populate fake account data.

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('John', 'Tester', '15555550100', '123 Fake St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Mike', 'Tester1', '15555550121', '122 Real St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Mary', 'Tester2', '15555550132', '121 ABC St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Jack', 'Tester3', '15555550143', '120 Rock St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Bob', 'Tester4', '15555550154', '119 Truck St, Nowhere', 'N', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Paula', 'Tester5', '1555550165', '118 Car St, Nowhere', 'N', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('James', 'Tester6', '1555550176', '117 Land St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Jane', 'Tester7', '1555550187', '116 Sea St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Bill', 'Tester8', '1555550198', '115 Dock St, Nowhere', 'N', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Lucy', 'Tester9', '1555550209', '114 Beach St, Nowhere', 'Y', now(), now());

INSERT INTO accounts (first_name, last_name, phone, address, is_enabled, create_dt, mod_dt)
VALUES ('Richard', 'Tester10', '1555550210', '113 Water St, Nowhere', 'Y', now(), now());





