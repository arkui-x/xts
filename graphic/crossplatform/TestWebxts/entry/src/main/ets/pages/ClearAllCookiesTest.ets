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

const TEST_URL: string = 'https://www.example.com'
const NORMAL_COOKIE_NAME: string = 'normal_test_cookie'
const INCOGNITO_COOKIE_NAME: string = 'incognito_test_cookie'

@Extend(Button)
function testButton() {
  .width('48%')
  .height(28)
  .borderRadius(6)
  .fontSize(9)
  .backgroundColor('#0A59F7')
}

@Extend(Column)
function testCard() {
  .width('100%')
  .padding(6)
  .backgroundColor('#FFFFFF')
  .borderRadius(8)
  .border({ width: 1, color: '#E5EAF0' })
}

@Entry
@Component
struct ClearAllCookiesTest {
  private normalController: webview.WebviewController = new webview.WebviewController()
  private incognitoController: webview.WebviewController = new webview.WebviewController()
  @State private feedbackTitle: string = '等待操作'
  @State private feedbackText: string = '点击下方按钮执行 clearAllCookiesSync 验证测试。'
  @State private feedbackColor: string = '#0A59F7'
  @State private normalCookieBefore: string = '-'
  @State private normalCookieAfter: string = '-'
  @State private incognitoCookieBefore: string = '-'
  @State private incognitoCookieAfter: string = '-'

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

  private backToHome() {
    try {
      router.back()
    } catch (error) {
      this.showError('返回主页面', error as BusinessError<void>)
    }
  }

  private writeNormalCookie() {
    try {
      let cookieValue = `${NORMAL_COOKIE_NAME}=v${Date.now()}; Path=/; SameSite=Lax`
      webview.WebCookieManager.configCookieSync(TEST_URL, cookieValue)
      this.showSuccess('正常模式写入 Cookie', `已写入：${cookieValue}`)
    } catch (error) {
      this.showError('正常模式写入 Cookie', error as BusinessError<void>)
    }
  }

  private readNormalCookie() {
    try {
      let value = webview.WebCookieManager.fetchCookieSync(TEST_URL)
      return value || '(空)'
    } catch (error) {
      this.showError('正常模式读取 Cookie', error as BusinessError<void>)
      return '读取失败'
    }
  }

  private async writeIncognitoCookie() {
    try {
      let cookieValue = `${INCOGNITO_COOKIE_NAME}=v${Date.now()}; Path=/; SameSite=Lax`
      webview.WebCookieManager.configCookieSync(TEST_URL, cookieValue, true)
      this.showSuccess('隐私模式写入 Cookie', `已写入：${cookieValue}`)

    } catch (error) {
      this.showError('隐私模式写入 Cookie', error as BusinessError<void>)
    }
  }

  private async readIncognitoCookie(): Promise<string> {
    try {
      let value = webview.WebCookieManager.fetchCookieSync(TEST_URL, true)
      return value || '(空)'
    } catch (error) {
      this.showError('隐私模式读取 Cookie', error as BusinessError<void>)
      return '读取失败'
    }
  }

  private clearNormalCookies() {
    try {
      webview.WebCookieManager.clearAllCookiesSync(false)
      this.showSuccess('clearAllCookiesSync(false)', '已清除正常非隐私模式下的持久化 Cookie。')
    } catch (error) {
      this.showError('clearAllCookiesSync(false)', error as BusinessError<void>)
    }
  }

  private clearIncognitoCookies() {
    try {
      webview.WebCookieManager.clearAllCookiesSync(true)
      this.showSuccess('clearAllCookiesSync(true)', '已清除隐私模式下 Webview 的所有内存 Cookie。')
    } catch (error) {
      this.showError('clearAllCookiesSync(true)', error as BusinessError<void>)
    }
  }

  private readNormalBefore() {
    this.normalCookieBefore = this.readNormalCookie()
  }

  private readNormalAfter() {
    this.normalCookieAfter = this.readNormalCookie()
  }

  private async readIncognitoBefore() {
    const value = await this.readIncognitoCookie()
    this.incognitoCookieBefore = value
  }

  private async readIncognitoAfter() {
    const value = await this.readIncognitoCookie()
    this.incognitoCookieAfter = value
  }

  build() {
    Column() {
      // 返回按钮
      Row() {
        Row({ space: 2 }) {
          Text('←')
            .fontSize(16)
            .fontColor('#333333')
          Text('返回')
            .fontSize(12)
            .fontColor('#333333')
        }
      }
      .id('clear_cookies_back')
      .width('100%')
      .height(28)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        this.backToHome()
      })

      // 标题
      Column({ space: 2 }) {
        Text('ClearAllCookiesSync 验证')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
        Text('分别验证正常模式(false)和隐私模式(true)的清除效果')
          .fontSize(10)
          .fontColor('#888888')
          .width('100%')
      }
      .padding({ left: 12, right: 12 })

      // 执行结果反馈
      Column({ space: 4 }) {
        Row() {
          Text('● 执行结果')
            .fontSize(10)
            .fontColor(this.feedbackColor)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')

        Text(this.feedbackTitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.feedbackColor)
          .id('clear_cookies_feedback')

        Text(this.feedbackText)
          .fontSize(11)
          .fontColor('#666666')
          .lineHeight(16)
      }
      .width('100%')
      .padding(8)
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: this.feedbackColor })
      .padding({ left: 12, right: 12 })

      // 操作区域（无滚动）
      Column({ space: 4 }) {
        // 正常模式测试卡片
        Column({ space: 4 }) {
          Text('正常模式（非隐私模式）')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('1. 写入Cookie').testButton()
              .id('clear_cookies_normal_write')
              .onClick(() => {
                this.writeNormalCookie()
              })

            Button('2. 读取(清除前)').testButton()
              .id('clear_cookies_normal_read_before')
              .onClick(() => {
                this.readNormalBefore()
              })

            Button('3. clearAllCookiesSync(false)').testButton()
              .id('clear_cookies_normal_clear')
              .onClick(() => {
                this.clearNormalCookies()
              })

            Button('4. 读取(清除后)').testButton()
              .id('clear_cookies_normal_read_after')
              .onClick(() => {
                this.readNormalAfter()
              })
          }
          .width('100%')

          Row({ space: 8 }) {
            Text(`前:${this.normalCookieBefore}`)
              .fontSize(9)
              .fontColor('#333333')
              .layoutWeight(1)
            Text(`后:${this.normalCookieAfter}`)
              .id('normalCookieAfter')
              .fontSize(9)
              .fontColor('#333333')
              .layoutWeight(1)
          }
          .width('100%')

          Web({ src: TEST_URL, controller: this.normalController })
            .width('100%')
            .height(60)
            .borderRadius(6)
            .backgroundColor('#F7F9FC')
        }
        .testCard()

        // 隐私模式测试卡片
        Column({ space: 4 }) {
          Text('隐私模式（incognitoMode）')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .width('100%')

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('1. 写入Cookie').testButton()
              .id('clear_cookies_incognito_write')
              .onClick(() => {
                this.writeIncognitoCookie()
              })

            Button('2. 读取(清除前)').testButton()
              .id('clear_cookies_incognito_read_before')
              .onClick(() => {
                this.readIncognitoBefore()
              })

            Button('3. clearAllCookiesSync(true)').testButton()
              .id('clear_cookies_incognito_clear')
              .onClick(() => {
                this.clearIncognitoCookies()
              })

            Button('4. 读取(清除后)').testButton()
              .id('clear_cookies_incognito_read_after')
              .onClick(() => {
                this.readIncognitoAfter()
              })
          }
          .width('100%')

          Row({ space: 8 }) {
            Text(`前:${this.incognitoCookieBefore}`)
              .fontSize(9)
              .fontColor('#333333')
              .layoutWeight(1)
            Text(`后:${this.incognitoCookieAfter}`)
              .id('incognitoCookieAfter')
              .fontSize(9)
              .fontColor('#333333')
              .layoutWeight(1)
          }
          .width('100%')

          Web({ src: TEST_URL, controller: this.incognitoController, incognitoMode: true })
            .width('100%')
            .height(60)
            .borderRadius(6)
            .backgroundColor('#F7F9FC')
        }
        .testCard()
      }
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}
