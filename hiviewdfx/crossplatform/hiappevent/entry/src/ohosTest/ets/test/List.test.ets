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

import ErrorManager from './ErrorManager.test'
import HiAppEvent1 from './HiAppEvent1.test'
import HiAppEvent2 from './HiAppEvent2.test'
import HiAppEvent3 from './HiAppEvent3.test'
import HiAppEvent4 from './HiAppEvent4.test'
import HiAppEvent5 from './HiAppEvent5.test'
import HiAppEvent6 from './HiAppEvent6.test'

export default function testsuite() {
  HiAppEvent1()
  HiAppEvent2()
  HiAppEvent3()
  HiAppEvent4()
  HiAppEvent5()
  HiAppEvent6()
  ErrorManager()
}