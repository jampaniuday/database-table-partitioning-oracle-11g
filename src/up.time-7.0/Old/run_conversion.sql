set serveroutput on;
set pagesize 1000;
set linesize 1000;


---------------------------------
-- Start of PERFORMANCE_SAMPLE --
-- drop indexes
--drop index uptimehost_id
--/
--drop index sample_erdc_id
--/
--drop index latest_sample
--/
--drop index latest_sample_by_host
--/
-------------------------------
-- End of PERFORMANCE_SAMPLE --
-------------------------------

-- NOTE: THIS MUST BE DONE IN THE FOLLOWING ORDER:
-- 1. CREATE NEW SAMPLE TABLE (BUT NONE OF THE DEPENDENTS)
-- 2. CONVERT SAMPLE TABLE
-- 3. CREATE DEPENDENT (SUB) TABLES
-- 4. CONVERT DEPENDENT (SUB) TABLES

-- Convert SAMPLE tables to Partitioned Tables --
@@sub_convert.sql PERFORMANCE_SAMPLE PERFORMANCE_SAMPLE_PAR
@@sub_convert.sql VMWARE_PERF_SAMPLE VMWP_SAMPLE_PAR
@@sub_convert.sql NET_DEVICE_PERF_SAMPLE NET_DP_SAMPLE_PAR


-- Create the rest of the tables
@@sub_create.sql


-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_AGGREGATE PERFORMANCE_AGGREGATE_PAR
@@sub_convert.sql PERFORMANCE_CPU PERFORMANCE_CPU_PAR
@@sub_convert.sql PERFORMANCE_DISK PERFORMANCE_DISK_PAR
@@sub_convert.sql PERFORMANCE_DISK_TOTAL PERFORMANCE_DISK_TOTAL_PAR
@@sub_convert.sql PERFORMANCE_ESX3_WORKLOAD PERFORMANCE_ESX3_WORKLOAD_PAR
@@sub_convert.sql PERFORMANCE_FSCAP PERFORMANCE_FSCAP_PAR
@@sub_convert.sql PERFORMANCE_LPAR_WORKLOAD PERFORMANCE_LPAR_WORKLOAD_PAR
@@sub_convert.sql PERFORMANCE_NETWORK PERFORMANCE_NETWORK_PAR
@@sub_convert.sql PERFORMANCE_NRM PERFORMANCE_NRM_PAR
@@sub_convert.sql PERFORMANCE_PSINFO PERFORMANCE_PSINFO_PAR
@@sub_convert.sql PERFORMANCE_VXVOL PERFORMANCE_VXVOL_PAR
@@sub_convert.sql PERFORMANCE_WHO PERFORMANCE_WHO_PAR
@@sub_convert.sql ERDC_INT_DATA ERDC_INT_DATA_PAR
@@sub_convert.sql ERDC_DECIMAL_DATA ERDC_DECIMAL_DATA_PAR
@@sub_convert.sql ERDC_STRING_DATA ERDC_STRING_DATA_PAR
@@sub_convert.sql RANGED_OBJECT_VALUE RANGED_OBJECT_VALUE_PAR
-- up.time 6.0 tables
@@sub_convert.sql VMWARE_PERF_AGGREGATE VMWP_AGGREGATE_PAR
@@sub_convert.sql VMWARE_PERF_CLUSTER VMWP_CLUSTER_PAR
@@sub_convert.sql VMWARE_PERF_DATASTORE_USAGE VMWP_DATASTORE_USAGE_PAR
@@sub_convert.sql VMWARE_PERF_DATASTORE_VM_USAGE VMWP_DATASTORE_VM_USAGE_PAR
@@sub_convert.sql VMWARE_PERF_DISK_RATE VMWP_DISK_RATE_PAR
@@sub_convert.sql VMWARE_PERF_ENTITLEMENT VMWP_ENTITLEMENT_PAR
@@sub_convert.sql VMWARE_PERF_HOST_CPU VMWP_HOST_CPU_PAR
@@sub_convert.sql VMWARE_PERF_HOST_DISK_IO VMWP_HOST_DISK_IO_PAR
@@sub_convert.sql VMWARE_PERF_HOST_DISK_IO_ADV VMWP_HOST_DISK_IO_ADV_PAR
@@sub_convert.sql VMWARE_PERF_HOST_NETWORK VMWP_HOST_NETWORK_PAR
@@sub_convert.sql VMWARE_PERF_HOST_POWER_STATE VMWP_HOST_POWER_STATE_PAR
@@sub_convert.sql VMWARE_PERF_MEM VMWP_MEM_PAR
@@sub_convert.sql VMWARE_PERF_MEM_ADVANCED VMWP_MEM_ADVANCED_PAR
@@sub_convert.sql VMWARE_PERF_NETWORK_RATE VMWP_NETWORK_RATE_PAR
@@sub_convert.sql VMWARE_PERF_VM_CPU VMWP_VM_CPU_PAR
@@sub_convert.sql VMWARE_PERF_VM_DISK_IO VMWP_VM_DISK_IO_PAR
@@sub_convert.sql VMWARE_PERF_VM_NETWORK VMWP_VM_NETWORK_PAR
@@sub_convert.sql VMWARE_PERF_VM_POWER_STATE VMWP_VM_POWER_STATE_PAR
@@sub_convert.sql VMWARE_PERF_VM_STORAGE_USAGE VMWP_VM_STORAGE_USAGE_PAR
@@sub_convert.sql VMWARE_PERF_VM_VCPU VMWP_VM_VCPU_PAR
@@sub_convert.sql VMWARE_PERF_WATTS VMWP_WATTS_PAR
-- up.time 7.0 tables
@@sub_convert.sql NET_DEVICE_PERF_PING NET_DP_PING_PAR
@@sub_convert.sql NET_DEVICE_PERF_PORT NET_DP_PORT_PAR