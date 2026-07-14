package com.example.interactioneffecttest;

import android.os.Bundle;
import android.util.Log;

import ohos.stage.ability.adapter.StageActivity;

/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * StageActivity is provided by ArkUI-X
 *
 * @since 2026-06-23
 */
public class EntryEntryAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "EntryEntryAbilityActivity");
        setInstanceName("com.example.interactioneffecttest:entry:EntryAbility:");
        super.onCreate(savedInstanceState);
    }
}
