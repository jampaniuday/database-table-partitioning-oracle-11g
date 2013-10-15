set serveroutput on;
set pagesize 1000;
set linesize 1000;

-- &1 is the original table name (performance_sample)
-- &2 is the new table name (performance_sample_par)
-- Assumes table &2 is already created --

-- Check if table can be redefined
--EXEC DBMS_REDEFINITION.Can_Redef_Table(USER, '&1');

-- Gather statistics on the schema object --
--EXEC DBMS_STATS.gather_table_stats(USER, '&1', cascade => TRUE);

-- Start Redefinition of the tables --
EXEC DBMS_REDEFINITION.Start_redef_table(USER, '&1', '&2');

-- If done online; sync the tables --
--EXEC DBMS_REDEFINITION.sync_interim_table(USER, '&1', '&2');

-- Finish Redefinition of the tables --
EXEC DBMS_REDEFINITION.finish_redef_table(USER, '&1', '&2');

-- Cleanup data --
DROP TABLE &2 CASCADE CONSTRAINTS PURGE
/
-- Commit changes --
COMMIT
/

-- Gather statistics on the schema object --
EXEC DBMS_STATS.gather_table_stats(USER, '&1', cascade => TRUE);
