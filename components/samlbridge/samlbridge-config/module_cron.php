<?php
/*
 * Configuration for the Cron module.
 */

$config = array (

	'key' => getenv('SAMLBRIDGE_CRON'),
	'allowed_tags' => array('daily', 'hourly'),
	'debug_message' => TRUE,
	'sendemail' => FALSE,

);

?>
