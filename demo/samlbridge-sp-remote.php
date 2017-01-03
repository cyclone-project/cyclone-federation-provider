<?php

$metadata['http://localhost:9080/auth/realms/master'] = array (
    'AssertionConsumerService' => 'http://localhost:9080/auth/realms/master/broker/simplesaml/endpoint',
    'SingleLogoutService' =>  'http://localhost:9080/auth/realms/master/broker/simplesaml/endpoint',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
    'certData' => 'MIICmzCCAYMCBgFOjTVB+zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTUwNzE0MTUzNDE0WhcNMjUwNzE0MTUzNTU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDSSvvOo4U2HphRXDwv58Ay4IA98lYYBenWu+s7LLXj0gm3U5vZwYINIzp+NuQYbw2f0zhxQiO0Sh2xABfSAQFfuAVhR9WmgSNkEDpbrKLYRBAw76vUK1PAaUlY+MfY7Q74rdYSTPPp8W/OuXb4xZZtX4TKEKDyUuhDxq2BeZOmmzcP9+sQW0vvDhK/Z1+JnpiFNWF9Lq8wjL/GkIc67xTp6CN/Ds152pPE6/52owN3MljGudkIxv/ZTVXd3nxD1C+ZUUzTk8xzqyWAn9z/3Q/j4VFQHHuSkHSDRhx96EDfvWh7gMU9NbZluZElnrqF4p86589V3guhdItdIvzDNo8rAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHw9+QsS1rnVhoeQOq3d+rYHw1KJEs4gv5SpSg1V2PE9lCgD3QefCqj425V0zbAsG4zRRKcapK+4lU2JIq9sOlKSvaD8S2ZFoYhp6AERW6xZUtTwDkp0Zv+Xb9SUo4KjJJUSzo6qvVrkweKeA4srqGbIEG+mw2dxueiTl6JSStdldREOIKfnM78t43w2szRrlgFekBW92/W3B6Sn84mdngQ2gpzh0uqjjLFw3F0G5OR/6l9zBd6j/qyIsjAQCJwKcO9BHsYptQH1e+lyDBTu41bhpTMPT1aVkRncIAmI79IYOVFftWo8HyXSEDPEwh16T9OC0fJadUsahi+qiPmOftY=',
    'signature.algorithm' => 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256',
    'validate.authnrequest' => false,
    'validate.logout' => false,
    'redirect.sign' => true,
    'redirect.validate' => true,
);