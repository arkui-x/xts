/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.example.photoaccesshelpertest;

import android.app.Application;
import android.content.ClipData;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.app.Activity;
import android.os.Build;
import android.database.Cursor;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import ohos.stage.ability.adapter.StageApplication;

/**
 * Example ace application class, which will load ArkUI-X application instance.
 * StageApplication is provided by ArkUI-X
 *
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 * @since 2024-06-25
 */
public class MyApplication extends StageApplication {
    private static final String LOG_TAG = "PhotoAccessHelperTest";

    private static final String RES_NAME = "res";

    private int number = 2;

    @Override
    public void onCreate() {
        Log.e(LOG_TAG, "MyApplication");
        super.onCreate();
        Log.e(LOG_TAG, "MyApplication onCreate");

        // 注册声明周期回调
        registerActivityLifecycleCallbacks(new Application.ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                Log.i(LOG_TAG, "onActivityCreated: " + activity.getClass().getSimpleName());
            }

            @Override
            public void onActivityStarted(Activity activity) {
                Log.i(LOG_TAG, "onActivityStarted: " + activity.getClass().getSimpleName());
            }

            @Override
            public void onActivityResumed(Activity activity) {
                Log.i(LOG_TAG, "Top Activity: " + activity.getClass().getSimpleName());
            }

            @Override
            public void onActivityPaused(Activity activity) {
                Log.i(LOG_TAG, "onActivityPaused: " + activity.getClass().getSimpleName());
                if (!activity.getClass().getSimpleName().equals("EntryEntryAbilityActivity")) {
                    return;
                } else {
                    // 只在xts的entryAbility暂停时调用
                    if (number > 0) {
                        number--;
                        return;
                    }
                    try {
                        // 处理图片选择器的假结果
                        handleFakeResult(activity);
                        Thread.sleep(2000);
                    } catch (InterruptedException | IOException e) {
                        throw new RuntimeException(e);
                    }
                    activity.finishActivity(1001);
                }
            }

            @Override
            public void onActivityStopped(Activity activity) {
                Log.i(LOG_TAG, "onActivityStopped: " + activity.getClass().getSimpleName());
            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
                Log.i(LOG_TAG, "onActivitySaveInstanceState: " + activity.getClass().getSimpleName());
            }

            @Override
            public void onActivityDestroyed(Activity activity) {
                Log.i(LOG_TAG, "onActivityDestroyed: " + activity.getClass().getSimpleName());
            }
        });
    }

    private void copyRawResourceToMediaStorage(Activity activity, int resourceId, String fileName) throws IOException {
        File picturesDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
        File outputFile = new File(picturesDir, fileName);

        // 检查文件是否已存在
        if (outputFile.exists()) {
            Log.e(LOG_TAG, "文件已存在，跳过复制");
            return;
        }

        // 打开资源文件的输入流
        InputStream inputStream = activity.getResources().openRawResource(resourceId);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ContentValues values = new ContentValues();
            values.put(MediaStore.Images.Media.DISPLAY_NAME, fileName);
            values.put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg");
            values.put(MediaStore.Images.Media.RELATIVE_PATH, Environment.DIRECTORY_PICTURES);

            ContentResolver resolver = activity.getContentResolver();
            Uri uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);

            if (uri != null) {
                OutputStream outputStream = resolver.openOutputStream(uri);
                if (outputStream != null) {
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = inputStream.read(buffer)) > 0) {
                        outputStream.write(buffer, 0, length);
                    }
                    outputStream.close();
                } else {
                    throw new IOException("Failed to open output stream");
                }
            } else {
                throw new IOException("Failed to create new MediaStore record");
            }
        } else {
            FileOutputStream outputStream = new FileOutputStream(outputFile);
            byte[] buffer = new byte[1024];
            int length;
            while ((length = inputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, length);
            }
            outputStream.close();
        }

        inputStream.close();
    }

    private Uri insertImageToMediaStore(Activity activity, String fileName) {
        File file = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), fileName);

        // 检查文件是否已在 MediaStore 中
        String[] projection = { MediaStore.Images.Media._ID };
        String selection = MediaStore.Images.Media.DATA + "=?";
        String[] selectionArgs = new String[]{ file.getAbsolutePath() };

        Cursor cursor = activity.getContentResolver().query(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                projection,
                selection,
                selectionArgs,
                null
        );

        if (cursor != null && cursor.moveToFirst()) {
            int id = cursor.getInt(cursor.getColumnIndexOrThrow(MediaStore.Images.Media._ID));
            cursor.close();
            return Uri.withAppendedPath(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, String.valueOf(id));
        } else {
            cursor.close();

            ContentValues values = new ContentValues();
            values.put(MediaStore.Images.Media.DATA, file.getAbsolutePath());
            values.put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg");
            values.put(MediaStore.Images.Media.TITLE, fileName);
            values.put(MediaStore.Images.Media.DISPLAY_NAME, fileName);

            return activity.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
        }
    }

    private void handleFakeResult(Activity activity) throws IOException {
        if (activity != null) {
            String fileName = "fake_image.jpg";

            // 复制资源文件到设备的 Pictures 目录
            copyRawResourceToMediaStorage(activity, R.raw.fake_image, fileName);

            // 插入图片到 MediaStore 并获取 content URI
            Uri fakeUri = insertImageToMediaStore(activity, fileName);

            Intent data = new Intent();
            ClipData clipData = ClipData.newUri(activity.getContentResolver(), null, fakeUri);
            data.setClipData(clipData);

            data.putExtra(Intent.EXTRA_STREAM, fakeUri);
            data.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            // 通过反射调用 onActivityResult 方法
            try {
                java.lang.reflect.Method method = activity.getClass().getDeclaredMethod(
                        "onActivityResult", int.class, int.class, Intent.class);
                method.setAccessible(true);
                method.invoke(activity, 1001, Activity.RESULT_OK, data);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
