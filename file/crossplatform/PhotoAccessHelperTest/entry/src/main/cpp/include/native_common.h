/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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

#define CHECK_AND_RETURN(ptr, info, ret)                                                                               \
    do {                                                                                                               \
        if (!(ptr)) {                                                                                                  \
            return ret;                                                                                                \
        }                                                                                                              \
    } while (0)

#define CHECK_AND_RETURN_VOID(ptr, info)                                                                               \
    do {                                                                                                               \
        if (!(ptr)) {                                                                                                  \
            return;                                                                                                    \
        }                                                                                                              \
    } while (0)

#endif /* _NATIVE_COMMON_H_ */
