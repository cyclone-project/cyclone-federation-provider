<?php

$config = array(

    // This is a authentication source which handles admin authentication.
    'admin' => array(
        // The default is to use core:AdminPassword, but it can be replaced with
        // any authentication source.

        'core:AdminPassword',
    ),

    'auth-hashed' => array(
        'authcrypt:Hash',
        'user:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            // displayName
            'urn:oid:2.16.840.1.113730.3.1.241' => array('user'),
            // eduPersonAffiliation
            'urn:oid:1.3.6.1.4.1.5923.1.1.1.1' => array('member', 'student'),
            // mail
            'urn:oid:0.9.2342.19200300.100.1.3' => array('user1@samlidp.com'),
            // schacHomeOrganization
            'urn:oid:1.3.6.1.4.1.25178.1.2.9' => array('admin'),
            // eduPersonTargetedID
            'urn:oid.1.3.6.1.4.1.5923.1.1.1.10' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent" NameQualifier="samlidp" SPNameQualifier="samlidp">eduPersonTargetedID1</saml2:NameID>'),
        ),

        'user2:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'urn:oid:2.16.840.1.113730.3.1.241' => array('user2'),
            'urn:oid:1.3.6.1.4.1.5923.1.1.1.1' => array('member', 'student'),
            'urn:oid:0.9.2342.19200300.100.1.3' => array('user2@samlidp.com'),
            'urn:oid:1.3.6.1.4.1.25178.1.2.9' => array('demo'),
            'urn:oid.1.3.6.1.4.1.5923.1.1.1.10' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent" NameQualifier="samlidp">eduPersonTargetedID2</saml2:NameID>'),
        ),

        'user3:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'urn:oid:2.16.840.1.113730.3.1.241' => array('user3'),
            'urn:oid:1.3.6.1.4.1.5923.1.1.1.1' => array('member', 'student'),
            'urn:oid:0.9.2342.19200300.100.1.3' => array('user3@samlidp.com'),
            'urn:oid:1.3.6.1.4.1.25178.1.2.9' => array('demo'),
            'urn:oid.1.3.6.1.4.1.5923.1.1.1.10' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">eduPersonTargetedID3</saml2:NameID>'),
        ),

        'user4:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'urn:oid:2.16.840.1.113730.3.1.241' => array('user4'),
            'urn:oid:1.3.6.1.4.1.5923.1.1.1.1' => array('member', 'student'),
            'urn:oid:1.3.6.1.4.1.25178.1.2.9' => array('demo'),
            'urn:oid:0.9.2342.19200300.100.1.3' => array('user4@samlidp.com'),
        ),
    ),
);
