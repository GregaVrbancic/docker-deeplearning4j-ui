package xyz.grega.deeplearning4jui;

import org.deeplearning4j.ui.api.UIServer;
import org.deeplearning4j.ui.storage.FileStatsStorage;

import java.io.File;

public class Server {
    public static void main(String[] args) {
        UIServer uiServer = UIServer.getInstance();
        FileStatsStorage fileStatsStorage = new FileStatsStorage(new File(System.getProperty("user.home"), "deeplearning4j-ui-data"));
        uiServer.attach(fileStatsStorage);
        uiServer.enableRemoteListener();
    }
}
