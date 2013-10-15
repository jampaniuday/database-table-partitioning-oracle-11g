<?php

error_reporting(E_ALL ^ E_NOTICE);

########################################################
## set vars
########################################################
if (isset($_GET["partitions"])) {
	$num_of_partitions = $_GET["partitions"];
	// should not have less than 4 partitions
	if ($num_of_partitions < 4) {
		$num_of_partitions = 12;
	}
}
else {
	$num_of_partitions = 12;
}
$title = "up.time - Oracle 11g Generator for Table Partitioning";


########################################################
## build the create table string
########################################################
	$partition_sub_tables  = '';
    for ($i = $num_of_partitions-1; $i >= -1; $i--) {
		if ($i < $num_of_partitions-1) {
			$partition_sub_tables .= ",\n";
		}
		// calculate new date
		// date format: 2010-09-01 00:00:00
		$interval = $i * -1;
        $newStamp = strtotime(date("Y-m", time()) . "-01 " . $interval . " months");
		$newStampPlus = strtotime(date("Y-m", time()) . "-01 " . ($interval+1) . " months");
		$year  = date("Y", $newStamp);
		$month = date("m", $newStamp);
		$partition_sub_tables .= "PARTITION ups_{$year}_{$month} VALUES LESS THAN (TO_DATE('" . date("1-m-Y", $newStampPlus) . "', 'DD-MM-YYYY'))";
		//$partition_sub_tables .= "PARTITION par_{$year}_{$month} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00'))";
    }
	$partition_sub_tables .= "\n)\n";

?>

<html><head>
<title><?php echo $title; ?></title>
<link rel="stylesheet" type="text/css" href="/styles/default/stylesheets/styles-1.3.css" />
</head><body>

<h2><?php print $title; ?></h2>

<p>
Current Date/Time: <?php print date("Y-m-d h:i:s", time()); ?><br />
Number of Partitions selected: <?php print $num_of_partitions; ?><br>
Change number of partitions: <form>
<select name='partitions'>
<?php
$selected = '';
for ($i=4; $i <= 20; $i++) {
	if ($i == $num_of_partitions) {
		$selected = ' selected';
	}
	echo "<option{$selected}>{$i}</option>\n";
	$selected = '';
}
?>
</select>
<input type='submit' value='Change'></form>
</p>

<textarea cols='120' rows='40'>
set serveroutput on;
set pagesize 1000;
set linesize 1000;
---------------------------------
-- Start of PERFORMANCE_SAMPLE --
---------------------------------
-- Clean before trying...
DROP TABLE PERFORMANCE_DELETE CASCADE CONSTRAINTS PURGE
/

EXEC DBMS_OUTPUT.put_line('Please enter the tablespace where partitioned tables will reside.')

-- With Range Partitioning --
CREATE TABLE PERFORMANCE_DELETE (
"ID" NUMBER(20) NOT NULL, 
"ERDC_ID" NUMBER(20), 
"UPTIMEHOST_ID" NUMBER(20) NOT NULL, 
"SAMPLE_TIME" TIMESTAMP(6) NOT NULL, 
PRIMARY KEY ("ID") VALIDATE 
) 
PARTITION BY RANGE (sample_time)
(
<?php
echo $partition_sub_tables;
?>
TABLESPACE &&tablespace_for_tables
/

</textarea>
</body></html>