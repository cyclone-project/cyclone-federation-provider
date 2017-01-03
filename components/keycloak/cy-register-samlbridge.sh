#!/bin/sh

# register-samlbridge - Registers the demo samlbridge idp with keycloak

MAP_ATTR="displayName schacHomeOrganization schacHomeOrganizationType eduPersonUniqueID eduPersonTargetedId commonName eduPersonPrincipalName email mail eduPersonAffiliation eduPersonScopedAffiliation"

KEYCLOAK_REALM=${KEYCLOAK_REALM:=master}
KEYCLOAK_URL=${KEYCLOAK_URL:=http://localhost:8080/auth}
SAMLBRIDGE_URL=${SAMLBRIDGE_URL:=http://localhost:8080/samlbridge}

usage() {
	echo "usage: register-idp.sh [options]"
	echo "-u, --username      keycloak username"
	echo "-p, --password      keycloak password"
	echo "-k, --keycloak      keycloak url"
	echo "-s, --samlbridge    samlbridge url"
	echo "-h, --help          show this info"
}

# log in to keycloak
kc_login() {
	curl -s -X POST "$KEYCLOAK_URL/realms/$KEYCLOAK_REALM/protocol/openid-connect/token" \
	     -H "Content-Type: application/x-www-form-urlencoded" \
	     -d "username=$KEYCLOAK_USER" \
	     -d "password=$KEYCLOAK_PASSWORD" \
	     -d "grant_type=password" \
	     -d "client_id=admin-cli"
}

# log out of keycloak
kc_logout() {
	curl -s -X POST "$KEYCLOAK_URL/realms/$KEYCLOAK_REALM/protocol/openid-connect/logout" \
	     -H "Authorization: Bearer $AC_TKN" \
	     -H "Content-Type: application/x-www-form-urlencoded" \
	     -d "username=$KEYCLOAK_USER" \
	     -d "client_id=admin-cli" \
	     -d "refresh_token=$RF_TKN"
}

# register samlbridge and its mappers
kc_reg_idp() {
	curl -s -X POST "$KEYCLOAK_URL/admin/realms/$KEYCLOAK_REALM/identity-provider/instances" \
	     -H "Accept: application/json" \
	     -H "Authorization: Bearer $AC_TKN" \
	     -H "Content-Type: application/json" \
	     -d @- <<EOF
{
  "alias": "DemoIDP",
  "internalId": "",
  "providerId": "saml",
  "enabled": true,
  "updateProfileFirstLoginMode": "on",
  "trustEmail": false,
  "storeToken": false,
  "addReadTokenRoleOnCreate": false,
  "authenticateByDefault": false,
  "firstBrokerLoginFlowAlias": "first broker login",
  "config": {
    "validateSignature": "false",
    "signingCertificate": "MIIDkzCCAnugAwIBAgIJANVit7gegR4jMA0GCSqGSIb3DQEBCwUAMGAxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCZXJsaW4xDzANBgNVBAcMBkJlcmxpbjEMMAoGA1UECgwDVFVCMQ0wCwYDVQQLDARTTkVUMRIwEAYDVQQDDAlsb2NhbGhvc3QwHhcNMTUxMDI3MTAwNjM1WhcNMTYxMDI2MTAwNjM1WjBgMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmVybGluMQ8wDQYDVQQHDAZCZXJsaW4xDDAKBgNVBAoMA1RVQjENMAsGA1UECwwEU05FVDESMBAGA1UEAwwJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzE63TFEOcRKB2FNBPpg8hj3JB3U8jic7uTKLsbEeXaXSoXYTDf9ivivs/qHpq6xLGuDT3YcCptPyD40Npy1sT45UKbpUXAOj2ePpZirJNbA4LzS/1tm1mfAFsppaETx7hOW4xSRpdseY0dmC30WNPlq59rSx3omzryOSJO4pulAn8FkqMehVyZQQfN36qbPwLyjP3gmDb2cv979J+PWeCvS8/UsoJ5FWd9/GLfYqk+Kqtfs+Ne2MFUxTQt8U5AQBuFvp63DK0QQs0qoQw2mE4W/p44rKPx7O+lB87khPR0VuEk0uy9eR0SvZT4fHR8xZECioToSywHS8OTV/2sY6qQIDAQABo1AwTjAdBgNVHQ4EFgQULNQDb6ymlpe7UkqckkqDwAu7CYMwHwYDVR0jBBgwFoAULNQDb6ymlpe7UkqckkqDwAu7CYMwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEABokHEsXUbr2HviROSvtCS+4sk7xu9CLC9Nj0eJUeFCizpKY10uSQxXXrdOSkgdBV9RRPoFNwex9+cY9seZxOSethhnU6+7GT+QhS+WDS2vkpmnl5nggFTd5QlmSjCZAr5GFf7ItZVKLMEp/rGm3x+wF9Ql7GSGGp9kjw/UEnTh2nwMoN1UMfzCevMhpSWsI4G+KPSJH8Gv6Sy8tMGZpb6szIYYMxUYBrVdJLKlaUOf6qrP3o+vBzTomhFOTjMq2d4MFyRw4L2UldbuoQ6FLjV0Ta7piKiiIK+CHAjEJIH5DT8l1LlB6WtipAozW7acfF9Hxc9YnAtmdIui3Jd3YK2Q==",
    "nameIDPolicyFormat": "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent",
    "singleLogoutServiceUrl": "$SAMLBRIDGE_URL/saml2/idp/SingleLogoutService.php",
    "postBindingResponse": "false",
    "signatureAlgorithm": "RSA_SHA256",
    "useJwksUrl": "true",
    "postBindingAuthnRequest": "false",
    "singleSignOnServiceUrl": "$SAMLBRIDGE_URL/saml2/idp/SSOService.php",
    "wantAuthnRequestsSigned": "true",
    "addExtensionsElementWithKeyInfo": "false",
    "encryptionPublicKey": "MIIDkzCCAnugAwIBAgIJANVit7gegR4jMA0GCSqGSIb3DQEBCwUAMGAxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCZXJsaW4xDzANBgNVBAcMBkJlcmxpbjEMMAoGA1UECgwDVFVCMQ0wCwYDVQQLDARTTkVUMRIwEAYDVQQDDAlsb2NhbGhvc3QwHhcNMTUxMDI3MTAwNjM1WhcNMTYxMDI2MTAwNjM1WjBgMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmVybGluMQ8wDQYDVQQHDAZCZXJsaW4xDDAKBgNVBAoMA1RVQjENMAsGA1UECwwEU05FVDESMBAGA1UEAwwJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzE63TFEOcRKB2FNBPpg8hj3JB3U8jic7uTKLsbEeXaXSoXYTDf9ivivs/qHpq6xLGuDT3YcCptPyD40Npy1sT45UKbpUXAOj2ePpZirJNbA4LzS/1tm1mfAFsppaETx7hOW4xSRpdseY0dmC30WNPlq59rSx3omzryOSJO4pulAn8FkqMehVyZQQfN36qbPwLyjP3gmDb2cv979J+PWeCvS8/UsoJ5FWd9/GLfYqk+Kqtfs+Ne2MFUxTQt8U5AQBuFvp63DK0QQs0qoQw2mE4W/p44rKPx7O+lB87khPR0VuEk0uy9eR0SvZT4fHR8xZECioToSywHS8OTV/2sY6qQIDAQABo1AwTjAdBgNVHQ4EFgQULNQDb6ymlpe7UkqckkqDwAu7CYMwHwYDVR0jBBgwFoAULNQDb6ymlpe7UkqckkqDwAu7CYMwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEABokHEsXUbr2HviROSvtCS+4sk7xu9CLC9Nj0eJUeFCizpKY10uSQxXXrdOSkgdBV9RRPoFNwex9+cY9seZxOSethhnU6+7GT+QhS+WDS2vkpmnl5nggFTd5QlmSjCZAr5GFf7ItZVKLMEp/rGm3x+wF9Ql7GSGGp9kjw/UEnTh2nwMoN1UMfzCevMhpSWsI4G+KPSJH8Gv6Sy8tMGZpb6szIYYMxUYBrVdJLKlaUOf6qrP3o+vBzTomhFOTjMq2d4MFyRw4L2UldbuoQ6FLjV0Ta7piKiiIK+CHAjEJIH5DT8l1LlB6WtipAozW7acfF9Hxc9YnAtmdIui3Jd3YK2Q=="
  }
}"
EOF

	if [ "$?" -ne 0 ]; then
		echo "Failed to add Samlbridge IDP"
		exit 1
	fi

	for attr in $MAP_ATTR; do
		curl -s -X post "$KEYCLOAK_URL/admin/realms/$KEYCLOAK_REALM/identity-provider/instances/DemoIDP/mappers" \
		     -H "accept: application/json" \
		     -H "content-type: application/json" \
		     -H "authorization: Bearer $AC_TKN" \
		     -d @- <<EOF
{
  "name": "$attr",
  "identityProviderAlias":"DemoIDP",
  "identityProviderMapper":"saml-user-attribute-idp-mapper",
  "config": {
    "user.attribute": "$attr",
    "attribute.friendly.name": "$attr",
  "attribute.name": "$attr"
  }
}
EOF

		if [ "$?" -ne 0 ]; then
			echo "Failed to add attribute mapper"
			exit 1
		fi
	done
}

##### Main

while [ "$1" != "" ]; do
	case $1 in
		-u | --user )        shift
		                     KEYCLOAK_USER=$1
		                     ;;
		-p | --password )    shift
		                     KEYCLOAK_PASSWORD=$1
		                     ;;
		-k | --keycloak )    shift
		                     KEYCLOAK_URL=$1
		                     ;;
		-s | --samlbridge)   shift
		                     SAMLBRIDGE_URL=$1
		                     ;;
		-h | --help )        usage
		                     exit 0
		                     ;;
		* )                  usage
		                     exit 1
	esac
	shift
done

response=$(kc_login)
AC_TKN=$(echo "$response" | jq -r '.access_token')
ID_TKN=$(echo "$response" | jq -r '.id_token')
RF_TKN=$(echo "$response" | jq -r '.refresh_token')

kc_reg_idp
kc_logout
