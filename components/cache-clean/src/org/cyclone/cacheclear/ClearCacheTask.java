package org.cyclone.cacheclear;

import java.util.TimerTask;

public class ClearCacheTask extends TimerTask{
    @Override
    public void run() {
        System.out.println("Hi see you after 10 seconds");
    }
}
