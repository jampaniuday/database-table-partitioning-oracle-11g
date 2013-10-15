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
  IF v_par IS NULL THEN
	-- table doesn't exist
	return true;
  ELSIF v_par = 'YES' THEN
    return true;
  ELSE
    return false;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    return true;
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
DBMS_OUTPUT.put_line('-');
select banner into v_banner from v$version where banner like 'Oracle Database%';
DBMS_OUTPUT.put_line('Oracle Version: ' || v_banner);

DBMS_OUTPUT.put_line('-');
select count(*) into v_version from v$version where banner like 'Oracle%11g%11%';
if v_version > 0 then
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                                PASSED');
else
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                               <FAILED>');
  return;
end if;
DBMS_OUTPUT.put_line('-');
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
-- new up.time 6 tables
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_SAMPLE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_AGGREGATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_CLUSTER', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_DATASTORE_USAGE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_DATASTORE_VM_USAGE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_DISK_RATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_ENTITLEMENT', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_HOST_CPU', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_HOST_DISK_IO', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_HOST_DISK_IO_ADV', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_HOST_NETWORK', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_HOST_POWER_STATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_MEM', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_MEM_ADVANCED', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_NETWORK_RATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_CPU', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_DISK_IO', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_NETWORK', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_POWER_STATE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_STORAGE_USAGE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_VM_VCPU', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'VMWARE_PERF_WATTS', cascade => TRUE);
-- new up.time 7 tables
DBMS_STATS.gather_table_stats(USER, 'NET_DEVICE_PERF_SAMPLE', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'NET_DEVICE_PERF_PING', cascade => TRUE);
DBMS_STATS.gather_table_stats(USER, 'NET_DEVICE_PERF_PORT', cascade => TRUE);

--------------------------------------------
-- Check if tables are Not partitioned yet
if isPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_SAMPLE):            <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_SAMPLE):             PASSED');
end if;
if isPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_AGGREGATE):         <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_AGGREGATE):          PASSED');
end if;
if isPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_CPU):               <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_CPU):                PASSED');
end if;
if isPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_DISK):              <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_DISK):               PASSED');
end if;
if isPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_DISK_TOTAL):        <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_DISK_TOTAL):         PASSED');
end if;
if isPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_FSCAP):             <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_FSCAP):              PASSED');
end if;
if isPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_ESX3_WORKLOAD):     <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_ESX3_WORKLOAD):      PASSED');
end if;
if isPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_LPAR_WORKLOAD):     <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_LPAR_WORKLOAD):      PASSED');
end if;
if isPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_NETWORK):           <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_NETWORK):            PASSED');
end if;
if isPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_PSINFO):            <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_PSINFO):             PASSED');
end if;
if isPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_NRM):               <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_NRM):                PASSED');
end if;
if isPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_VXVOL):             <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_VXVOL):              PASSED');
end if;
if isPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_WHO):               <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (PERFORMANCE_WHO):                PASSED');
end if;
if isPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_INT_DATA):                 <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_INT_DATA):                  PASSED');
end if;
if isPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_DECIMAL_DATA):             <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_DECIMAL_DATA):              PASSED');
end if;
if isPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_STRING_DATA):              <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (ERDC_STRING_DATA):               PASSED');
end if;
if isPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (RANGED_OBJECT_VALUE):           <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (RANGED_OBJECT_VALUE):            PASSED');
end if;

-- new up.time 6 tables
if isPartitioned('VMWARE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_SAMPLE):            <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_SAMPLE):             PASSED');
end if;
if isPartitioned('VMWARE_PERF_AGGREGATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_AGGREGATE):         <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_AGGREGATE):          PASSED');
end if;
if isPartitioned('VMWARE_PERF_CLUSTER') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_CLUSTER):           <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_CLUSTER):            PASSED');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_USAGE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DATASTORE_USAGE):   <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DATASTORE_USAGE):    PASSED');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_VM_USAGE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DATASTORE_VM_USAGE):<FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DATASTORE_VM_USAGE): PASSED');
end if;
if isPartitioned('VMWARE_PERF_DISK_RATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DISK_RATE):         <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_DISK_RATE):          PASSED');
end if;
if isPartitioned('VMWARE_PERF_ENTITLEMENT') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_ENTITLEMENT):       <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_ENTITLEMENT):        PASSED');
end if;
if isPartitioned('VMWARE_PERF_HOST_CPU') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_CPU):          <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_CPU):           PASSED');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_DISK_IO):      <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_DISK_IO):       PASSED');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO_ADV') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_DISK_IO_ADV):  <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_DISK_IO_ADV):   PASSED');
end if;
if isPartitioned('VMWARE_PERF_HOST_NETWORK') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_NETWORK):      <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_NETWORK):       PASSED');
end if;
if isPartitioned('VMWARE_PERF_HOST_POWER_STATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_POWER_STATE):  <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_HOST_POWER_STATE):   PASSED');
end if;
if isPartitioned('VMWARE_PERF_MEM') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_MEM):               <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_MEM):                PASSED');
end if;
if isPartitioned('VMWARE_PERF_MEM_ADVANCED') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_MEM_ADVANCED):      <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_MEM_ADVANCED):       PASSED');
end if;
if isPartitioned('VMWARE_PERF_NETWORK_RATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_NETWORK_RATE):      <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_NETWORK_RATE):       PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_CPU') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_CPU):            <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_CPU):             PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_DISK_IO') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_DISK_IO):        <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_DISK_IO):         PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_NETWORK') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_NETWORK):        <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_NETWORK):         PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_POWER_STATE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_POWER_STATE):    <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_POWER_STATE):     PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_STORAGE_USAGE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_STORAGE_USAGE):  <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_STORAGE_USAGE):   PASSED');
end if;
if isPartitioned('VMWARE_PERF_VM_VCPU') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_VCPU):           <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_VM_VCPU):            PASSED');
end if;
if isPartitioned('VMWARE_PERF_WATTS') then
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_WATTS):             <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (VMWARE_PERF_WATTS):              PASSED');
end if;

-- new up.time 7 tables
if isPartitioned('NET_DEVICE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_SAMPLE):        <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_SAMPLE):         PASSED');
end if;
if isPartitioned('NET_DEVICE_PERF_PING') then
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_PING):          <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_PING):           PASSED');
end if;
if isPartitioned('NET_DEVICE_PERF_PORT') then
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_PORT):          <FAILED>');
else
  DBMS_OUTPUT.put_line('Not partitioned yet (NET_DEVICE_PERF_PORT):           PASSED');
end if;

END;
/



select segment_name, tablespace_name, sum(bytes) "bytes", sum(bytes/(1024*1024) ) "MB"
from user_segments
where segment_name not like 'BIN'
and (segment_name like 'PERFORMANCE_%' or segment_name like 'ERDC_%_DATA' or segment_name like 'RANGED_OBJECT_VALUE' or segment_name like 'VMWARE_PERF_%' or segment_name like 'NET_DEVICE_PERF_%')
group by segment_name, tablespace_name
order by sum(bytes) desc
/




-- Cleaning up objects --
DROP FUNCTION isPartitioned
/
DROP FUNCTION NumOfPartitions
/
