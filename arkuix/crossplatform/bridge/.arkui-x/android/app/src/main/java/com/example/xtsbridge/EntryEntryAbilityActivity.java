/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.xtsbridge;

import android.os.Bundle;
import android.util.Log;

import ohos.ace.adapter.capability.bridge.BridgePlugin;
import ohos.stage.ability.adapter.StageActivity;

/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * StageActivity is provided by ArkUI-X
 *
 * @since 2026-01-16
 */
public class EntryEntryAbilityActivity extends StageActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "EntryEntryAbilityActivity");
        setInstanceName("com.example.xtsbridge:entry:EntryAbility:");
        super.onCreate(savedInstanceState);

        new BridgeImpl("testXts", BridgePlugin.BridgeType.JSON_TYPE);
        new BridgeImpl("testXtsCallBack", BridgePlugin.BridgeType.JSON_TYPE);
        new BridgeImpl("testXtsCallMethod", BridgePlugin.BridgeType.JSON_TYPE);
        new BridgeImpl("testXtsError", BridgePlugin.BridgeType.JSON_TYPE);

        new BridgeImpl("testXtsBinary", BridgePlugin.BridgeType.BINARY_TYPE);
        new BridgeImpl("testXtsBinaryCallBack", BridgePlugin.BridgeType.BINARY_TYPE);
        new BridgeImpl("testXtsBinaryCallMethod", BridgePlugin.BridgeType.BINARY_TYPE);
        new BridgeImpl("testXtsBinaryError", BridgePlugin.BridgeType.BINARY_TYPE);

    }
}
