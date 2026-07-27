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
const SESSION_COOKIE_NAME: string = 'session_test_cookie'
const PERSISTENT_COOKIE_NAME: string = 'persistent_test_cookie'

@Extend(Button)
function testButton() {
  .width('100%')
  .height(42)
  .borderRadius(8)
  .fontSize(12)
  .backgroundColor('#0A59F7')
}

@Extend(Column)
function testCard() {
  .width('100%')
  .padding(16)
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .border({ width: 1, color: '#E5EAF0' })
}

@Entry
@Component
struct ClearSessionCookieTest {
  private controller: webview.WebviewController = new webview.WebviewController()

  @State private feedbackTitle: string = '等待操作'
  @State private feedbackText: string = '点击下方按钮执行 clearSessionCookieSync 验证测试。'
  @State private feedbackColor: string = '#0A59F7'

  @State private cookieBefore: string = '-'
  @State private cookieAfter: string = '-'

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

  private writeSessionCookie() {
    try {
      let value = `${SESSION_COOKIE_NAME}=v${Date.now()}; Path=/; SameSite=Lax`
      webview.WebCookieManager.configCookieSync(TEST_URL, value)
      this.showSuccess('写入会话 Cookie', `已写入：${value}`)
    } catch (error) {
      this.showError('写入会话 Cookie', error as BusinessError<void>)
    }
  }

  private writePersistentCookie() {
    try {
      let expires = new Date(Date.now() + 86400000).toUTCString()
      let value = `${PERSISTENT_COOKIE_NAME}=v${Date.now()}; Path=/; Expires=${expires}; SameSite=Lax`
      webview.WebCookieManager.configCookieSync(TEST_URL, value)
      this.showSuccess('写入持久化 Cookie', `已写入：${value}`)
    } catch (error) {
      this.showError('写入持久化 Cookie', error as BusinessError<void>)
    }
  }

  private readCookie(): string {
    try {
      let value = webview.WebCookieManager.fetchCookieSync(TEST_URL)
      return value || '(空)'
    } catch (error) {
      this.showError('读取 Cookie', error as BusinessError<void>)
      return '读取失败'
    }
  }

  private readBefore() {
    this.cookieBefore = this.readCookie()
  }

  private readAfter() {
    this.cookieAfter = this.readCookie()
  }

  private clearSessionCookies() {
    try {
      webview.WebCookieManager.clearSessionCookieSync()
      this.showSuccess('clearSessionCookieSync', '已清除所有会话 Cookie。')
    } catch (error) {
      this.showError('clearSessionCookieSync', error as BusinessError<void>)
    }
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // 返回按钮
        Row() {
          Row({ space: 2 }) {
            Text('🔙')
              .fontSize(22)
              .fontColor('#333333')
            Text('返回')
              .fontSize(15)
              .fontColor('#333333')
          }
        }
        .id('session_cookie_back')
        .width('100%')
        .height(40)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.backToHome()
        })

        // 标题
        Column({ space: 4 }) {
          Text('ClearSessionCookieSync 验证')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')
            .width('100%')
          Text('验证只清除会话 Cookie，保留持久化 Cookie')
            .fontSize(13)
            .fontColor('#888888')
            .width('100%')
        }

        // 执行结果反馈
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
            .id('session_cookie_feedback')

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

        // 测试卡片
        Column({ space: 12 }) {
          Text('测试步骤').fontSize(16).fontWeight(FontWeight.Medium).width('100%')

          Button('1. 写入会话 Cookie').testButton()
            .id('session_cookie_write_session')
            .onClick(() => {
              this.writeSessionCookie()
            })

          Button('写入持久化 Cookie').testButton()
            .id('session_cookie_write_persistent')
            .onClick(() => {
              this.writePersistentCookie()
            })

          Button('2. 读取 Cookie（清除前）').testButton()
            .id('session_cookie_read_before')
            .onClick(() => {
              this.readBefore()
            })

          Button('3. clearSessionCookieSync()').testButton()
            .id('session_cookie_clear')
            .onClick(() => {
              this.clearSessionCookies()
            })

          Button('4. 读取 Cookie（清除后）').testButton()
            .id('session_cookie_read_after')
            .onClick(() => {
              this.readAfter()
            })

          Text(`清除前：${this.cookieBefore}`)
            .fontSize(13)
            .fontColor('#333333')
            .width('100%')
          Text(`清除后：${this.cookieAfter}`)
            .id('session_cookie_after')
            .fontSize(13)
            .fontColor('#333333')
            .width('100%')

          Web({ src: TEST_URL, controller: this.controller })
            .width('100%')
            .height(120)
            .borderRadius(8)
            .backgroundColor('#F7F9FC')
        }
        .testCard()
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Auto)
    .backgroundColor('#F7F9FC')
  }
}
