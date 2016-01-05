<?php

$config = array(

	/*
	 * Global blacklist: entityIDs that should be excluded from ALL sets.
	 */
	#'blacklist' = array(
	#	'http://my.own.uni/idp'
	#),

	/*
	 * Conditional GET requests
	 * Efficient downloading so polling can be done more frequently.
	 * Works for sources that send 'Last-Modified' or 'Etag' headers.
	 * Note that the 'data' directory needs to be writable for this to work.
	 */
	'conditionalGET'	=> TRUE,

	'sets' => array(
		/*'example' => array(
			'cron' => array('hourly'),
			sources => array(
				array(
					'src' => '',
					'validateFingerprint' => '',
				),
			),
			'expireAfter' => 60*60*24*4,
			'outputDir' => 'metadata/metarefresh/',
			'outputFormat' => 'serialize',
		),*/
	),
);



