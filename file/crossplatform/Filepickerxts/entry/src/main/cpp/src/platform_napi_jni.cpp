/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

#include "platform_napi_jni.h"

#include <iostream>
#include "native_common.h"
#include "plugin_utils.h"

const char PLATFORM_NAPI_CLASS_NAME[] = "com/example/filepickerxts/DeviceInfo";

static const JNINativeMethod METHODS[] = {
    {"nativeInit", "()V", reinterpret_cast<void *>(PlatformNAPIJni::NativeInit)},
};

struct {
    jmethodID SelectFilePicker;
    jmethodID CloseFilePicker;
    jobject globalRef;
} g_pluginClass;

bool PlatformNAPIJni::Register(void *env) {
    auto *jniEnv = static_cast<JNIEnv *>(env);
    CHECK_AND_RETURN(jniEnv, "jniEnv", false);

    jclass cls = jniEnv->FindClass(PLATFORM_NAPI_CLASS_NAME);
    CHECK_AND_RETURN(cls, "cls", false);

    bool ret = jniEnv->RegisterNatives(cls, METHODS, sizeof(METHODS) / sizeof(METHODS[0])) == 0;
    jniEnv->DeleteLocalRef(cls);

    if (!ret) {
        LOGE("PlatformNAPI_TAG Register native failed");
        return false;
    }
    return true;
}

void PlatformNAPIJni::NativeInit(JNIEnv *env, jobject jobj) {
    g_pluginClass.globalRef = env->NewGlobalRef(jobj);
    CHECK_AND_RETURN_VOID(g_pluginClass.globalRef, "g_pluginClass.globalRef");

    jclass cls = env->GetObjectClass(jobj);
    CHECK_AND_RETURN_VOID(cls, "cls");
    
    g_pluginClass.SelectFilePicker = env->GetMethodID(cls, "selectFile", "()V");
    CHECK_AND_RETURN_VOID(g_pluginClass.SelectFilePicker, "g_pluginClass.SelectFilePicker == null");

    g_pluginClass.CloseFilePicker = env->GetMethodID(cls, "closeFile", "()V");
    CHECK_AND_RETURN_VOID(g_pluginClass.SelectFilePicker, "g_pluginClass.CloseFilePicker == null");

    env->DeleteLocalRef(cls);
}

void PlatformNAPIJni::SelectFilePicker(void) {
    auto env = ARKUI_X_Plugin_GetJniEnv();
    CHECK_AND_RETURN_VOID(env, "env=null");

    CHECK_AND_RETURN_VOID(g_pluginClass.SelectFilePicker, "g_pluginClass.SelectFilePicker");

    env->CallObjectMethod(g_pluginClass.globalRef, g_pluginClass.SelectFilePicker);
}

void PlatformNAPIJni::CloseFilePicker(void) {
    auto env = ARKUI_X_Plugin_GetJniEnv();
    CHECK_AND_RETURN_VOID(env, "env=null");
    CHECK_AND_RETURN_VOID(g_pluginClass.CloseFilePicker, "g_pluginClass.SelectFilePicker");

    env->CallObjectMethod(g_pluginClass.globalRef, g_pluginClass.CloseFilePicker);
}