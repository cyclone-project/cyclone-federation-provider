package org.cyclone.cacheclear;

import com.mongodb.MongoClient;
import org.keycloak.admin.client.Keycloak;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

public class Main {

    public static void main(String[] args) {

        Properties prop = new Properties();
        InputStream input = null;

        // Env variables
        String adminUser = null;
        String adminPass = null;
        String adminClient = null;
        String realm = null;
        String keycloakHost = null;
        String mongoHost = null;
        int period = 0;
        List<String> excludedUsers = null;

        try {
            adminUser = System.getenv("KEYCLOAK_ADMIN_USER");
            adminPass = System.getenv("KEYCLOAK_ADMIN_PASS");
            adminClient = System.getenv("KEYCLOAK_ADMIN_CLIENT");
            realm = System.getenv("KEYCLOAK_REALM");
            keycloakHost = "http://" + System.getenv("KEYCLOAK_PORT_8080_TCP_ADDR") + ":8080/auth";
            mongoHost = System.getenv("KEYCLOAKDB_PORT_27017_TCP_ADDR");
            period = Integer.parseInt(System.getenv("PERIOD"));
            if (period == 0) {
                period = 60000;
            }
            excludedUsers = Arrays.asList(System.getenv("EXCLUDED_USERS").split(";"));

            System.out.println("ERROR: There are missing ENV variables to set.");
            // System.out.format("Admin User: %s \n", adminUser);
            // System.out.format("Admin Pass: %s \n", adminPass);
            // System.out.format("Admin Client: %s \n", adminClient);
            System.out.format("Keycloak Realm: %s \n", realm);
            System.out.format("Keycloak Host: %s \n", keycloakHost);
            System.out.format("Mongo Host: %s \n", mongoHost);
            System.out.format("Period: %s \n", period);

        }
        catch (NumberFormatException ex) {
            period = Integer.parseInt(prop.getProperty("time"));
            System.out.println("Loaded default period");
        }
        catch (NullPointerException ex) {
            System.out.println("ERROR: There are missing ENV variables to set.");
            // System.out.format("Admin User: %s \n", adminUser);
            // System.out.format("Admin Pass: %s \n", adminPass);
            // System.out.format("Admin Client: %s \n", adminClient);
            System.out.format("Keycloak Realm: %s \n", realm);
            System.out.format("Keycloak Host: %s \n", keycloakHost);
            System.out.format("Mongo Host: %s \n", mongoHost);
            System.out.format("Period: %s \n", period);
            ex.printStackTrace();
        }

        Timer t = new Timer();

        // Create the connections aso they don't have to be recreated at each run
        try {
            Keycloak keycloakClient = Keycloak.getInstance(
                    keycloakHost,
                    realm, // the realm to log in to
                    adminUser, adminPass,  // the user
                    adminClient);

            MongoClient mongoClient = new MongoClient(mongoHost);

            CacheClearTask mClearTask = new CacheClearTask(mongoClient, keycloakClient, excludedUsers, realm);
            // This task is scheduled to run every 60 seconds

            t.scheduleAtFixedRate(mClearTask, 0, period);
        }
        catch (NullPointerException ex) {
            System.out.println("ERROR: There are missing ENV variables to set.");
            // System.out.format("ERROR: Admin User: %s \n", adminUser);
            // System.out.format("ERROR: Admin Pass: %s \n", adminPass);
            // System.out.format("ERROR: Admin Client: %s \n", adminClient);
            System.out.format("ERROR: Keycloak Realm: %s \n", realm);
            System.out.format("ERROR: Keycloak Host: %s \n", keycloakHost);
            System.out.format("ERROR: Mongo Host: %s \n", mongoHost);
            System.out.format("ERROR: Period: %s \n", period);
            ex.printStackTrace();
        }
    }
}
