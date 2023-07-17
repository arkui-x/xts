package com.example.delegatortest;

import android.os.Bundle;
import android.util.Log;

import ohos.stage.ability.adapter.StageActivity;


/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * StageActivity is provided by ArkUI-X
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class FeatureassistMainAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "FeatureassistMainAbilityActivity");
        
        setInstanceName("com.example.delegatortest:featureassist:MainAbility:");
        super.onCreate(savedInstanceState);
    }
}
