package com.example.requestcachedownloadtest;

import android.util.Log;

import java.io.IOException;

import ohos.stage.ability.adapter.StageApplication;

import fi.iki.elonen.NanoHTTPD;

/**
 * Example ace application class, which will load ArkUI-X application instance.
 * StageApplication is provided by ArkUI-X
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class MyApplication extends StageApplication {
    private static final String LOG_TAG = "HiHelloWorld";

    private static final String RES_NAME = "res";

    @Override
    public void onCreate() {
        Log.e(LOG_TAG, "MyApplication");
        super.onCreate();
        Log.e(LOG_TAG, "MyApplication onCreate");

        // Start local HTTP server for cacheDownload XTS testing.
        // Provides real HTTP responses on http://127.0.0.1:8080 so tests
        // exercise the clean HttpURLConnection path in the plugin.
        try {
            LocalHttpServer server = new LocalHttpServer();
            server.start(NanoHTTPD.SOCKET_READ_TIMEOUT, false);
            Log.i(LOG_TAG, "LocalHttpServer started on port " + LocalHttpServer.PORT);
        } catch (IOException e) {
            Log.e(LOG_TAG, "LocalHttpServer failed to start: " + e.getMessage());
        }
    }
}
