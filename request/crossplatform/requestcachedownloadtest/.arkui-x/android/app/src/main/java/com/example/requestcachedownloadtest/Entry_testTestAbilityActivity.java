package com.example.requestcachedownloadtest;

import android.os.Bundle;

import ohos.stage.ability.adapter.StageActivity;

/**
 * Test ability activity of the entry_test module, which loads the ArkUI-X
 * test instance for the cacheDownload XTS suite.
 * StageActivity is provided by ArkUI-X
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 * @since 2026-09-12
 * @version 1.0
 */
public class Entry_testTestAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setInstanceName("com.example.requestcachedownloadtest:entry_test:TestAbility:");
        super.onCreate(savedInstanceState);
    }
}
