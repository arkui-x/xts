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

type SaveCookieAsyncInvalidCallbackFn = (callback?: object | null) => void

@Extend(Button)
function cookieButton() {
  .width('48%')
  .height(28)
  .borderRadius(6)
  .fontSize(8)
  .backgroundColor('#0A59F7')
}

@Extend(Text)
function sectionTitle() {
  .fontSize(11)
  .fontWeight(FontWeight.Medium)
  .fontColor('#1A1A1A')
  .width('100%')
  .margin({ top: 2 })
}

@Extend(Column)
function sectionCard() {
  .width('100%')
  .padding(6)
  .backgroundColor('#FFFFFF')
  .borderRadius(8)
  .border({ width: 1, color: '#E5EAF0' })
}

@Entry
@Component
struct WebCookieManager2 {
  private controller: webview.WebviewController = new webview.WebviewController()
  private incognitoController: webview.WebviewController = new webview.WebviewController()
  private readonly missingCookieTestUrl: string = '空字符串 URL'
  @State private feedbackTitle: string = '等待操作'
  @State private feedbackText: string = '点击下方按钮后，这里会在屏幕中显示执行成功或失败的结果。'
  @State private feedbackColor: string = '#0A59F7'

  private showPending(action: string) {
    this.feedbackTitle = `${action} 执行中`
    this.feedbackText = '请求已经发出，请稍候查看结果。'
    this.feedbackColor = '#FF8A00'
  }

  private showSuccess(action: string, detail: string) {
    this.feedbackTitle = `${action} 成功`
    this.feedbackText = detail
    this.feedbackColor = '#2AAE67'
  }

  private showExpectedError(action: string, detail: string) {
    this.feedbackTitle = `${action} 命中预期异常`
    this.feedbackText = detail
    this.feedbackColor = '#FF8A00'
  }

  private showError(action: string, error: BusinessError<void>) {
    this.feedbackTitle = `${action} 失败`
    this.feedbackText = `ErrorCode: ${error.code}, Message: ${error.message}`
    this.feedbackColor = '#E84026'
  }

  private handleExpectedError(action: string, error: BusinessError<void>, expectedCode: number,
    detail: string): boolean {
    if (error.code === expectedCode) {
      this.showExpectedError(action, `${detail} ErrorCode: ${error.code}`)
      return true
    }
    return false
  }

  build() {
    Column() {
      // ── 返回按钮 ──
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
      .id('web_cookie_manager2_back')
      .width('100%')
      .height(28)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        try {
          router.back()
        } catch (error) {
          this.showError('返回', error as BusinessError<void>)
        }
      })

      // ── 标题区域 ──
      Column({ space: 2 }) {
        Text('WebCookieManager ②')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
        Text('Cookie 保存/读取/开关/预览')
          .fontSize(10)
          .fontColor('#888888')
          .width('100%')
      }
      .padding({ left: 12, right: 12 })

      // ── 执行结果反馈卡片 ──
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

        Text(this.feedbackText)
          .fontSize(11)
          .fontColor('#666666')
          .lineHeight(16)
          .id('web_cookie_manager2_feedback')

      }
      .width('100%')
      .padding(10)
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: this.feedbackColor })
      .padding({ left: 12, right: 12 })

      // ── 操作按钮区域（双列网格，无滚动） ──
      Column({ space: 4 }) {
        // ══════════ Cookie 保存测试 ══════════
        Column({ space: 4 }) {
          Text('Cookie 保存测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {

            Button('saveCookieAsync callback').cookieButton()
              .id('web_cookie_manager_save_cookie_async_callback')
              .onClick(() => {
                this.showPending('saveCookieAsync callback')
                try {
                  webview.WebCookieManager.saveCookieAsync((error) => {
                    if (error) {
                      this.showError('saveCookieAsync callback', error as BusinessError<void>)
                      return
                    }
                    this.showSuccess('saveCookieAsync callback', 'success')
                  })
                } catch (error) {
                  this.showError('saveCookieAsync callback', error as BusinessError<void>)
                }
              })
            Button('saveCookieAsync callback 401 null').cookieButton()
              .id('web_cookie_manager_save_cookie_async_callback_invalid_null')
              .onClick(() => {
                this.showPending('saveCookieAsync callback（预期异常 401）')
                try {
                  let invalidSaveCookieAsyncFn =
                    webview.WebCookieManager.saveCookieAsync as SaveCookieAsyncInvalidCallbackFn
                  invalidSaveCookieAsyncFn(null)
                  this.showExpectedError('401 场景',
                    '未命中预期异常：非法 callback 参数仍然被接受，请确认当前设备 API 行为。')
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('401 场景', businessError, 401,
                    '已成功捕获预期异常：saveCookieAsync callback 场景传入了非法参数。')) {
                    return
                  }
                  this.showError('401 场景', businessError)
                }
              })
            Button('saveCookieAsync callback 401 undefined').cookieButton()
              .id('web_cookie_manager_save_cookie_async_callback_invalid_undefined')
              .onClick(() => {
                this.showPending('saveCookieAsync callback（预期异常 401 undefined）')
                try {
                  let invalidSaveCookieAsyncFn =
                    webview.WebCookieManager.saveCookieAsync as SaveCookieAsyncInvalidCallbackFn
                  invalidSaveCookieAsyncFn(undefined)
                  this.showExpectedError('401 场景',
                    '未命中预期异常：非法 callback 参数仍然被接受，请确认当前设备 API 行为。')
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('401 场景', businessError, 401,
                    '已成功捕获预期异常：saveCookieAsync callback 场景传入了非法参数。')) {
                    return
                  }
                  this.showError('401 场景', businessError)
                }
              })
            Button('saveCookieAsync Promise').cookieButton()
              .id('web_cookie_manager_save_cookie_async_promise')
              .onClick(() => {
                this.showPending('saveCookieAsync Promise')
                try {
                  webview.WebCookieManager.saveCookieAsync()
                    .then(() => {
                      this.showSuccess('saveCookieAsync Promise', 'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('saveCookieAsync Promise', error)
                    })
                } catch (error) {
                  this.showError('saveCookieAsync Promise', error as BusinessError<void>)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Cookie 读取与参数校验测试 ══════════
        Column({ space: 4 }) {
          Text('Cookie 读取与参数校验测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('fetchCookieSync').cookieButton()
              .id('web_cookie_manager_fetch_cookie_sync')
              .onClick(() => {
                try {
                  let value = webview.WebCookieManager.fetchCookieSync('https://www.example.com')
                  this.showSuccess('fetchCookieSync', `success`)
                } catch (error) {
                  this.showError('fetchCookieSync', error as BusinessError<void>)
                }
              })
            Button('清理Cookie会话').cookieButton()
              .id('web_cookie_manager_clear_session_cookie_callback')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearSessionCookieSync();
                  this.showSuccess('clearSessionCookie callback', '会话 Cookie 已清除。')
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError<void>).code},  Message: ${(error as BusinessError<void>).message}`);
                }
              })
            Button('fetchCookieSync 预期异常 17100002').cookieButton()
              .id('web_cookie_manager_fetch_cookie_sync_expect_17100002')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  let value = webview.WebCookieManager.fetchCookieSync('')
                  this.showExpectedError('17100002 场景',
                    `未命中预期异常：fetchCookieSync 返回了 ${value || '空字符串'}，请确认当前设备 API 行为。`)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (businessError.code === 17100002) {
                    this.showExpectedError('17100002 场景',
                      `已成功捕获预期异常：指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。ErrorCode: ${businessError.code}`)
                    return
                  }
                  this.showError('17100002 场景', businessError)
                }
              })
            Button('fetchCookieSync 预期异常 401 null').cookieButton()
              .id('web_cookie_manager_fetch_cookie_sync_invalid_null')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  let value = webview.WebCookieManager.fetchCookieSync(null)
                  this.showExpectedError('null 场景',
                    `未命中预期异常：fetchCookieSync 返回了 ${value || '空字符串'}，请确认当前设备 API 行为。`)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (businessError.code === 401) {
                    this.showExpectedError('null 场景',
                      `已成功捕获预期异常：指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。ErrorCode: ${businessError.code}`)
                    return
                  }
                  this.showError('null 场景', businessError)
                }
              })
            Button('fetchCookieSync 预期异常 401 undefined').cookieButton()
              .id('web_cookie_manager_fetch_cookie_sync_invalid_undefined')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  let value = webview.WebCookieManager.fetchCookieSync(undefined)
                  this.showExpectedError('undefined 场景',
                    `未命中预期异常：fetchCookieSync 返回了 ${value || '空字符串'}，请确认当前设备 API 行为。`)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (businessError.code === 401) {
                    this.showExpectedError('undefined 场景',
                      `已成功捕获预期异常：指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。ErrorCode: ${businessError.code}`)
                    return
                  }
                  this.showError('undefined 场景', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Cookie 开关与清理测试 ══════════
        Column({ space: 4 }) {
          Text('Cookie 开关与清理测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('putAcceptThirdPartyCookieEnabled null').cookieButton()
              .id('web_cookie_manager_set_accept_third_party_cookie_null')
              .onClick(() => {
                try {
                  webview.WebCookieManager.putAcceptThirdPartyCookieEnabled(null)
                  this.showSuccess('第三方 Cookie 开关', '已打开接受第三方 Cookie。')
                } catch (error) {
                  this.showError('第三方 Cookie 开关', error as BusinessError<void>)
                }
              })
            Button('putAcceptThirdPartyCookieEnabled undefined').cookieButton()
              .id('web_cookie_manager_set_accept_third_party_cookie_undefined')
              .onClick(() => {
                try {
                  webview.WebCookieManager.putAcceptThirdPartyCookieEnabled(undefined)
                  this.showSuccess('第三方 Cookie 开关', '已打开接受第三方 Cookie。')
                } catch (error) {
                  this.showError('第三方 Cookie 开关', error as BusinessError<void>)
                }
              })
            Button('putAcceptCookieEnabled null').cookieButton()
              .id('web_cookie_manager_set_accept_cookie_null')
              .onClick(() => {
                try {
                  webview.WebCookieManager.putAcceptCookieEnabled(null)
                  this.showSuccess('Cookie 总开关', '已关闭接受 Cookie。')
                } catch (error) {
                  this.showError('Cookie 总开关', error as BusinessError<void>)
                }
              })
            Button('putAcceptCookieEnabled undefined').cookieButton()
              .id('web_cookie_manager_set_accept_cookie_undefined')
              .onClick(() => {
                try {
                  webview.WebCookieManager.putAcceptCookieEnabled(undefined)
                  this.showSuccess('Cookie 总开关', '已关闭接受 Cookie。')
                } catch (error) {
                  this.showError('Cookie 总开关', error as BusinessError<void>)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Web 预览区域 ══════════
        Column({ space: 4 }) {
          Text('Web 预览区域').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Text('左侧为正常模式，右侧为隐私模式')
              .fontSize(9)
              .fontColor('#666666')
              .width('100%')
              .lineHeight(14)
            Row({ space: 6 }) {
              Web({ src: 'https://www.example.com', controller: this.controller })
                .layoutWeight(1)
                .height(80)
                .borderRadius(6)
              Web({
                src: 'https://www.example.com',
                controller: this.incognitoController,
                incognitoMode: true
              })
                .layoutWeight(1)
                .height(80)
                .borderRadius(6)
            }
            .width('100%')
          }
          .width('100%')
        }
        .sectionCard()
      }
      .width('100%')
      .constraintSize({ maxWidth: 600 })
      .padding({ left: 12, right: 12, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}
