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

#include "napi/native_api.h"

#ifdef ANDROID_PLATFORM
#include "native_common.h"
#include "plugin_utils.h"
#include "platform_napi.h"
#include "platform_napi_jni.h"
#endif

#if defined(IOS_PLATFORM)
#include "include/native_common.h"
#include "render_surface.h"
#include "plugin_utils.h"

#include <cstdlib>
#endif


#if defined(ANDROID_PLATFORM)
static napi_value SelectFilePicker(napi_env env, napi_callback_info info)
{
    auto platformNAPIPlugin = PlatformNAPI::Create();
    CHECK_AND_RETURN(platformNAPIPlugin, "platformNAPIPlugin", nullptr);
    platformNAPIPlugin->SelectFilePicker();
    napi_value result = nullptr;
    napi_get_undefined(env, &result);
    return result;
}

static napi_value CloseFilePicker(napi_env env, napi_callback_info info)
{
    auto platformNAPIPlugin = PlatformNAPI::Create();
    CHECK_AND_RETURN(platformNAPIPlugin, "platformNAPIPlugin", nullptr);
    platformNAPIPlugin->CloseFilePicker();
    napi_value result = nullptr;
    napi_get_undefined(env, &result);
    return result;
}
#endif


#if defined(IOS_PLATFORM)
static napi_value Select(napi_env env, napi_callback_info info)
{
#if !defined(ANDROID_PLATFORM)
    RenderSurface::select();
#endif
    return nullptr;
}
#endif

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
    napi_property_descriptor desc[] = {
#if defined(ANDROID_PLATFORM)
        {"SelectFilePicker", nullptr, SelectFilePicker, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"CloseFilePicker", nullptr, CloseFilePicker, nullptr, nullptr, nullptr, napi_default, nullptr},
#endif
#if defined(IOS_PLATFORM)
        {"select", nullptr, Select, nullptr, nullptr, nullptr, napi_default, nullptr},
#endif
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

#ifdef ANDROID_PLATFORM
static void PlatformNAPIJniRegister()
{
    const char className[] = "com.example.filepickerxts.DeviceInfo";
    ARKUI_X_Plugin_RegisterJavaPlugin(&PlatformNAPIJni::Register, className);
}
#endif

extern "C" __attribute__((constructor)) void RegisterEntryModule(void)
{
    napi_module_register(&demoModule);
#ifdef ANDROID_PLATFORM
    ARKUI_X_Plugin_RunAsyncTask(&PlatformNAPIJniRegister, ARKUI_X_Plugin_Thread_Mode::ARKUI_X_PLUGIN_PLATFORM_THREAD);
#endif
}
