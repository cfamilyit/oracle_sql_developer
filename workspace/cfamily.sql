-- DCL
alter session set "_ORACLE_SCRIPT"=true; 
create user swathi identified by swathi;

conn swathi/swathi;

conn cfamily/cfamily;
grant create session to swathi;
conn swathi/swathi;

desc role_sys_privs;
select ROLE,PRIVILEGE from role_sys_privs;









