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

#ifndef NATIVE_COMMON_H
#define NATIVE_COMMON_H

#include <string>
#include <stdarg.h>

#ifdef ANDROID_PLATFORM
#include <android/log.h>
#endif

#ifdef IOS_PLATFORM
#import <os/log.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    LOG_APP = 0,
} LogType;

typedef enum {
    LOG_ERROR = 0,
} LogLevel;

#ifdef __cplusplus
}
#endif

const std::string PRIVATE_FLAG_PUBLIC = "{public}";
const std::string PRIVATE_FLAG_PRIVATE = "{private}";
constexpr uint32_t MAX_BUFFER_SIZE = 4000;
constexpr uint32_t MAX_TIME_SIZE = 32;

#if defined(ANDROID_PLATFORM)
static inline void StripFormatString(std::string &str)
{
    for (auto pos = str.find(PRIVATE_FLAG_PUBLIC, 0); pos != std::string::npos;
        pos = str.find(PRIVATE_FLAG_PUBLIC, pos)) {
        str.erase(pos, PRIVATE_FLAG_PUBLIC.size());
    }
    for (auto pos = str.find(PRIVATE_FLAG_PRIVATE, 0); pos != std::string::npos;
        pos = str.find(PRIVATE_FLAG_PRIVATE, pos)) {
        str.erase(pos, PRIVATE_FLAG_PRIVATE.size());
    }
}

static inline int OH_LOG_Print(
    LogType type, LogLevel level, unsigned int domain, const char *tag, const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    std::string newFmt(fmt);

    StripFormatString(newFmt);

    __android_log_vprint(ANDROID_LOG_ERROR, "PlatformNAPI", newFmt.c_str(), ap);

    va_end(ap);
    return 0;
}
#endif

#if defined(IOS_PLATFORM)
static inline void StripFormatString(std::string &str)
{
    for (auto pos = str.find(PRIVATE_FLAG_PUBLIC, 0); pos != std::string::npos;
        pos = str.find(PRIVATE_FLAG_PUBLIC, pos)) {
        str.erase(pos, PRIVATE_FLAG_PUBLIC.size());
    }
    for (auto pos = str.find(PRIVATE_FLAG_PRIVATE, 0); pos != std::string::npos;
        pos = str.find(PRIVATE_FLAG_PRIVATE, pos)) {
        str.erase(pos, PRIVATE_FLAG_PRIVATE.size());
    }
}

static inline int OH_LOG_Print(
    LogType type, LogLevel level, unsigned int domain, const char *tag, const char *fmt, ...)
{
    std::string newFmt(fmt);
    char buf[MAX_BUFFER_SIZE];
    StripFormatString(newFmt);
    if (snprintf(buf, sizeof(buf) - 1, "%s", newFmt.c_str()) >= 0) {
        os_log(os_log_create("PlatformNAPI", "ERROR"), "[%{public}s] %{public}s", "ERROR", buf);
    }
    return 0;
}
#endif

#ifndef LOGE
#define LOGE(...) ((void)OH_LOG_Print(LOG_APP, LOG_ERROR, 0, "[PlatformNAPI]", __VA_ARGS__))
#endif

#define CHECK_AND_RETURN(ptr, info, ret)                                                                               \
    do {                                                                                                               \
        if (!(ptr)) {                                                                                                  \
            LOGE("PlatformNAPI_TAG %s failed", info);                                                                  \
            return ret;                                                                                                \
        }                                                                                                              \
    } while (0)

#define CHECK_AND_RETURN_VOID(ptr, info)                                                                               \
    do {                                                                                                               \
        if (!(ptr)) {                                                                                                  \
            LOGE("PlatformNAPI_TAG %s failed", info);                                                                  \
            return;                                                                                                    \
        }                                                                                                              \
    } while (0)

#endif /* _NATIVE_COMMON_H_ */
