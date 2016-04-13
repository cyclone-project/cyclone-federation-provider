<?php
/**
 * SAML 2.0 remote SP metadata for simpleSAMLphp.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote
 */

$metadata['https://federation.cyclone-project.eu/auth/realms/master'] = array(
    'AssertionConsumerService' => 'https://federation.cyclone-project.eu/auth/realms/master/broker/edugain/endpoint',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
    'SingleLogoutService' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://federation.cyclone-project.eu/auth/realms/master/broker/edugain/endpoint',
);

