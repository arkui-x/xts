package com.example.concurrentlibtest;

import android.os.Bundle;
import android.util.Log;

import ohos.stage.ability.adapter.StageActivity;


/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * @since 2025-01-24
 */
public class EntryEntryAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "EntryEntryAbilityActivity");
        setInstanceName("com.example.concurrentlibtest:entry:EntryAbility:");
        super.onCreate(savedInstanceState);
    }
}
