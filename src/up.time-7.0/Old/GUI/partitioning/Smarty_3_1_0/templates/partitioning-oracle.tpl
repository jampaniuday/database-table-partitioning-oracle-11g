{* include file="header.tpl" *}

<center>
<h1>{$title}</h1>
<p>Current Date/Time: {$currentDatetime}<p/>
<p>By default we'll setup enough partitions for the past year and 1 year into the future. All future partitions will be automatically created by the database.<p/>

<p>
This is: 
<select name="thisis" id="thisis" onchange="window.location.replace('?thisis=' + document.getElementById('thisis').value);">
<option value="0"
{if $thisis == '0'} selected {/if}>A Fresh Install</option>
<option value="55" {if $thisis == '55'} selected {/if}>Upgrading from up.time 5.5</option>
</select>
</p>

<textarea cols='100' rows='30'>
set serveroutput on;
set pagesize 1000;
set linesize 1000;

{if $thisis < '55'}
---------------------------------
-- Start of PERFORMANCE_SAMPLE_PAR --
---------------------------------
-- With Range Partitioning --
CREATE TABLE PERFORMANCE_SAMPLE_PAR (
"ID" NUMBER(20) NOT NULL, 
"ERDC_ID" NUMBER(20), 
"UPTIMEHOST_ID" NUMBER(20) NOT NULL, 
"SAMPLE_TIME" TIMESTAMP(6) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE 
) 
{$partition_sample_time}
/

------------------------------------
-- Start of ERDC_INT_DATA --
------------------------------------
-- With Interval Partitioning --
CREATE TABLE ERDC_INT_DATA_PAR ( 
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
/

------------------------------------
-- Start of ERDC_DECIMAL_DATA --
------------------------------------
-- With Interval Partitioning --
CREATE TABLE ERDC_DECIMAL_DATA_PAR ( 
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
/

------------------------------------
-- Start of ERDC_STRING_DATA --
------------------------------------
-- With Interval Partitioning --
CREATE TABLE ERDC_STRING_DATA_PAR ( 
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
/

------------------------------------
-- Start of RANGED_OBJECT_VALUE --
------------------------------------
-- With Interval Partitioning --
CREATE TABLE RANGED_OBJECT_VALUE_PAR ( 
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
/
{/if}


-- New tables in up.time 6.0 --

CREATE TABLE VMWP_SAMPLE_PAR ( 
"SAMPLE_ID" NUMBER(20),
"VMWARE_OBJECT_TYPE" VARCHAR2(255),
"VMWARE_OBJECT_ID" NUMBER(20),
"VIRTUAL_CENTER_ID" NUMBER(20),
"DATACENTER_ID" NUMBER(20),
"CLUSTER_ID" NUMBER(20),
"HOST_SYSTEM_ID" NUMBER(20),
"RESOURCE_POOL_ID" NUMBER(20),
"SAMPLE_TIME" TIMESTAMP(6),
PRIMARY KEY ("SAMPLE_ID") VALIDATE
)
{$partition_sample_time}
/


-- New tables in up.time 7.0 --


CREATE TABLE "NET_DP_SAMPLE_PAR" ( 
"ID" NUMBER(20),
"ENTITY_ID" NUMBER(20),
"SAMPLE_TIME" TIMESTAMP(6),
PRIMARY KEY (ID) VALIDATE
)
{$partition_sample_time}
/

</textarea>

</center>

{* include file="footer.tpl" *}
