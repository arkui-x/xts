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
import MyTabContents from '../datasource/TabContentData'
import { MyTabContent } from '../beans/MyTabContent';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct WebComponent {
  private tabs: MyTabContent[] = MyTabContents;

  @Styles
  commonStyle() {
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {

      Button('设置页签')
        .onClick(async e => {
          const buttons: promptAction.Button[] = this.tabs.map((item: MyTabContent) => {
            const button: promptAction.Button = {
              text: `Goto ${item.tabBarName}`,
              color: '#333333'
            }
            return button
          })
          const type: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
            title: '请选择跳转的页签',
            buttons: buttons
          })
          const index: number = type.index
          const url: string = 'pages/' + this.tabs[index].tabBarName
          router.pushUrl({ url: url })
        })
        .size({ height: 20 })
    }
    .commonStyle()
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}