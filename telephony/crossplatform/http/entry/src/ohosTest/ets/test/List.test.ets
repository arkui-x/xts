/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import onAndoff from './onAndoff.test'
import requestInStream1 from './requestInStream1.test'
import requestInStream2 from './requestInStream2.test'
import requestInStream3 from './requestInStream3.test'

export default function testsuite() {
  requestInStream1()
  requestInStream2()
  requestInStream3()
  onAndoff()
}