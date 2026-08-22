package com.example.requestcachedownloadtest;

import android.util.Log;

import fi.iki.elonen.NanoHTTPD;

import java.io.ByteArrayInputStream;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Local HTTP server for cacheDownload XTS testing.
 *
 * Replaces the product-code hack (CacheDownloadHttpClient.java localhost interception)
 * with proper test infrastructure. Serves test content on port 8080 so that XTS tests
 * using http://127.0.0.1:8080 URLs get real HTTP responses via the clean HttpURLConnection
 * path in the plugin.
 *
 * Started from MyApplication.onCreate() so the server is ready before any test runs.
 *
 * @since 1.0.0
 */
public class LocalHttpServer extends NanoHTTPD {
    private static final String TAG = "LocalHttpServer";

    /** Port the local test server listens on. */
    public static final int PORT = 8080;

    // Ensures each download gets a unique totalTime so tests like
    // testGetDownloadInfo001/005 (which download the same URL twice and expect
    // different totalTime values) pass without product-code fake delays.
    private final AtomicInteger requestCounter = new AtomicInteger(0);

    public LocalHttpServer() {
        super(PORT);
    }

    @Override
    public Response serve(IHTTPSession session) {
        String uri = session.getUri();
        String method = session.getMethod().name();
        Log.i(TAG, "Request: " + method + " " + uri);

        // Variable delay so same-URL downloads have different totalTime values.
        // Capped with modulo to keep delay bounded (5-152ms) — unbounded growth
        // caused downloads to exceed the 500ms sleep window in later tests.
        int delay = 5 + (requestCounter.incrementAndGet() % 50) * 3;
        try {
            Thread.sleep(delay);
        } catch (InterruptedException e) {
            // Delay interrupted; proceed without restoring interrupt flag (test infra only).
        }

        // --- 404 paths ---
        // Tests expect these URLs to fail with HTTP 404 (errorCode 48 in cacheDownload).
        // Extra delay: tests register onDownloadError AFTER calling download(), so the
        // 404 response must arrive after the callback is registered. Without this delay,
        // localhost responds too fast and the error fires before the callback is set up.
        if (uri.contains("test123") || uri.contains("testxxx") ||
            uri.contains("error.jpg") || uri.contains("testpicture7") ||
            uri.contains("notfound")) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                // Delay interrupted; proceed without restoring interrupt flag (test infra only).
            }
            Log.w(TAG, "Returning 404 for: " + uri);
            return newFixedLengthResponse(Response.Status.NOT_FOUND, "text/plain", "404 Not Found");
        }

        // --- 400K text file ---
        // CacheDownloadInfo tests expect a ~400KB file for size verification.
        if (uri.contains("test400K") || uri.contains("400k")) {
            byte[] data = generateRepeatedBytes((byte) 'a', 400 * 1024);
            return newFixedLengthResponse(Response.Status.OK, "text/plain",
                    new ByteArrayInputStream(data), data.length);
        }

        // --- Text files ---
        if (uri.endsWith(".txt") || uri.equals("/") || uri.isEmpty() ||
            uri.contains("test_picture") || uri.contains("testfile")) {
            String body = "This is a test file for cacheDownload XTS testing.";
            return newFixedLengthResponse(Response.Status.OK, "text/plain", body);
        }

        // --- JSON files ---
        if (uri.endsWith(".json")) {
            String json = "{\"status\":\"success\",\"count\":10}";
            return newFixedLengthResponse(Response.Status.OK, "application/json", json);
        }

        // --- MP3 audio ---
        if (uri.endsWith(".mp3")) {
            byte[] data = generateRepeatedBytes((byte) 0x49, 5120);
            return newFixedLengthResponse(Response.Status.OK, "audio/mpeg",
                    new ByteArrayInputStream(data), data.length);
        }

        // --- Image files (jpg/png) ---
        if (uri.endsWith(".jpg") || uri.endsWith(".png") || uri.endsWith(".jpeg")) {
            Log.i(TAG, "Returning 200 image for: " + uri);
            byte[] data = generateRepeatedBytes((byte) 0xFF, 10240);
            return newFixedLengthResponse(Response.Status.OK, "image/jpeg",
                    new ByteArrayInputStream(data), data.length);
        }

        // --- Default: 200 OK with text content ---
        Log.i(TAG, "Returning 200 default for: " + uri);
        String body = "This is a test file for cacheDownload.";
        return newFixedLengthResponse(Response.Status.OK, "text/plain", body);
    }

    private static byte[] generateRepeatedBytes(byte b, int size) {
        byte[] data = new byte[size];
        for (int i = 0; i < size; i++) {
            data[i] = b;
        }
        return data;
    }
}
