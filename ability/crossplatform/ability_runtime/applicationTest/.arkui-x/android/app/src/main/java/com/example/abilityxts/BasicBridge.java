/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

package com.example.abilityxts;

import android.content.Context;
import android.content.pm.ActivityInfo;
import android.util.Log;

import ohos.ace.adapter.capability.bridge.BridgeManager;
import ohos.ace.adapter.capability.bridge.BridgePlugin;

/**
 * Platform-side Bridge object, calling native methods.
 *
 * @since 2025-01-16
 */
public class BasicBridge extends BridgePlugin {
    private final String TAG = "BasicBridge";

    private String name;

    private Context context;

    /**
     * Func: constructor
     *
     * @param context       Context of the current Activity
     * @param name          Platform bridge name
     * @param bridgeManager BridgePlugin object manager
     * @since 2025-01-16
     */
    public BasicBridge(Context context, String name, BridgeManager bridgeManager) {
        super(context, name, bridgeManager);
        this.name = name;
        this.context = context;
    }

    /**
     * Func: Set System Orientation
     *
     * @param isLandscape System Orientation. if Landscape, is true
     * @since 2025-01-16
     */
    public void setSystemOrientation(boolean isLandscape) {
        try {
            if (this.context instanceof EntryEntryAbilityActivity) {
                EntryEntryAbilityActivity Context = (EntryEntryAbilityActivity) this.context;
                if (isLandscape) {
                    Context.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
                } else {
                    Context.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "setSystemOrientation failed. Cause: " + e.toString());
        }
    }
}