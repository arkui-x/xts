/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

package com.example.requesttest;

import android.util.Log;

import ohos.stage.ability.adapter.StageApplication;

/**
 * Example ace application class, which will load ArkUI-X application instance.
 * StageApplication is provided by ArkUI-X
 *
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class MyApplication extends StageApplication {
    private static final String LOG_TAG = "HiHelloWorld";

    private static final String RES_NAME = "res";

    @Override
    public void onCreate() {
        Log.e(LOG_TAG, "MyApplication");
        super.onCreate();
        Log.e(LOG_TAG, "MyApplication onCreate");
    }
}
