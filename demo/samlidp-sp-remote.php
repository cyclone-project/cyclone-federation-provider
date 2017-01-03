<?php
/**
 * SAML 2.0 remote SP metadata for simpleSAMLphp.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote
 */

$metadata['http://localhost:8080/samlbridge/module.php/saml/sp/metadata.php/cyclone-saml-bridge'] = array (
  'SingleLogoutService' =>
  array (
    0 =>
    array (
      'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect',
      'Location' => 'http://localhost:8080/samlbridge/module.php/saml/sp/saml2-logout.php/cyclone-saml-bridge',
    ),
  ),
  'AssertionConsumerService' =>
  array (
    0 =>
    array (
      'index' => 0,
      'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
      'Location' => 'http://localhost:8080/samlbridge/module.php/saml/sp/saml2-acs.php/cyclone-saml-bridge',
    ),
    1 =>
    array (
      'index' => 1,
      'Binding' => 'urn:oasis:names:tc:SAML:1.0:profiles:browser-post',
      'Location' => 'http://localhost:8080/samlbridge/module.php/saml/sp/saml1-acs.php/cyclone-saml-bridge',
    ),
    2 =>
    array (
      'index' => 2,
      'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact',
      'Location' => 'http://localhost:8080/samlbridge/module.php/saml/sp/saml2-acs.php/cyclone-saml-bridge',
    ),
    3 =>
    array (
      'index' => 3,
      'Binding' => 'urn:oasis:names:tc:SAML:1.0:profiles:artifact-01',
      'Location' => 'http://localhost:8080/samlbridge/module.php/saml/sp/saml1-acs.php/cyclone-saml-bridge/artifact',
    ),
  ),
  'name' =>
  array (
    'en' => 'CYCLONE Federation Provider',
    'de' => 'CYCLONE Federation Provider',
  ),
  'attributes' =>
  array (
    0 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.13',
    1 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.10',
    2 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
    3 => 'urn:oid:2.16.840.1.113730.3.1.241',
    4 => 'urn:oid:2.5.4.3',
    5 => 'urn:oid:0.9.2342.19200300.100.1.3',
    6 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.1',
    7 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.9',
    8 => 'urn:oid:1.3.6.1.4.1.25178.1.2.9',
    9 => 'urn:oid:1.3.6.1.4.1.25178.1.2.10',
  ),
  'attributes.required' =>
  array (
    0 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.13',
    1 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.10',
    2 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
    3 => 'urn:oid:2.16.840.1.113730.3.1.241',
    4 => 'urn:oid:2.5.4.3',
    5 => 'urn:oid:0.9.2342.19200300.100.1.3',
    6 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.1',
    7 => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.9',
    8 => 'urn:oid:1.3.6.1.4.1.25178.1.2.9',
    9 => 'urn:oid:1.3.6.1.4.1.25178.1.2.10',
  ),
  'description' =>
  array (
    'en' => 'The CYCLONE Test Federation Provider is used for testing and demonstrating the technologies developed within the CYCLONE project',
    'de' => 'Der CYCLONE Test Federation Provider dient zum Testen und zur Demonstration der im CYCLONE – Projekt entwickelten Technologien',
  ),
  'certData' => 'MIIDkzCCAnugAwIBAgIJANVit7gegR4jMA0GCSqGSIb3DQEBCwUAMGAxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCZXJsaW4xDzANBgNVBAcMBkJlcmxpbjEMMAoGA1UECgwDVFVCMQ0wCwYDVQQLDARTTkVUMRIwEAYDVQQDDAlsb2NhbGhvc3QwHhcNMTUxMDI3MTAwNjM1WhcNMTYxMDI2MTAwNjM1WjBgMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmVybGluMQ8wDQYDVQQHDAZCZXJsaW4xDDAKBgNVBAoMA1RVQjENMAsGA1UECwwEU05FVDESMBAGA1UEAwwJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzE63TFEOcRKB2FNBPpg8hj3JB3U8jic7uTKLsbEeXaXSoXYTDf9ivivs/qHpq6xLGuDT3YcCptPyD40Npy1sT45UKbpUXAOj2ePpZirJNbA4LzS/1tm1mfAFsppaETx7hOW4xSRpdseY0dmC30WNPlq59rSx3omzryOSJO4pulAn8FkqMehVyZQQfN36qbPwLyjP3gmDb2cv979J+PWeCvS8/UsoJ5FWd9/GLfYqk+Kqtfs+Ne2MFUxTQt8U5AQBuFvp63DK0QQs0qoQw2mE4W/p44rKPx7O+lB87khPR0VuEk0uy9eR0SvZT4fHR8xZECioToSywHS8OTV/2sY6qQIDAQABo1AwTjAdBgNVHQ4EFgQULNQDb6ymlpe7UkqckkqDwAu7CYMwHwYDVR0jBBgwFoAULNQDb6ymlpe7UkqckkqDwAu7CYMwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEABokHEsXUbr2HviROSvtCS+4sk7xu9CLC9Nj0eJUeFCizpKY10uSQxXXrdOSkgdBV9RRPoFNwex9+cY9seZxOSethhnU6+7GT+QhS+WDS2vkpmnl5nggFTd5QlmSjCZAr5GFf7ItZVKLMEp/rGm3x+wF9Ql7GSGGp9kjw/UEnTh2nwMoN1UMfzCevMhpSWsI4G+KPSJH8Gv6Sy8tMGZpb6szIYYMxUYBrVdJLKlaUOf6qrP3o+vBzTomhFOTjMq2d4MFyRw4L2UldbuoQ6FLjV0Ta7piKiiIK+CHAjEJIH5DT8l1LlB6WtipAozW7acfF9Hxc9YnAtmdIui3Jd3YK2Q==',
  'EntityAttributes' =>
  array (
    'http://macedir.org/entity-category' =>
    array (
      0 => 'http://www.geant.net/uri/dataprotection-code-of-conduct/v1',
    ),
  ),
  'redirect.sign' => true,
  'redirect.validate' => true,
  'saml20.sign.response' => true,
  'saml20.sign.assertion' => true,
  'signature.algorithm' => 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256',
  'sign.logout' => true,
  'validate.authnrequest' => true,
  'validate.logout' => true,
);
