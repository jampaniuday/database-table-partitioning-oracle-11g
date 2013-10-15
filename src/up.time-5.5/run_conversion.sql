set serveroutput on;
set pagesize 1000;
set linesize 1000;
---------------------------------
-- Start of PERFORMANCE_SAMPLE --
---------------------------------

-- PERFORMANCE_DELETE (performance_sample) table should be created already --


-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_SAMPLE

-- drop indexes
drop index uptimehost_id
/
drop index sample_erdc_id
/
drop index latest_sample
/
drop index latest_sample_by_host

-------------------------------
-- End of PERFORMANCE_SAMPLE --
-------------------------------

------------------------------------
-- Start of PERFORMANCE_AGGREGATE --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE (
"SAMPLE_ID" NUMBER(20) NOT NULL, 
"CPU_USR" FLOAT(126), 
"CPU_SYS" FLOAT(126), 
"CPU_WIO" FLOAT(126), 
"FREE_MEM" FLOAT(126), 
"FREE_SWAP" FLOAT(126), 
"RUN_QUEUE" FLOAT(126), 
"RUN_OCC" FLOAT(126), 
"READ_CACHE" FLOAT(126), 
"WRITE_CACHE" FLOAT(126), 
"PG_OUT_SEC" FLOAT(126), 
"PPG_OUT_SEC" FLOAT(126), 
"PG_FREE_SEC" FLOAT(126), 
"PG_SCAN_SEC" FLOAT(126), 
"ATCH_SEC" FLOAT(126), 
"PG_IN_SEC" FLOAT(126), 
"PPG_IN_SEC" FLOAT(126), 
"PFLT_SEC" FLOAT(126), 
"VFLT_SEC" FLOAT(126), 
"SLOCK_SEC" FLOAT(126), 
"NUM_PROCS" NUMBER(20), 
"PROC_READ" FLOAT(126), 
"PROC_WRITE" FLOAT(126), 
"PROC_BLOCK" FLOAT(126), 
"DNLC" FLOAT(126), 
"FORK_SEC" FLOAT(126), 
"EXEC_SEC" FLOAT(126), 
"TCP_RETRANS" NUMBER(20), 
"WORST_DISK_USAGE" NUMBER(20), 
"WORST_DISK_BUSY" NUMBER(20), 
"USED_SWAP_PERCENT" NUMBER(20), 
PRIMARY KEY (SAMPLE_ID) VALIDATE, 
CONSTRAINT FK_AGGREGATE FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_AGGREGATE)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_AGGREGATE

----------------------------------
-- End of PERFORMANCE_AGGREGATE --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_CPU --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"CPU_ID" NUMBER(20), 
"CPU_USR" NUMBER(20), 
"CPU_SYS" NUMBER(20), 
"CPU_WIO" NUMBER(20), 
"XCAL" NUMBER(20), 
"INTR" NUMBER(20), 
"SMTX" NUMBER(20), 
"MINF" FLOAT(126), 
"MJF" FLOAT(126), 
"ITHR" FLOAT(126), 
"CSW" FLOAT(126), 
"ICSW" FLOAT(126), 
"MIGR" FLOAT(126), 
"SRW" FLOAT(126), 
"SYSCL" FLOAT(126), 
"IDLE" FLOAT(126), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE,
CONSTRAINT FK_CPU FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_CPU)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_CPU

----------------------------------
-- End of PERFORMANCE_CPU --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_DISK --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"DISK_NAME" VARCHAR2(255), 
"PCT_TIME_BUSY" NUMBER(20), 
"AVG_QUEUE_REQ" NUMBER(20), 
"RW_SEC" NUMBER(20), 
"BLOCKS_SEC" NUMBER(20), 
"AVG_WAIT_TIME" NUMBER(20), 
"AVG_SERV_TIME" NUMBER(20), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE ,
CONSTRAINT FK_DISK FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_DISK)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_DISK

----------------------------------
-- End of PERFORMANCE_DISK --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_DISK_TOTAL --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE (
"SAMPLE_ID" NUMBER(20) NOT NULL, 
"PCT_TIME_BUSY" NUMBER(20), 
"AVG_QUEUE_REQ" NUMBER(20), 
"RW_SEC" NUMBER(20), 
"BLOCKS_SEC" NUMBER(20), 
"AVG_WAIT_TIME" NUMBER(20), 
"AVG_SERV_TIME" NUMBER(20), 
PRIMARY KEY ("SAMPLE_ID") VALIDATE,
CONSTRAINT FK_DISK_TOTAL FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE
) 
PARTITION BY REFERENCE (FK_DISK_TOTAL)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_DISK_TOTAL

----------------------------------
-- End of PERFORMANCE_DISK_TOTAL --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_ESX3_WORKLOAD --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"UUID" VARCHAR2(255), 
"INSTANCE_NAME" VARCHAR2(255), 
"CPU_USAGE_MHZ" NUMBER(20), 
"MEMORY" NUMBER(20), 
"DISK_IO_RATE" NUMBER(20), 
"NETWORK_IO_RATE" NUMBER(20), 
"PERCENT_READY" FLOAT(126), 
"PERCENT_USED" FLOAT(126), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE ,
CONSTRAINT FK_ESX3 FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_ESX3)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_ESX3_WORKLOAD

----------------------------------
-- End of PERFORMANCE_ESX3_WORKLOAD --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_FSCAP --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"FILESYSTEM" VARCHAR2(255), 
"TOTAL_SIZE" NUMBER(20), 
"SPACE_USED" NUMBER(20), 
"SPACE_AVAIL" NUMBER(20), 
"PERCENT_USED" NUMBER(20), 
"MOUNT_POINT" VARCHAR2(255), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE,
CONSTRAINT FK_FSCAP FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_FSCAP)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_FSCAP

----------------------------------
-- End of PERFORMANCE_FSCAP --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_LPAR_WORKLOAD --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"LPAR_ID" NUMBER(20), 
"INSTANCE_NAME" VARCHAR2(255), 
"ENTITLEMENT" FLOAT(126), 
"CPU_USAGE" FLOAT(126), 
"USED_MEMORY" NUMBER(20), 
"NETWORK_IO_RATE" NUMBER(20), 
"DISK_IO_RATE" NUMBER(20), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE, 
CONSTRAINT FK_LPAR FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_LPAR)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_LPAR_WORKLOAD

----------------------------------
-- End of PERFORMANCE_LPAR_WORKLOAD --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_NETWORK --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"IFACE_NAME" VARCHAR2(255), 
"IN_BYTES" NUMBER(20), 
"OUT_BYTES" NUMBER(20), 
"COLLISIONS" NUMBER(20), 
"IN_ERRORS" NUMBER(20), 
"OUT_ERRORS" NUMBER(20), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE, 
CONSTRAINT FK_NETWORK FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_NETWORK)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_NETWORK

----------------------------------
-- End of PERFORMANCE_NETWORK --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_NRM --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
"WORK_TO_DO" NUMBER(20), 
"AVAILABLE_DISK" NUMBER(20), 
"DS_THREAD_USAGE" NUMBER(20), 
"ALLOCATED_SERVER_PROCS" NUMBER(20), 
"AVAILABLE_SERVER_PROCS" NUMBER(20), 
"PACKET_RECEIVE_BUFFERS" NUMBER(20), 
"AVAILABLE_ECBS" NUMBER(20), 
"LAN_TRAFFIC" NUMBER(20), 
"CONNECTION_USAGE" NUMBER(20), 
"DISK_THROUGHPUT" NUMBER(20), 
"ABENDED_THREAD_COUNT" NUMBER(20), 
PRIMARY KEY ("SAMPLE_ID") VALIDATE, 
CONSTRAINT FK_NRM FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_NRM)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_NRM

----------------------------------
-- End of PERFORMANCE_NRM --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_PSINFO --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"PID" NUMBER(20), 
"PPID" NUMBER(20), 
"PS_UID" VARCHAR2(255), 
"GID" VARCHAR2(255), 
"MEM_USED" NUMBER(20), 
"RSS" NUMBER(20), 
"CPU_USAGE" FLOAT(126), 
"MEMORY_USAGE" FLOAT(126), 
"USER_CPU_TIME" NUMBER(20), 
"SYS_CPU_TIME" NUMBER(20), 
"START_TIME" TIMESTAMP(6), 
"PROC_NAME" VARCHAR2(255), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE, 
CONSTRAINT FK_PSINFO FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_PSINFO)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_PSINFO

----------------------------------
-- End of PERFORMANCE_PSINFO --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_VXVOL --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"DG" VARCHAR2(255), 
"VOL" VARCHAR2(255), 
"RD_OPS" NUMBER(20), 
"WR_OPS" NUMBER(20), 
"RD_BLKS" NUMBER(20), 
"WR_BLKS" NUMBER(20), 
"AVG_RD" NUMBER(20), 
"AVG_WR" NUMBER(20), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE, 
CONSTRAINT FK_VXVOL FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_VXVOL)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_VXVOL

----------------------------------
-- End of PERFORMANCE_VXVOL --
----------------------------------

------------------------------------
-- Start of PERFORMANCE_WHO --
------------------------------------
-- Create interim table --
-- With Reference Partitioning --
CREATE TABLE PERFORMANCE_DELETE ( 
"ID" NUMBER(20), 
"USERNAME" VARCHAR2(255), 
"SESSION_COUNT" NUMBER(20), 
"SAMPLE_ID" NUMBER(20) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE, 
CONSTRAINT FK_WHO FOREIGN KEY (SAMPLE_ID) 
  REFERENCES PERFORMANCE_SAMPLE (ID) VALIDATE 
)
PARTITION BY REFERENCE (FK_WHO)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql PERFORMANCE_WHO

----------------------------------
-- End of PERFORMANCE_WHO --
----------------------------------

------------------------------------
-- Start of ERDC_INT_DATA --
------------------------------------
-- Create interim table --
-- With Interval Partitioning --
CREATE TABLE performance_delete ( 
"ERDC_INT_DATA_ID" NUMBER(20) NOT NULL, 
"ERDC_INSTANCE_ID" NUMBER(20), 
"ERDC_PARAMETER_ID" NUMBER(20), 
"VALUE" NUMBER(20), 
"SAMPLETIME" TIMESTAMP(6) NOT NULL, 
PRIMARY KEY ("ERDC_INT_DATA_ID") VALIDATE 
) 
PARTITION BY RANGE (sampletime)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
(
PARTITION erdc_int_p1 VALUES LESS THAN (TO_DATE('1-1-2007', 'DD-MM-YYYY'))
)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql ERDC_INT_DATA

----------------------------------
-- End of ERDC_INT_DATA --
----------------------------------

------------------------------------
-- Start of ERDC_DECIMAL_DATA --
------------------------------------
-- Create interim table --
-- With Interval Partitioning --
CREATE TABLE performance_delete ( 
"ERDC_INT_DATA_ID" NUMBER(20), 
"ERDC_INSTANCE_ID" NUMBER(20), 
"ERDC_PARAMETER_ID" NUMBER(20), 
"VALUE" FLOAT(126), 
"SAMPLETIME" TIMESTAMP(6) NOT NULL, 
PRIMARY KEY ("ERDC_INT_DATA_ID") VALIDATE )
PARTITION BY RANGE (sampletime)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
(
PARTITION erdc_dec_p1 VALUES LESS THAN (TO_DATE('1-1-2007', 'DD-MM-YYYY'))
)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql ERDC_DECIMAL_DATA

----------------------------------
-- End of ERDC_DECIMAL_DATA --
----------------------------------

------------------------------------
-- Start of ERDC_STRING_DATA --
------------------------------------
-- Create interim table --
-- With Interval Partitioning --
CREATE TABLE performance_delete ( 
"ERDC_INT_DATA_ID" NUMBER(20) NOT NULL, 
"ERDC_INSTANCE_ID" NUMBER(20), 
"ERDC_PARAMETER_ID" NUMBER(20), 
"VALUE" CLOB, 
"SAMPLETIME" TIMESTAMP(6) NOT NULL, 
PRIMARY KEY ("ERDC_INT_DATA_ID") VALIDATE 
)
PARTITION BY RANGE (sampletime)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
(
PARTITION erdc_string_p1 VALUES LESS THAN (TO_DATE('1-1-2007', 'DD-MM-YYYY'))
)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql ERDC_STRING_DATA

----------------------------------
-- End of ERDC_STRING_DATA --	
----------------------------------

------------------------------------
-- Start of RANGED_OBJECT_VALUE --
------------------------------------
-- Create interim table --
-- With Interval Partitioning --
CREATE TABLE performance_delete ( 
"ID" NUMBER(20) NOT NULL, 
"RANGED_OBJECT_ID" NUMBER(20), 
"NAME" VARCHAR2(255), 
"VALUE" FLOAT(126), 
"SAMPLE_TIME" TIMESTAMP(6) NOT NULL, 
CONSTRAINT FK_RANGED_OBJECT_VALUE 
FOREIGN KEY ("RANGED_OBJECT_ID") 
REFERENCES RANGED_OBJECT ("ID") VALIDATE , 
PRIMARY KEY ("ID") VALIDATE 
)
PARTITION BY RANGE (sample_time)
INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
(
PARTITION ranged_object_p1 VALUES LESS THAN (TO_DATE('1-1-2007', 'DD-MM-YYYY'))
)
TABLESPACE &&tablespace_for_tables
/

-- Convert to Partitioned Table --
@@sub_convert.sql RANGED_OBJECT_VALUE

----------------------------------
-- End of RANGED_OBJECT_VALUE --
----------------------------------
