package com.example.filepickerxts;

import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import java.util.List;
import ohos.stage.ability.adapter.StageActivity;


/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * StageActivity is provided by ArkUI-X
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class EntryEntryAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "EntryEntryAbilityActivity");
        setInstanceName("com.example.filepickerxts:entry:EntryAbility:");
        super.onCreate(savedInstanceState);
        BroadCast();
    }

    public void BroadCast() {
        new Thread(()->{
            try {
                while (true) {
                    Thread.sleep(1000);
                    getForegroundActivity(this);
                    Thread.sleep(1000);
                    Intent intent2 = new Intent();
                    intent2.setComponent(new ComponentName(getPackageName(), DeviceInfo.class.getName()));
                    intent2.setAction(DeviceInfo.BBBBBB);
                    sendBroadcast(intent2);
                }
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }).start();
    }

    public static void getForegroundActivity(Context context) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        List<ActivityManager.RunningTaskInfo> tasks = null;
        try {
            tasks = activityManager.getRunningTasks(2);
            Log.e("MainActivity",tasks.toString());
            Log.e("topActivity",tasks.get(0).topActivity.toString());

        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
