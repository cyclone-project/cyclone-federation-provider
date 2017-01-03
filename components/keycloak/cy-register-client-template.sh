#!/bin/sh

KEYCLOAK_REALM=${KEYCLOAK_REALM:=master}
KEYCLOAK_URL=${KEYCLOAK_URL:=http://localhost:8080/auth}

usage() {
	echo "usage: cy-register-client-template [options]"
	echo "-f    path to template file"
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

# register new client template
kc_reg_cyclient_template() {
	clienttemplate=$1
	curl -s -X POST "$KEYCLOAK_URL/admin/realms/$KEYCLOAK_REALM/client-templates" \
	     -H "Accept: application/json" \
	     -H "Authorization: Bearer $AC_TKN" \
	     -H "Content-Type: application/json" \
	     -d @$clienttemplate
}

CY_TEMPLATE="cy-client-template.json"

while [ "$1" != "" ]; do
	case $1 in
		-f ) shift
		     CY_TEMPLATE=$1
		     ;;
		 * ) usage
		     exit 1
	esac
	shift
done

response=$(kc_login)
AC_TKN=$(echo "$response" | jq -r '.access_token')
ID_TKN=$(echo "$response" | jq -r '.id_token')
RF_TKN=$(echo "$response" | jq -r '.refresh_token')

kc_reg_cyclient_template $CY_TEMPLATE
kc_logout
