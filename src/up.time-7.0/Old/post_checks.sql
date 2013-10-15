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
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                                    PASSED');
else
  DBMS_OUTPUT.put_line('Oracle Version >= 11g:                                    <FAILED>');
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
-- Check if tables are Partitioned successfully
if isPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_SAMPLE):            PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_SAMPLE):            <FAILED>');
end if;
if isPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_AGGREGATE):         PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_AGGREGATE):         <FAILED>');
end if;
if isPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_CPU):               PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_CPU):               <FAILED>');
end if;
if isPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_DISK):              PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_DISK):              <FAILED>');
end if;
if isPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_DISK_TOTAL):        PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_DISK_TOTAL):        <FAILED>');
end if;
if isPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_FSCAP):             PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_FSCAP):             <FAILED>');
end if;
if isPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_ESX3_WORKLOAD):     PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_ESX3_WORKLOAD):     <FAILED>');
end if;
if isPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_LPAR_WORKLOAD):     PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_LPAR_WORKLOAD):     <FAILED>');
end if;
if isPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_NETWORK):           PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_NETWORK):           <FAILED>');
end if;
if isPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_PSINFO):            PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_PSINFO):            <FAILED>');
end if;
if isPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_NRM):               PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_NRM):               <FAILED>');
end if;
if isPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_VXVOL):             PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_VXVOL):             <FAILED>');
end if;
if isPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_WHO):               PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (PERFORMANCE_WHO):               <FAILED>');
end if;
if isPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_INT_DATA):                 PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_INT_DATA):                 <FAILED>');
end if;
if isPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_DECIMAL_DATA):             PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_DECIMAL_DATA):             <FAILED>');
end if;
if isPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_STRING_DATA):              PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (ERDC_STRING_DATA):              <FAILED>');
end if;
if isPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (RANGED_OBJECT_VALUE):           PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (RANGED_OBJECT_VALUE):           <FAILED>');
end if;

-- new up.time 6 tables
if isPartitioned('VMWARE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_SAMPLE):            PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_SAMPLE):            <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_AGGREGATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_AGGREGATE):         PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_AGGREGATE):         <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_CLUSTER') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_CLUSTER):           PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_CLUSTER):           <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_USAGE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DATASTORE_USAGE):   PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DATASTORE_USAGE):   <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_VM_USAGE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DATASTORE_VM_USAGE):PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DATASTORE_VM_USAGE):<FAILED>');
end if;
if isPartitioned('VMWARE_PERF_DISK_RATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DISK_RATE):         PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_DISK_RATE):         <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_ENTITLEMENT') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_ENTITLEMENT):       PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_ENTITLEMENT):       <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_HOST_CPU') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_CPU):          PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_CPU):          <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_DISK_IO):      PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_DISK_IO):      <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO_ADV') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_DISK_IO_ADV):  PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_DISK_IO_ADV):  <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_HOST_NETWORK') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_NETWORK):      PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_NETWORK):      <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_HOST_POWER_STATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_POWER_STATE):  PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_HOST_POWER_STATE):  <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_MEM') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_MEM):               PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_MEM):               <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_MEM_ADVANCED') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_MEM_ADVANCED):      PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_MEM_ADVANCED):      <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_NETWORK_RATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_NETWORK_RATE):      PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_NETWORK_RATE):      <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_CPU') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_CPU):            PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_CPU):            <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_DISK_IO') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_DISK_IO):        PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_DISK_IO):        <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_NETWORK') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_NETWORK):        PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_NETWORK):        <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_POWER_STATE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_POWER_STATE):    PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_POWER_STATE):    <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_STORAGE_USAGE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_STORAGE_USAGE):  PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_STORAGE_USAGE):  <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_VM_VCPU') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_VCPU):           PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_VM_VCPU):           <FAILED>');
end if;
if isPartitioned('VMWARE_PERF_WATTS') then
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_WATTS):             PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (VMWARE_PERF_WATTS):             <FAILED>');
end if;

-- new up.time 7 tables
if isPartitioned('NET_DEVICE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_SAMPLE):        PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_SAMPLE):        <FAILED>');
end if;
if isPartitioned('NET_DEVICE_PERF_PING') then
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_PING):          PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_PING):          <FAILED>');
end if;
if isPartitioned('NET_DEVICE_PERF_PORT') then
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_PORT):          PASSED');
else
  DBMS_OUTPUT.put_line('Partitioned successfully (NET_DEVICE_PERF_PORT):          <FAILED>');
end if;

END;
/


-- Cleaning up objects --
DROP FUNCTION isPartitioned
/
DROP FUNCTION NumOfPartitions
/
