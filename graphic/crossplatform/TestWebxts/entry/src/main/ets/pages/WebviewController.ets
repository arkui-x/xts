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

import router from '@ohos.router'
import { webview } from '@kit.ArkWeb'

@Extend(Text)
function sectionTitle() {
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .fontColor('#1A1A1A')
  .width('100%')
}

@Extend(Column)
function sectionCard() {
  .width('100%')
  .padding(16)
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .border({ width: 1, color: '#E5EAF0' })
}

interface NetworkAvailableTestController {
  setNetworkAvailable(value?: boolean | null): void;
}

@Entry
@Component
struct WebviewControllerPage {
  private controller: webview.WebviewController = new webview.WebviewController()
  @State private feedbackTitle: string = '等待操作'
  @State private feedbackText: string = '点击 setNetworkAvailable(true/false) 会自动设置网络状态并刷新页面'
  @State private feedbackColor: string = '#0A59F7'
  @State private latestNetworkAvailable: string = '未设置'

  private backToHome() {
    try {
      router.back()
    } catch (error) {
      this.showError('返回主页面', error as BusinessError<void>)
    }
  }

  private applyNetworkAvailable(available: boolean) {
    try {
      this.controller.setNetworkAvailable(available)
      this.latestNetworkAvailable = this.formatNetworkValue(available)
      this.controller.refresh()
      this.showSuccess('setNetworkAvailable', `网络可用状态已设置为 ${available} 并触发页面刷新。`)
    } catch (error) {
      this.showError('setNetworkAvailable', error as BusinessError<void>)
    }
  }

  private applyInvalidNetworkAvailable(value: null | undefined) {
    let valueLabel = this.formatNetworkValue(value)
    try {
      this.latestNetworkAvailable = valueLabel
      let testController = this.controller as NetworkAvailableTestController
      testController.setNetworkAvailable(value)
      this.showErrorText('非法参数场景', `未命中预期异常：setNetworkAvailable(${valueLabel}) 没有抛出错误。`)
    } catch (error) {
      let businessError: BusinessError<void> = error as BusinessError<void>
      this.feedbackTitle = `非法参数 ${valueLabel} 已命中`
      this.feedbackText =
        `已捕获预期异常：setNetworkAvailable(${valueLabel}) 调用失败。ErrorCode: ${businessError.code}, Message: ${businessError.message}`
      this.feedbackColor = '#FF8A00'
    }
  }

  private formatNetworkValue(value: boolean | null | undefined): string {
    if (value === null) {
      return 'null'
    }
    if (value === undefined) {
      return 'undefined'
    }
    return value ? 'true' : 'false'
  }


  private showSuccess(action: string, detail: string) {
    this.feedbackTitle = `${action} 成功`
    this.feedbackText = detail
    this.feedbackColor = '#2AAE67'
  }

  private showErrorText(action: string, detail: string) {
    this.feedbackTitle = `${action} 提示`
    this.feedbackText = detail
    this.feedbackColor = '#E67E22'
  }

  private showError(action: string, error: BusinessError<void>) {
    this.feedbackTitle = `${action} 失败`
    this.feedbackText = `ErrorCode: ${error.code}, Message: ${error.message}`
    this.feedbackColor = '#E84026'
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
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
        .id('webview_controller_back')
        .width('100%')
        .height(36)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.backToHome()
        })

        Column({ space: 4 }) {
          Text('WebviewController')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')
            .width('100%')
          Text('网络控制与页面状态测试（设置网络后自动刷新）')
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

          Text(`网络状态：${this.latestNetworkAvailable}`)
            .fontSize(14)
            .fontColor('#1A1A1A')
            .fontWeight(FontWeight.Bold)

          Text(this.feedbackTitle)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.feedbackColor)

          Text(this.feedbackText)
            .fontSize(14)
            .fontColor('#666666')
            .lineHeight(20)
            .id('webview_controller_feedback')

        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: this.feedbackColor })

        Column({ space: 8 }) {
          Text('网络可用状态测试').sectionTitle()

          Row({ space: 12 }) {
            Button('setNetworkAvailable(true)')
              .layoutWeight(1)
              .height(48)
              .id('webview_controller_set_network_available_true')
              .onClick(() => {
                this.applyNetworkAvailable(true)
              })

            Button('setNetworkAvailable(false)')
              .layoutWeight(1)
              .height(48)
              .id('webview_controller_set_network_available_false')
              .onClick(() => {
                this.applyNetworkAvailable(false)
              })
          }
          .width('100%')

          Row({ space: 12 }) {
            Button('setNetworkAvailable(null)')
              .layoutWeight(1)
              .height(48)
              .id('webview_controller_set_network_available_null')
              .onClick(() => {
                this.applyInvalidNetworkAvailable(null)
              })

            Button('setNetworkAvailable(undefined)')
              .layoutWeight(1)
              .height(48)
              .id('webview_controller_set_network_available_undefined')
              .onClick(() => {
                this.applyInvalidNetworkAvailable(undefined)
              })
          }
          .width('100%')
        }
        .sectionCard()


        Column({ space: 10 }) {
          Text('Web 预览区域').sectionTitle()

          Text('加载本地测试页，用于配合 setNetworkAvailable 和刷新行为观察页面变化。')
            .fontSize(13)
            .fontColor('#666666')
            .lineHeight(18)
            .width('100%')

          Web({ src: $rawfile('index.html'), controller: this.controller })
            .width('100%')
            .height(260)
            .borderRadius(12)
        }
        .sectionCard()
      }
      .width('100%')
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}

