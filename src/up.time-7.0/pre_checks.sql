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


-- Check if tables are Not partitioned yet
if isPartitioned('PERFORMANCE_SAMPLE') then
  DBMS_OUTPUT.put_line('PERFORMANCE_SAMPLE is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_SAMPLE needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_AGGREGATE') then
  DBMS_OUTPUT.put_line('PERFORMANCE_AGGREGATE is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_AGGREGATE needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_CPU') then
  DBMS_OUTPUT.put_line('PERFORMANCE_CPU is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_CPU needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_DISK') then
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_DISK_TOTAL') then
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK_TOTAL is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_DISK_TOTAL needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_FSCAP') then
  DBMS_OUTPUT.put_line('PERFORMANCE_FSCAP is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_FSCAP needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_ESX3_WORKLOAD') then
  DBMS_OUTPUT.put_line('PERFORMANCE_ESX3_WORKLOAD is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_ESX3_WORKLOAD needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_LPAR_WORKLOAD') then
  DBMS_OUTPUT.put_line('PERFORMANCE_LPAR_WORKLOAD is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_LPAR_WORKLOAD needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_NETWORK') then
  DBMS_OUTPUT.put_line('PERFORMANCE_NETWORK is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_NETWORK needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_PSINFO') then
  DBMS_OUTPUT.put_line('PERFORMANCE_PSINFO is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_PSINFO needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_NRM') then
  DBMS_OUTPUT.put_line('PERFORMANCE_NRM is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_NRM needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_VXVOL') then
  DBMS_OUTPUT.put_line('PERFORMANCE_VXVOL is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_VXVOL needs to be partitioned still');
end if;
if isPartitioned('PERFORMANCE_WHO') then
  DBMS_OUTPUT.put_line('PERFORMANCE_WHO is partitioned already');
else
  DBMS_OUTPUT.put_line('PERFORMANCE_WHO needs to be partitioned still');
end if;
if isPartitioned('ERDC_INT_DATA') then
  DBMS_OUTPUT.put_line('ERDC_INT_DATA is partitioned already');
else
  DBMS_OUTPUT.put_line('ERDC_INT_DATA needs to be partitioned still');
end if;
if isPartitioned('ERDC_DECIMAL_DATA') then
  DBMS_OUTPUT.put_line('ERDC_DECIMAL_DATA is partitioned already');
else
  DBMS_OUTPUT.put_line('ERDC_DECIMAL_DATA needs to be partitioned still');
end if;
if isPartitioned('ERDC_STRING_DATA') then
  DBMS_OUTPUT.put_line('ERDC_STRING_DATA is partitioned already');
else
  DBMS_OUTPUT.put_line('ERDC_STRING_DATA needs to be partitioned still');
end if;
if isPartitioned('RANGED_OBJECT_VALUE') then
  DBMS_OUTPUT.put_line('RANGED_OBJECT_VALUE is partitioned already');
else
  DBMS_OUTPUT.put_line('RANGED_OBJECT_VALUE needs to be partitioned still');
end if;

-- new up.time 6 tables
if isPartitioned('VMWARE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_SAMPLE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_SAMPLE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_AGGREGATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_AGGREGATE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_AGGREGATE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_CLUSTER') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_CLUSTER is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_CLUSTER needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_USAGE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_USAGE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_DATASTORE_VM_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_VM_USAGE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DATASTORE_VM_USAGE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_DISK_RATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_DISK_RATE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_DISK_RATE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_ENTITLEMENT') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_ENTITLEMENT is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_ENTITLEMENT needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_HOST_CPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_CPU is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_CPU needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_HOST_DISK_IO_ADV') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO_ADV is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_DISK_IO_ADV needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_HOST_NETWORK') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_NETWORK is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_NETWORK needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_HOST_POWER_STATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_POWER_STATE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_HOST_POWER_STATE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_MEM') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_MEM_ADVANCED') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM_ADVANCED is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_MEM_ADVANCED needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_NETWORK_RATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_NETWORK_RATE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_NETWORK_RATE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_CPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_CPU is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_CPU needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_DISK_IO') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_DISK_IO is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_DISK_IO needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_NETWORK') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_NETWORK is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_NETWORK needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_POWER_STATE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_POWER_STATE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_POWER_STATE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_STORAGE_USAGE') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_STORAGE_USAGE is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_STORAGE_USAGE needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_VM_VCPU') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_VCPU is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_VM_VCPU needs to be partitioned still');
end if;
if isPartitioned('VMWARE_PERF_WATTS') then
  DBMS_OUTPUT.put_line('VMWARE_PERF_WATTS is partitioned already');
else
  DBMS_OUTPUT.put_line('VMWARE_PERF_WATTS needs to be partitioned still');
end if;

-- new up.time 7 tables
if isPartitioned('NET_DEVICE_PERF_SAMPLE') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_SAMPLE is partitioned already');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_SAMPLE needs to be partitioned still');
end if;
if isPartitioned('NET_DEVICE_PERF_PING') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PING is partitioned already');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PING needs to be partitioned still');
end if;
if isPartitioned('NET_DEVICE_PERF_PORT') then
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PORT is partitioned already');
else
  DBMS_OUTPUT.put_line('NET_DEVICE_PERF_PORT needs to be partitioned still');
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

