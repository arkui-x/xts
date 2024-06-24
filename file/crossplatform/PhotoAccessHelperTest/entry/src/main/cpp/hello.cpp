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

#if defined(IOS_PLATFORM)
#include "include/native_common.h"
#include "include/platform_napi.h"
#endif

static napi_value Select(napi_env env, napi_callback_info info)
{
#if defined(IOS_PLATFORM)
    auto platformNAPIPlugin = PlatformNAPI::Create();
    CHECK_AND_RETURN(platformNAPIPlugin, "platformNAPIPlugin", nullptr);
    auto value = platformNAPIPlugin->Select();
#endif
  
    napi_value result;
    // 创建一个 JavaScript 值 0
    napi_status status = napi_create_int32(env, 0, &result);
    
    if (status != napi_ok) {
        napi_throw_error(env, nullptr, "Failed to create int32");
    }
    return result;
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
    napi_property_descriptor desc[] = {
        { "select", nullptr, Select, nullptr, nullptr, nullptr, napi_default, nullptr }
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version =1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void*)0),
    .reserved = { 0 },
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void)
{
    napi_module_register(&demoModule);
}
