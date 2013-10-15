set serveroutput on;
set pagesize 1000;
set linesize 1000;

-- Assumes interim table PERFORMANCE_DELETE is already created --


-- Gather statistics on the schema object --
--EXEC DBMS_STATS.gather_table_stats(USER, '&1', cascade => TRUE)

-- Start Redefinition of the tables --
EXEC Dbms_Redefinition.Start_redef_table(USER, '&1', 'PERFORMANCE_DELETE')

-- If done online; sync the tables --
--EXEC DBMS_REDEFINITION.sync_interim_table(USER, '&1', 'PERFORMANCE_DELETE')

-- Finish Redefinition of the tables --
EXEC DBMS_REDEFINITION.finish_redef_table(USER, '&1', 'PERFORMANCE_DELETE')

-- Cleanup data --
DROP TABLE PERFORMANCE_DELETE CASCADE CONSTRAINTS PURGE
/

-- Commit changes --
commit;

-- Gather statistics on the schema object --
EXEC DBMS_STATS.gather_table_stats(USER, '&1', cascade => TRUE)
