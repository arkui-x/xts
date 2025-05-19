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

import { common, Want } from '@kit.AbilityKit'

@Entry
@Component
struct Index {
  @State message: string = '辅助app assisttest'

  onPageShow(): void {
    setTimeout(() => {
      let context = getContext(this) as common.UIAbilityContext
      const want: Want = {
        bundleName: 'com.example.windisplayxts',
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      }
      console.info('quanzhen 000000')
      context.startAbility(want)
      console.info('quanzhen 123')
    }, 1500)
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}