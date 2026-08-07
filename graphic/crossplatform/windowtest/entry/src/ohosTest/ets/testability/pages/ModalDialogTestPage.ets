/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { getClickCount, incrementClickCount } from '../ClickCounter';

@Entry
@Component
struct ModalDialogTestPage {
  @State displayCount: number = getClickCount();

  aboutToAppear() {
    console.info('ModalDialogTestPage aboutToAppear — page loaded');
  }

  build() {
    Stack() {
      Button('点击我')
        .id('mainButton')
        .width(200)
        .height(60)
        .position({ x: 150, y: 80 })
        .onClick(() => {
          incrementClickCount();
          this.displayCount = getClickCount();
          console.info('ModalDialogTestPage mainButton clicked, clickCount=' + getClickCount());
        })
      
      Text(this.displayCount.toString())
        .id('clickCountText')
        .fontSize(40)
        .position({ x: 150, y: 170 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
