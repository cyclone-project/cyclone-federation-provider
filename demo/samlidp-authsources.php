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
            'uid' => array('user'),
            'eduPersonAffiliation' => array('member', 'student'),
            'mail' => array('user1@samlidp.com'),
            'eduPersonTargetedID' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent" NameQualifier="samlidp" SPNameQualifier="samlidp">eduPersonTargetedID1</saml2:NameID>'),
        ),

        'user2:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'uid' => array('user2'),
            'eduPersonAffiliation' => array('member', 'student'),
            'mail' => array('user2@samlidp.com'),
            'eduPersonTargetedID' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent" NameQualifier="samlidp">eduPersonTargetedID2</saml2:NameID>'),
        ),

        'user3:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'uid' => array('user3'),
            'eduPersonAffiliation' => array('member', 'student'),
            'mail' => array('user3@samlidp.com'),
            'eduPersonTargetedID' => array('<saml2:NameID xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion" Format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent">eduPersonTargetedID3</saml2:NameID>'),
        ),

        'user4:{SSHA256}NRz/9Ypsem9JJjIJ+QsjxAAvHJukzPr33JKzCOxKxTEjhUmhnP2dPg==' => array(
            'uid' => array('user4'),
            'eduPersonAffiliation' => array('member', 'student'),
            'mail' => array('user4@samlidp.com'),
        ),
    ),
);
