/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { AbilityStage, Configuration } from '@kit.AbilityKit'

export default class MyAbilityStage extends AbilityStage {
  public static configuration: Configuration | undefined = undefined

  onCreate(): void {
    console.info('MyAbilityStage Ability onCreate')
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    console.info('MyAbilityStage onConfigurationUpdate newConfig is ' + JSON.stringify(newConfig))
    MyAbilityStage.configuration = newConfig;
  }
}