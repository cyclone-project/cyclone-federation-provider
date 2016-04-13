<?php

$config = array(

        /*
         * Conditional GET requests
         * Efficient downloading so polling can be done more frequently.
         * Works for sources that send 'Last-Modified' or 'Etag' headers.
         * Note that the 'data' directory needs to be writable for this to work.
         */
        'conditionalGET'        => TRUE,

        'sets' => array(
            'dfnaai-edugain' => array(
                'cron' => array('daily'),
                'sources' => array(
                    array(
                        'src' => 'https://www.aai.dfn.de/fileadmin/metadata/DFN-AAI-Basic-metadata.xml',
                        'certFingerprint' => 'D3:3E:0F:3C:C9:43:1F:A0:0C:14:97:86:30:E3:5F:72:39:56:2C:98:85:69:2D:52:63:1C:86:78:35:90:4F:5C',
                    ),
                    array(
                        'src' => 'https://www.aai.dfn.de/fileadmin/metadata/DFN-AAI-eduGAIN+idp-metadata.xml',
                        'certFingerprint' => 'D3:3E:0F:3C:C9:43:1F:A0:0C:14:97:86:30:E3:5F:72:39:56:2C:98:85:69:2D:52:63:1C:86:78:35:90:4F:5C',
                    ),
                    /*array(
                        'src' => 'https://www.aai.dfn.de/fileadmin/metadata/DFN-AAI-Test-metadata.xml',
                        'certFingerprint' => 'D3:3E:0F:3C:C9:43:1F:A0:0C:14:97:86:30:E3:5F:72:39:56:2C:98:85:69:2D:52:63:1C:86:78:35:90:4F:5C',
                    ),*/
                ),
                'expireAfter' => 60*60*24*3,
                'outputDir' => 'metadata/metarefresh-dfnaai-edugain/',
                'outputFormat' => 'serialize',
            ),
        ),

);



