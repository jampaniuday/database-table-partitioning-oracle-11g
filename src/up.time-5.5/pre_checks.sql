set serveroutput on;
set pagesize 1000;
set linesize 1000;
-- http://www.oracle-base.com/articles/misc/PartitioningAnExistingTable.php --
---------------------
-- NumOfPartitions --
---------------------
CREATE OR REPLACE FUNCTION NumOfPartitions (v_table_name IN VARCHAR2) RETURN NUMBER IS
v_count number;
BEGIN
  select count(*) into v_count from user_tab_partitions where table_name = v_table_name;
  return v_count;
END NumOfPartitions;
/
-------------------
-- isPartitioned --
-------------------
CREATE OR REPLACE FUNCTION isPartitioned (v_table_name IN VARCHAR2) RETURN BOOLEAN IS
v_par varchar2(5);
BEGIN
  SELECT partitioned INTO v_par FROM user_tables WHERE table_name = v_table_name;
  IF v_par = 'YES' THEN
    return true;
  ELSE
    return false;
  END IF;
END isPartitioned;
/
----------------
-- Run Checks --
----------------
DECLARE
  v_banner   varchar2(80);
  v_version  number;
BEGIN
--------------------------------------------
select banner into v_banner from v$version where banner like 'Oracle Database%';
DBMS_OUTPUT.put_line('Oracle Version: ' || v_banner);

select count(*) into v_version from v$version where banner like 'Oracle%11g%11%';
if v_version > 0 then
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                    PASSED');
else
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                    FAILED');
  return;
end if;
--------------------------------------------

-- Gather stats on all performance tables --
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_SAMPLE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_AGGREGATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_CPU', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_DISK', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_DISK_TOTAL', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_ESX3_WORKLOAD', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_FSCAP', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_LPAR_WORKLOAD', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_NETWORK', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_NRM', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_PSINFO', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_VXVOL', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'PERFORMANCE_WHO', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'ERDC_INT_DATA', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'ERDC_DECIMAL_DATA', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'ERDC_STRING_DATA', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'RANGED_OBJECT_VALUE', cascade => TRUE);

--------------------------------------------
-- Check if tables are partitioned already
if isPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_sample):        FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_sample):        PASSED');
end if;
if isPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_aggregate):     FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_aggregate):     PASSED');
end if;
if isPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_cpu):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_cpu):           PASSED');
end if;
if isPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk):          FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk):          PASSED');
end if;
if isPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk_total):    FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk_total):          PASSED');
end if;
if isPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_fscap):         FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_fscap):         PASSED');
end if;
if isPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_esx3_workload): FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_esx3_workload): PASSED');
end if;
if isPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_lpar_workload): FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_lpar_workload): PASSED');
end if;
if isPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_network):       FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_network):       PASSED');
end if;
if isPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_psinfo):        FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_psinfo):        PASSED');
end if;
if isPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_nrm):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_nrm):           PASSED');
end if;
if isPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_vxvol):         FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_vxvol):         PASSED');
end if;
if isPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_who):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_who):           PASSED');
end if;
if isPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_int_data):      FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_int_data):      PASSED');
end if;
if isPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_decimal_data):  FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_decimal_data):  PASSED');
end if;
if isPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_string_data):   FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_string_data):   PASSED');
end if;
if isPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('Partitioned already (ranged_object_value):FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (ranged_object_value):PASSED');
end if;
END;
/



select segment_name, tablespace_name, sum(bytes) "bytes", sum(bytes/(1024*1024) ) "MB"
from user_segments
where segment_name not like 'BIN'
and (segment_name like 'PERFORMANCE_%' or segment_name like 'ERDC_%_DATA' or segment_name like 'RANGED_OBJECT_VALUE')
group by segment_name, tablespace_name
order by sum(bytes) desc
/




-- Cleaning up objects --
DROP FUNCTION isPartitioned
/
DROP FUNCTION NumOfPartitions
/
