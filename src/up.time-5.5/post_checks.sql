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
-- isNotPartitioned --
-------------------
CREATE OR REPLACE FUNCTION isNotPartitioned (v_table_name IN VARCHAR2) RETURN BOOLEAN IS
v_par varchar2(5);
BEGIN
  SELECT partitioned INTO v_par FROM user_tables WHERE table_name = v_table_name;
  IF v_par = 'YES' THEN
    return false;
  ELSE
    return true;
  END IF;
END isNotPartitioned;
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
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                    Passed');
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
if isNotPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_sample):        FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_sample):        Passed');
end if;
if isNotPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_aggregate):     FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_aggregate):     Passed');
end if;
if isNotPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_cpu):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_cpu):           Passed');
end if;
if isNotPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk):          FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk):          Passed');
end if;
if isNotPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk_total):    FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_disk_total):    Passed');
end if;
if isNotPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_fscap):         FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_fscap):         Passed');
end if;
if isNotPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_esx3_workload): FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_esx3_workload): Passed');
end if;
if isNotPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_lpar_workload): FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_lpar_workload): Passed');
end if;
if isNotPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_network):       FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_network):       Passed');
end if;
if isNotPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_psinfo):        FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_psinfo):        Passed');
end if;
if isNotPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_nrm):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_nrm):           Passed');
end if;
if isNotPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_vxvol):         FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_vxvol):         Passed');
end if;
if isNotPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('Partitioned already (perf_who):           FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (perf_who):           Passed');
end if;
if isNotPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_int_data):      FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_int_data):      Passed');
end if;
if isNotPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_decimal_data):  FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_decimal_data):  Passed');
end if;
if isNotPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('Partitioned already (erdc_string_data):   FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (erdc_string_data):   Passed');
end if;
if isNotPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('Partitioned already (ranged_object_value):FAILED');
else
  DBMS_OUTPUT.put_line('Partitioned already (ranged_object_value):Passed');
end if;

DBMS_OUTPUT.put_line('Partitions (performance_sample):          ' || NumOfPartitions('PERFORMANCE_SAMPLE'));
DBMS_OUTPUT.put_line('Partitions (performance_aggregate):       ' || NumOfPartitions('PERFORMANCE_AGGREGATE'));
DBMS_OUTPUT.put_line('Partitions (performance_cpu):             ' || NumOfPartitions('PERFORMANCE_CPU'));
DBMS_OUTPUT.put_line('Partitions (performance_disk):            ' || NumOfPartitions('PERFORMANCE_DISK'));
DBMS_OUTPUT.put_line('Partitions (performance_disk_total):      ' || NumOfPartitions('PERFORMANCE_DISK_TOTAL'));
DBMS_OUTPUT.put_line('Partitions (performance_esx3_workload):   ' || NumOfPartitions('PERFORMANCE_ESX3_WORKLOAD'));
DBMS_OUTPUT.put_line('Partitions (performance_fscap):           ' || NumOfPartitions('PERFORMANCE_FSCAP'));
DBMS_OUTPUT.put_line('Partitions (performance_lpar_workload):   ' || NumOfPartitions('PERFORMANCE_LPAR_WORKLOAD'));
DBMS_OUTPUT.put_line('Partitions (performance_network):         ' || NumOfPartitions('PERFORMANCE_NETWORK'));
DBMS_OUTPUT.put_line('Partitions (performance_nrm):             ' || NumOfPartitions('PERFORMANCE_NRM'));
DBMS_OUTPUT.put_line('Partitions (performance_psinfo):          ' || NumOfPartitions('PERFORMANCE_PSINFO'));
DBMS_OUTPUT.put_line('Partitions (performance_vxvol):           ' || NumOfPartitions('PERFORMANCE_VXVOL'));
DBMS_OUTPUT.put_line('Partitions (performance_who):             ' || NumOfPartitions('PERFORMANCE_WHO'));
DBMS_OUTPUT.put_line('Partitions (erdc_int_data):               ' || NumOfPartitions('ERDC_INT_DATA'));
DBMS_OUTPUT.put_line('Partitions (erdc_decimal_data):           ' || NumOfPartitions('ERDC_DECIMAL_DATA'));
DBMS_OUTPUT.put_line('Partitions (erdc_string_data):            ' || NumOfPartitions('ERDC_STRING_DATA'));
DBMS_OUTPUT.put_line('Partitions (ranged_object_value):         ' || NumOfPartitions('OBJECT_RANGED_VALUE'));

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
DROP FUNCTION isNotPartitioned
/
DROP FUNCTION NumOfPartitions
/
