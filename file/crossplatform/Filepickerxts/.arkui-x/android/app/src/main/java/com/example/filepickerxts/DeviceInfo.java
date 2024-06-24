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

package com.example.filepickerxts;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Intent;
import android.os.Build;
import android.content.Context;
import android.util.Log;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;
import java.util.Objects;

public class DeviceInfo extends BroadcastReceiver {
    private static final String LOG_TAG = "FilePicker";
    public static String BBBBBB = "android.intent.action.TESTBROACAST";
    private Context context = null;

    public DeviceInfo() {
        nativeInit();
    }
    public DeviceInfo(Context context) {
        this.context = context;
        nativeInit();
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals(BBBBBB)) {
            Log.e("MyReceiver",action);
            Intent intent2 = new Intent();
            intent2.setComponent(new ComponentName("com.example.filepickerxts", "com.example.filepickerxts.EntryEntryAbilityActivity"));
            intent2.setAction(Intent.ACTION_MAIN);
            intent2.addCategory(Intent.CATEGORY_LAUNCHER);
            intent2.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            context.startActivity(intent2);
        }
    }

    public String getProductModel() {
        return Build.MODEL;
    }

    public String getDeviceBrand() {
        return Build.BRAND;
    }

    public void closeFile() {
        try {
            Thread.sleep(1000);
        } catch (ActivityNotFoundException e) {
        } catch (InterruptedException e) {
        } catch (Exception e) {
        }
    }

    public void selectFile() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("*/*");
        startPicker(intent);
    }

    private void startPicker(Intent intent) {
        try {
            Objects.requireNonNull(getActivity()).startActivityForResult(intent, 82);
        } catch (ActivityNotFoundException e) {
            Log.e(LOG_TAG, "ActivityNotFoundException, err:", e);
        } catch (Exception e) {
            Log.e(LOG_TAG, "startActivityForResult unknown error, err:", e);
        }
    }
    private Activity getActivity() {
        try {
            Class activityThreadClass = Class.forName("android.app.ActivityThread");
            Object activityThread = activityThreadClass.getMethod("currentActivityThread").invoke(null);
            Field mActivities = activityThreadClass.getDeclaredField("mActivities");
            mActivities.setAccessible(true);
            Map activitiesMap = (Map) mActivities.get(activityThread);
            for (Object activityClientRecord : activitiesMap.values()) {
                Class activityClientRecordClass = activityClientRecord.getClass();
                Field paused = activityClientRecordClass.getDeclaredField("paused");
                paused.setAccessible(true);
                if (!paused.getBoolean(activityClientRecord)) {
                    Field activityField = activityClientRecordClass.getDeclaredField("activity");
                    activityField.setAccessible(true);
                    Activity activity = (Activity) activityField.get(activityClientRecord);
                    return activity;
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
    }
    protected native void nativeInit();
}
