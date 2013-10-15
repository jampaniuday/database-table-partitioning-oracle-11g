set serveroutput on;
set pagesize 1000;
set linesize 1000;


-- NOTE: THIS MUST BE DONE IN THE FOLLOWING ORDER:
-- 1. CREATE NEW SAMPLE TABLE (BUT NONE OF THE DEPENDENTS)
-- 2. CONVERT SAMPLE TABLE
-- 3. CREATE DEPENDENT (SUB) TABLES
-- 4. CONVERT DEPENDENT (SUB) TABLES


-- Convert SAMPLE tables to Partitioned Tables --
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_SAMPLE VMWP_SAMPLE_PAR
@@sub_convert_upgrade_from_v5.5.sql NET_DEVICE_PERF_SAMPLE NET_DP_SAMPLE_PAR


-- Create the rest of the tables
@@sub_create_upgrade_from_v5.5.sql


-- Convert to Partitioned Table --
-- up.time 6.0 tables
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_AGGREGATE VMWP_AGGREGATE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_CLUSTER VMWP_CLUSTER_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_DATASTORE_USAGE VMWP_DATASTORE_USAGE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_DATASTORE_VM_USAGE VMWP_DATASTORE_VM_USAGE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_DISK_RATE VMWP_DISK_RATE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_ENTITLEMENT VMWP_ENTITLEMENT_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_HOST_CPU VMWP_HOST_CPU_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_HOST_DISK_IO VMWP_HOST_DISK_IO_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_HOST_DISK_IO_ADV VMWP_HOST_DISK_IO_ADV_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_HOST_NETWORK VMWP_HOST_NETWORK_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_HOST_POWER_STATE VMWP_HOST_POWER_STATE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_MEM VMWP_MEM_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_MEM_ADVANCED VMWP_MEM_ADVANCED_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_NETWORK_RATE VMWP_NETWORK_RATE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_CPU VMWP_VM_CPU_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_DISK_IO VMWP_VM_DISK_IO_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_NETWORK VMWP_VM_NETWORK_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_POWER_STATE VMWP_VM_POWER_STATE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_STORAGE_USAGE VMWP_VM_STORAGE_USAGE_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_VM_VCPU VMWP_VM_VCPU_PAR
@@sub_convert_upgrade_from_v5.5.sql VMWARE_PERF_WATTS VMWP_WATTS_PAR
-- up.time 7.0 tables
@@sub_convert_upgrade_from_v5.5.sql NET_DEVICE_PERF_PING NET_DP_PING_PAR
@@sub_convert_upgrade_from_v5.5.sql NET_DEVICE_PERF_PORT NET_DP_PORT_PAR
