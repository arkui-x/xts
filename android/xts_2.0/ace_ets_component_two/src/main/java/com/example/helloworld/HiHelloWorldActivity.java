/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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

package com.example.helloworld;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;

import ohos.ace.adapter.AceActivity;

import androidx.annotation.Nullable;

public class HiHelloWorldActivity extends AceActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "HiHelloWorldActivity");
        setVersion(2);   // add serVersion calling before super onStart
        setInstanceName("MainAbility");
        super.onCreate(savedInstanceState);
    }
}