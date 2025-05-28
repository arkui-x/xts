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

import registerJavaScriptProxy_Function from './RegisterJavaScriptProxy_Function.test';
import registerJavaScriptProxy_Component from './RegisterJavaScriptProxy_Component.test';
import deleteJavaScriptRegister_Function from './DeleteJavaScriptRegister_Function.test'

export default function testsuite() {
  registerJavaScriptProxy_Function();
  registerJavaScriptProxy_Component();
  deleteJavaScriptRegister_Function();
}