package org.cyclone.cacheclear;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.keycloak.admin.client.Keycloak;

import java.util.*;

public class CacheClearTask extends TimerTask {

    private MongoClient mongoClient;
    private Keycloak keycloakClient;
    private List<String> excludedUsers;
    private String realm;
    private MongoCollection<Document> usersCollection;
    private ArrayList<Document> usersList = new ArrayList<Document>();
    private ArrayList<String> expiredUsers = new ArrayList<String>();

    public CacheClearTask(MongoClient mongoClient, Keycloak keycloakClient, List<String> excludedUsers, String realm) {
        this.mongoClient = mongoClient;
        this.keycloakClient = keycloakClient;
        this.excludedUsers = excludedUsers;
        this.realm = realm;
    }

    @Override
    public void run() {
        System.out.println("-- Started Expired User Cleaning --");
        usersCollection = mongoClient.getDatabase("keycloak")
                .getCollection("users");

        getUsersList();
        checkUserSession();
        deleteExpiredUsers();
        usersList = new ArrayList<Document>();
        expiredUsers = new ArrayList<String>();
    }

    private void getUsersList() {
        usersList = usersCollection.find(new Document("realmId", this.realm)).into(new ArrayList<Document>());
    }

    private void checkUserSession() {
        for (Document user : usersList) {
            String userId = user.get("_id").toString();
            String userName = user.get("username").toString();

            // exclude configured users
            if (excludedUsers.contains(userName)) {
                continue;
            }
            int sessionNumber = keycloakClient.realm("master")
                    .users()
                    .get(userId)
                    .getUserSessions()
                    .size();
            if (sessionNumber == 0) {
                expiredUsers.add(userId);
            }
        }
    }

    private void deleteExpiredUsers() {
        Bson filter = Filters.in("_id", expiredUsers);
        usersCollection.deleteMany(filter);

        System.out.format("Cleared %d users from the database\n", expiredUsers.size());
        System.out.println("-- Ended clearing the user database --");
    }

}
