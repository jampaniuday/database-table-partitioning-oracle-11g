<?php

require_once('global.php');


$page_error = "";
$page_title     = "up.time - Oracle 'Create Table' Generator for Table Partitioning";
$templateFile   = "partitioning-oracle.tpl";

$min_partitions = 2;
$max_partitions = 24;

########################################################
## set vars
########################################################
$num_of_partitions = 12 + 12;	// 1 year into the future and 1 year back

########################################################
## build the create table string
########################################################
$partition_sample_time = "PARTITION BY RANGE (sample_time) (\n";
//for ($i = $num_of_partitions-1; $i >= -1; $i--) {

$base = -12;		// go back a year (12 months)
$multiplier = 0;	// the dynamic number that we'll add to the base to get future dates
for (; $multiplier < $num_of_partitions; $multiplier++) {

	// calculate new date
	// date format: 2010-09-01 00:00:00
	
	$interval = $base + $multiplier;
	
	// calculate new date
	// date format: 2010-09-01 00:00:00
	$newStamp = strtotime(date("Y-m", time()) . "-01 " . $interval . " months");
	$newStampPlus = strtotime(date("Y-m", time()) . "-01 " . ($interval+1) . " months");
	$year  = date("Y", $newStamp);
	$month = date("m", $newStamp);
	
	// oracle
	$partition_sample_time .= "PARTITION ups_{$year}_{$month} VALUES LESS THAN (TO_DATE('" . date("01-m-Y", $newStampPlus) . "', 'DD-MM-YYYY')),\n";
}
$interval = $base + $multiplier;
// calculate new date
// date format: 2010-09-01 00:00:00
$newStamp = strtotime(date("Y-m", time()) . "-01 " . $interval . " months");
$newStampPlus = strtotime(date("Y-m", time()) . "-01 " . ($interval+1) . " months");
$year  = date("Y", $newStamp);
$month = date("m", $newStamp);
$partition_sample_time .= "PARTITION ups_{$year}_{$month} VALUES LESS THAN (TO_DATE('" . date("01-m-Y", $newStampPlus) . "', 'DD-MM-YYYY'))\n)";
//$partition_sample_time .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n)";	// no maxvalue in oracle


// check for GET arguments
$thisis = "0";
if ( isset($_GET['thisis']) ) {
	$thisis = $_GET['thisis'];
}

// SMARTY: Assign variables
$smarty->assign( 'currentDatetime', date("Y-m-d h:i:s", time()) );
$smarty->assign( 'title', $page_title );
$smarty->assign( 'thisis', $thisis );
$smarty->assign( 'num_of_partitions', $num_of_partitions );
$smarty->assign( 'partition_sample_time', $partition_sample_time );
$smarty->assign( 'min_partitions', $min_partitions );

// SMARTY: Display page
$smarty->display($templateFile);


?>