#include "napi/native_api.h"
#include "rawfile/raw_file.h"
#include "rawfile/raw_file_manager.h"
#include <system_error>

napi_value CreateJsBool(napi_env env, bool &bValue)
{
    napi_value jsValue = nullptr;
    if (napi_get_boolean(env, bValue, &jsValue) != napi_ok) {
        return nullptr;
    }
    return jsValue;
}

static napi_value IsRawDir(napi_env env, napi_callback_info info)
{
    size_t argc = 2;
    napi_value argv[2] = {nullptr};
    // 获取参数信息
    napi_get_cb_info(env, info, &argc, argv, nullptr, nullptr);

    napi_valuetype valueType;
    napi_typeof(env, argv[0], &valueType);
    // 获取native的resourceManager对象
    NativeResourceManager *mNativeResMgr = OH_ResourceManager_InitNativeResourceManager(env, argv[0]);

    napi_valuetype valueType1;
    napi_typeof(env, argv[1], &valueType1);
    if (valueType1 == napi_undefined || valueType1 == napi_null) {
        bool temp = false;
        return CreateJsBool(env, temp);
    }
    size_t strSize;
    char strBuf[256];
    napi_get_value_string_utf8(env, argv[1], strBuf, sizeof(strBuf), &strSize);
    std::string filename(strBuf, strSize);
    bool result = OH_ResourceManager_IsRawDir(mNativeResMgr, filename.c_str());
    OH_ResourceManager_ReleaseNativeResourceManager(mNativeResMgr);
    return CreateJsBool(env, result);
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports)
{
    napi_property_descriptor desc[] = {
        {"isRawDir", nullptr, IsRawDir, nullptr, nullptr, nullptr, napi_default, nullptr}};
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

extern "C" __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&demoModule); }
