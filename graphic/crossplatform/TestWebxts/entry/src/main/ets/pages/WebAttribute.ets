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

import router from '@ohos.router'
import { webview } from '@kit.ArkWeb'

@Entry
@Component
struct WebAttribute {
  private controller: webview.WebviewController = new webview.WebviewController()
  @State private feedbackTitle: string = '等待操作'
  @State private feedbackText: string = '点击按钮或等待 Web 加载后，这里会显示成功或失败的反馈信息。'
  @State private feedbackColor: string = '#0A59F7'

  private showSuccess(action: string, detail: string) {
    this.feedbackTitle = `${action} 成功`
    this.feedbackText = detail
    this.feedbackColor = '#2AAE67'
  }

  private showError(action: string, error: BusinessError<void>) {
    this.feedbackTitle = `${action} 失败`
    this.feedbackText = `ErrorCode: ${error.code}, Message: ${error.message}`
    this.feedbackColor = '#E84026'
  }

  private loadDefaultUserAgent() {
    try {
      let defaultUserAgent = webview.WebviewController.getDefaultUserAgent()
      this.showSuccess('获取默认 UserAgent', `Default User Agent: ${defaultUserAgent}`)
    } catch (error) {
      this.showError('获取默认 UserAgent', error as BusinessError<void>)
    }
  }

  aboutToAppear(): void {
    this.loadDefaultUserAgent()
  }

  build() {
    Column({ space: 16 }) {
      Row() {
        Row({ space: 2 }) {
          Text('🔙')
            .fontSize(24)
            .fontColor('#333333')
          Text('返回')
            .fontSize(16)
            .fontColor('#333333')
        }
      }
      .id('web_attribute_back')
      .width('100%')
      .height(36)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .margin({ left: -24 })
      .onClick(() => {
        try {
          router.back()
        } catch (error) {
          this.showError('返回主页面', error as BusinessError<void>)
        }
      })

      Column({ space: 4 }) {
        Text('WebAttribute')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
        Text('WebView 属性设置与获取测试')
          .fontSize(13)
          .fontColor('#888888')
          .width('100%')
      }

      Column({ space: 8 }) {
        Row() {
          Text('● 执行结果')
            .fontSize(12)
            .fontColor(this.feedbackColor)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')

        Text(this.feedbackTitle)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.feedbackColor)
          .id('web_attribute_feedback')

        Text(this.feedbackText)
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(20)
      }
      .width('100%')
      .padding(16)
      .borderRadius(12)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: this.feedbackColor })

      Button('获取默认 UserAgent')
        .width('100%')
        .height(48)
        .id('web_attribute_get_default_user_agent')
        .onClick(() => {
          this.loadDefaultUserAgent()
        })


      Web({ src: 'https://www.example.com', controller: this.controller })
        .width('100%')
        .layoutWeight(1)
        .borderRadius(12)
        .onResourceLoad((event) => {
          this.showSuccess('onResourceLoad资源加载回调', `资源加载成功：${event.url}`)
        })
    }
    .width('100%')
    .height('100%')
    .padding(24)
  }
}

