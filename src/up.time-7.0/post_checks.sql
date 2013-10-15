set serveroutput on;
set pagesize 1000;
set linesize 1000;
-- http://www.oracle-base.com/articles/misc/PartitioningAnExistingTable.php --

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
BEGIN

--------------------------------------------

-- Check if tables are Not partitioned yet
if isPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('PERFORMANCE_SAMPLE is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_SAMPLE there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('PERFORMANCE_AGGREGATE is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_AGGREGATE there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('PERFORMANCE_CPU is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_CPU there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK_TOTAL is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK_TOTAL there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('PERFORMANCE_FSCAP is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_FSCAP there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('PERFORMANCE_ESX3_WORKLOAD is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_ESX3_WORKLOAD there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('PERFORMANCE_LPAR_WORKLOAD is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_LPAR_WORKLOAD there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('PERFORMANCE_NETWORK is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_NETWORK there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('PERFORMANCE_PSINFO is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_PSINFO there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('PERFORMANCE_NRM is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_NRM there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('PERFORMANCE_VXVOL is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_VXVOL there was an ERROR well partitioning');
end if;
if isPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('PERFORMANCE_WHO is partitioned');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_WHO there was an ERROR well partitioning');
end if;
if isPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('ERDC_INT_DATA is partitioned');
else
  DBMS_OUTPUT.put_line('ERDC_INT_DATA there was an ERROR well partitioning');
end if;
if isPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('ERDC_DECIMAL_DATA is partitioned');
else
  DBMS_OUTPUT.put_line('ERDC_DECIMAL_DATA there was an ERROR well partitioning');
end if;
if isPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('ERDC_STRING_DATA is partitioned');
else
  DBMS_OUTPUT.put_line('ERDC_STRING_DATA there was an ERROR well partitioning');
end if;
if isPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('RANGED_OBJECT_VALUE is partitioned');
else
  DBMS_OUTPUT.put_line('RANGED_OBJECT_VALUE there was an ERROR well partitioning');
end if;

-- new up.time 6 tables
if isPartitioned('VMWARE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_SAMPLE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_SAMPLE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_AGGREGATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_AGGREGATE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_AGGREGATE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_CLUSTER') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_CLUSTER is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_CLUSTER there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_USAGE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_USAGE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_VM_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_VM_USAGE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_VM_USAGE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_DISK_RATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DISK_RATE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DISK_RATE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_ENTITLEMENT') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_ENTITLEMENT is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_ENTITLEMENT there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_HOST_CPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_CPU is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_CPU there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO_ADV') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO_ADV is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO_ADV there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_HOST_NETWORK') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_NETWORK is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_NETWORK there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_HOST_POWER_STATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_POWER_STATE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_POWER_STATE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_MEM') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_MEM_ADVANCED') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM_ADVANCED is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM_ADVANCED there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_NETWORK_RATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_NETWORK_RATE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_NETWORK_RATE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_CPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_CPU is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_CPU there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_DISK_IO') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_DISK_IO is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_DISK_IO there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_NETWORK') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_NETWORK is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_NETWORK there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_POWER_STATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_POWER_STATE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_POWER_STATE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_STORAGE_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_STORAGE_USAGE is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_STORAGE_USAGE there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_VM_VCPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_VCPU is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_VCPU there was an ERROR well partitioning');
end if;
if isPartitioned('VMWARE_PERF_WATTS') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_WATTS is partitioned');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_WATTS there was an ERROR well partitioning');
end if;

-- new up.time 7 tables
if isPartitioned('NET_DEVICE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_SAMPLE is partitioned');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_SAMPLE there was an ERROR well partitioning');
end if;
if isPartitioned('NET_DEVICE_PERF_PING') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PING is partitioned');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PING there was an ERROR well partitioning');
end if;
if isPartitioned('NET_DEVICE_PERF_PORT') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PORT is partitioned');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PORT there was an ERROR well partitioning');
end if;

END;
/


-- Cleaning up objects --
DROP FUNCTION isPartitioned
/

