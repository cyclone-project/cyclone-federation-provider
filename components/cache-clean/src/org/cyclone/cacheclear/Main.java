package org.cyclone.cacheclear;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Timer;
import java.util.Properties;

public class Main {

    public static void main(String[] args) {

        Properties prop = new Properties();
        InputStream input = null;

        try {

            input = new FileInputStream("config.properties");

            // load a properties file
            prop.load(input);

            // get the property value and print it out
            System.out.println(prop.getProperty("time"));

        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        Timer t = new Timer();
        ClearCacheTask mClearTask = new ClearCacheTask();
        // This task is scheduled to run every 10 seconds

        t.scheduleAtFixedRate(mClearTask, 0, Integer.parseInt(prop.getProperty("time")));
    }
}
