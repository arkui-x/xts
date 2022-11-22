package com.open.harmony.myapplication;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;

import ohos.ace.adapter.AceActivity;

import androidx.annotation.Nullable;

/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * AceActivity is provided by ArkUI-X
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class MainActivity extends AceActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "MainActivity");
        setVersion(VERSION_ETS);
        setInstanceName("entry_MainAbility");
        super.onCreate(savedInstanceState);
    }
}
