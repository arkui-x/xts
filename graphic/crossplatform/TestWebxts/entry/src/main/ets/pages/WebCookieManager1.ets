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

type ConfigCookieInvalidParamCallbackFn = (url?: string | null, value?: string | null,
  callback?: ((error: BusinessError<void>) => void) | null) => void

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
struct WebCookieManager {
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
      .id('web_cookie_manager_back')
      .width('100%')
      .height(28)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        try {
          router.back()
        } catch (error) {
          this.showError('返回主页面', error as BusinessError<void>)
        }
      })

      // ── 标题区域 ──
      Column({ space: 2 }) {
        Text('WebCookieManager')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
        Text('Cookie 配置、读取与清理测试')
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
          .id('web_cookie_manager_feedback')

      }
      .width('100%')
      .padding(10)
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: this.feedbackColor })
      .padding({ left: 12, right: 12 })

      // ── 操作按钮区域（双列网格，无滚动） ──
      Column({ space: 4 }) {
        // ══════════ 同步 Cookie 配置测试 ══════════
        Column({ space: 4 }) {
          Text('同步 Cookie 配置测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookieSync').cookieButton()
              .id('web_cookie_manager_config_cookie_sync')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b')
                  this.showSuccess('configCookieSync', 'success')
                } catch (error) {
                  this.showError('configCookieSync', error as BusinessError<void>)
                }
              })
            Button('configCookieSync 预期异常 17100005').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_expect_17100005')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', '', false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100005 场景', businessError, 17100005,
                    '已成功捕获预期异常：传入的 Cookie value 不符合 RFC 6265 格式。')) {
                    return
                  }
                  this.showError('17100005 场景', businessError)
                }
              })
            Button('configCookieSync 预期异常 17100002').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_expect_17100002')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  webview.WebCookieManager.configCookieSync('', 'a=b')
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100002 场景', businessError, 17100002,
                    `已成功捕获预期异常：指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。`)) {
                    return
                  }
                  this.showError('17100002 场景', businessError)
                }
              })
            Button('configCookieSync 预期异常 null').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_invalid_null')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync(null, null, false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('null 场景', businessError)
                }
              })
            Button('configCookieSync 预期异常 undefined').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_invalid_undefined')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  webview.WebCookieManager.configCookieSync(undefined, 'a=b')
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('undefined 场景', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        Column({ space: 12 }) {
          Text('configCookieSync 附加参数 incognito 参数组合测试').sectionTitle()

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookieSync incognito=false').cookieButton()
              .id('web_cookie_manager_incognito_false')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', false)
                  this.showSuccess('incognito=false', '正常模式 设置incognito=false，Cookie 设置成功。')
                } catch (error) {
                  this.showError('incognito=false', error as BusinessError<void>)
                }
              })

            Button('configCookieSync incognito=true').cookieButton()
              .id('web_cookie_manager_incognito_true')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', true)
                  this.showSuccess('incognito=true', '隐私模式 设置incognito=true，Cookie 设置成功。')
                } catch (error) {
                  this.showError('incognito=true', error as BusinessError<void>)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Sync incognito/includeHttpOnly ══════════
        Column({ space: 4 }) {
          Text('Sync incognito/includeHttpOnly').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookieSync incognito=false, includeHttpOnly=false').cookieButton()
              .id('web_cookie_manager_incognito_false_include_http_false')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', false, false)
                  this.showSuccess('incognito=false, includeHttpOnly=false', 'success')
                } catch (error) {
                  this.showError('incognito=false, includeHttpOnly=false', error as BusinessError<void>)
                }
              })
            Button('configCookieSync incognito=true, includeHttpOnly=false').cookieButton()
              .id('web_cookie_manager_incognito_true_include_http_false')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', true, false)
                  this.showSuccess('incognito=true, includeHttpOnly=false', 'success')
                } catch (error) {
                  this.showError('incognito=true, includeHttpOnly=false', error as BusinessError<void>)
                }
              })
            Button('configCookieSync incognito=false, includeHttpOnly=true').cookieButton()
              .id('web_cookie_manager_incognito_false_include_http_true')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', false, true)
                  this.showSuccess('incognito=false, includeHttpOnly=true', 'success')
                } catch (error) {
                  this.showError('incognito=false, includeHttpOnly=true', error as BusinessError<void>)
                }
              })
            Button('configCookieSync incognito=true, includeHttpOnly=true').cookieButton()
              .id('web_cookie_manager_incognito_true_include_http_true')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', 'a=b', true, true)
                  this.showSuccess('incognito=true, includeHttpOnly=true', 'success')
                } catch (error) {
                  this.showError('incognito=true, includeHttpOnly=true', error as BusinessError<void>)
                }
              })
            Button('configCookieSync 附加参数 预期异常 17100005').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_with_options_expect_17100005')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync('https://www.example.com', '', false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100005 场景（附加参数）', businessError, 17100005,
                    '已成功捕获预期异常：附加参数场景下传入的 Cookie value 不符合 RFC 6265 格式。')) {
                    return
                  }
                  this.showError('17100005 场景（附加参数）', businessError)
                }
              })
            Button('configCookieSync 附加参数 预期异常 17100002').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_with_options_expect_17100002')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  webview.WebCookieManager.configCookieSync('', 'a=b', false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100002 场景（附加参数）', businessError, 17100002,
                    `已成功捕获预期异常：附加参数场景下指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。`)) {
                    return
                  }
                  this.showError('17100002 场景（附加参数）', businessError)
                }
              })
            Button('configCookieSync 附加参数 预期异常 null').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_with_options_invalid_null')
              .onClick(() => {
                try {
                  webview.WebCookieManager.configCookieSync(null, null, false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('null 场景（附加参数）', businessError)
                }
              })
            Button('configCookieSync 附加参数 预期异常 undefined').cookieButton()
              .id('web_cookie_manager_config_cookie_sync_with_options_invalid_undefined')
              .onClick(() => {
                try {
                  webview.WebCookieManager.clearAllCookiesSync()
                  webview.WebCookieManager.configCookieSync(undefined, 'a=b', false, false)
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('undefined 场景（附加参数）', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Callback Cookie 配置测试 ══════════
        Column({ space: 4 }) {
          Text('Callback Cookie 配置测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookie callback').cookieButton()
              .id('web_cookie_manager_config_cookie_callback')
              .onClick(() => {
                this.showPending('configCookie callback')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=d', (error) => {
                    if (error) {
                      this.showError('configCookie callback', error as BusinessError<void>)
                      return
                    }
                    this.showSuccess('configCookie callback', 'success')
                  })
                } catch (error) {
                  this.showError('configCookie callback', error as BusinessError<void>)
                }
              })

            Button('configCookie callback NULL').cookieButton()
              .id('web_cookie_manager_config_cookie_callback_invalid_null')
              .onClick(() => {
                this.showPending('configCookie callback')
                try {
                  let invalidConfigCookieCallbackFn =
                    webview.WebCookieManager.configCookie as ConfigCookieInvalidParamCallbackFn
                  invalidConfigCookieCallbackFn(null, 'a=b', (error) => {
                    if (error) {
                      this.showError('null 场景', error as BusinessError<void>)
                      return
                    }
                  })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('null 场景', businessError)
                }
              })
            Button('configCookie callback undefined').cookieButton()
              .id('web_cookie_manager_config_cookie_callback_invalid_undefined')
              .onClick(() => {
                this.showPending('configCookie callback')
                try {
                  let invalidConfigCookieCallbackFn =
                    webview.WebCookieManager.configCookie as ConfigCookieInvalidParamCallbackFn
                  invalidConfigCookieCallbackFn(undefined, '', (error) => {
                    if (error) {
                      this.showError('undefined 场景', error as BusinessError<void>)
                      return
                    }
                  })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('undefined 场景', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Promise Cookie 配置测试 ══════════
        Column({ space: 4 }) {
          Text('Promise Cookie 配置测试').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookie Promise').cookieButton()
              .id('web_cookie_manager_config_cookie_promise')
              .onClick(() => {
                this.showPending('configCookie Promise')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=c')
                    .then(() => {
                      this.showSuccess('configCookie Promise', 'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('configCookie Promise', error)
                    })
                } catch (error) {
                  this.showError('configCookie Promise', error as BusinessError<void>)
                }
              })

            Button('configCookie Promise null').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_invalid_null')
              .onClick(() => {
                this.showPending('configCookie Promise')
                try {
                  webview.WebCookieManager.configCookie(null, null)
                    .then(() => {
                      this.showExpectedError('null 场景',
                        '未命中预期异常：Promise 场景没有返回 URL 非法错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('null 场景', error)
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('null 场景', businessError)
                }
              })

            Button('configCookie Promise undefined').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_invalid_undefined')
              .onClick(() => {
                this.showPending('configCookie Promise')
                try {
                  webview.WebCookieManager.configCookie(undefined, undefined)
                    .then(() => {
                      this.showExpectedError('undefined 场景',
                        '未命中预期异常：Promise 场景没有返回非法 Cookie value 错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('undefined 场景', error)
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('undefined 场景', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

        // ══════════ Promise incognito/includeHttpOnly ══════════
        Column({ space: 4 }) {
          Text('Promise incognito/includeHttpOnly').sectionTitle()
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            Button('configCookie Promise incognito=false, includeHttpOnly=false').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_with_options')
              .onClick(() => {
                this.showPending('configCookie Promise incognito=false, includeHttpOnly=false')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=b', false, false)
                    .then(() => {
                      this.showSuccess('configCookie Promise incognito=false, includeHttpOnly=false',
                        'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('configCookie Promise incognito=false, includeHttpOnly=false', error)
                    })
                } catch (error) {
                  this.showError('configCookie Promise incognito=false, includeHttpOnly=false',
                    error as BusinessError<void>)
                }
              })
            Button('configCookie Promise incognito=true, includeHttpOnly=false').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_incognito_true_include_http_false')
              .onClick(() => {
                this.showPending('configCookie Promise incognito=true, includeHttpOnly=false')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=b', true, false)
                    .then(() => {
                      this.showSuccess('configCookie Promise incognito=true, includeHttpOnly=false',
                        'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('configCookie Promise incognito=true, includeHttpOnly=false', error)
                    })
                } catch (error) {
                  this.showError('configCookie Promise incognito=true, includeHttpOnly=false',
                    error as BusinessError<void>)
                }
              })
            Button('configCookie Promise incognito=false, includeHttpOnly=true').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_incognito_false_include_http_true')
              .onClick(() => {
                this.showPending('configCookie Promise incognito=false, includeHttpOnly=true')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=b', false, true)
                    .then(() => {
                      this.showSuccess('configCookie Promise incognito=false, includeHttpOnly=true',
                        'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('configCookie Promise incognito=false, includeHttpOnly=true', error)
                    })
                } catch (error) {
                  this.showError('configCookie Promise incognito=false, includeHttpOnly=true',
                    error as BusinessError<void>)
                }
              })
            Button('configCookie Promise incognito=true, includeHttpOnly=true').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_incognito_true_include_http_true')
              .onClick(() => {
                this.showPending('configCookie Promise incognito=true, includeHttpOnly=true')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', 'a=b', true, true)
                    .then(() => {
                      this.showSuccess('configCookie Promise incognito=true, includeHttpOnly=true',
                        'success')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('configCookie Promise incognito=true, includeHttpOnly=true', error)
                    })
                } catch (error) {
                  this.showError('configCookie Promise incognito=true, includeHttpOnly=true',
                    error as BusinessError<void>)
                }
              })
            Button('configCookie Promise 附加参数 预期异常 17100002').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_with_options_expect_17100002')
              .onClick(() => {
                this.showPending('configCookie Promise 附加参数')
                try {
                  webview.WebCookieManager.configCookie('', 'a=b', false, false)
                    .then(() => {
                      this.showExpectedError('17100002 场景（附加参数）',
                        '未命中预期异常：Promise 附加参数场景没有返回 URL 非法错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      if (!this.handleExpectedError('17100002 场景（附加参数）', error, 17100002,
                        `已成功捕获预期异常：附加参数场景下指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。`)) {
                        this.showError('17100002 场景（附加参数）', error)
                      }
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100002 场景（附加参数）', businessError, 17100002,
                    `已成功捕获预期异常：附加参数场景下指定 URL ${this.missingCookieTestUrl} 没有有效 Cookie。`)) {
                    return
                  }
                  this.showError('17100002 场景（附加参数）', businessError)
                }
              })
            Button('configCookie Promise 附加参数 预期异常 17100005').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_with_options_expect_17100005')
              .onClick(() => {
                this.showPending('configCookie Promise 附加参数')
                try {
                  webview.WebCookieManager.configCookie('https://www.example.com', '', false, false)
                    .then(() => {
                      this.showExpectedError('17100005 场景（附加参数）',
                        '未命中预期异常：Promise 附加参数场景没有返回 Cookie value 非法错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      if (!this.handleExpectedError('17100005 场景（附加参数）', error, 17100005,
                        '已成功捕获预期异常：附加参数场景下传入的 Cookie value 不符合 RFC 6265 格式。')) {
                        this.showError('17100005 场景（附加参数）', error)
                      }
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  if (this.handleExpectedError('17100005 场景（附加参数）', businessError, 17100005,
                    '已成功捕获预期异常：附加参数场景下传入的 Cookie value 不符合 RFC 6265 格式。')) {
                    return
                  }
                  this.showError('17100005 场景（附加参数）', businessError)
                }
              })
            Button('configCookie Promise 附加参数 预期异常 null').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_with_options_invalid_null')
              .onClick(() => {
                this.showPending('configCookie Promise 附加参数')
                try {
                  webview.WebCookieManager.configCookie(null, 'a=b', false, false)
                    .then(() => {
                      this.showExpectedError('null 场景（附加参数）',
                        '未命中预期异常：Promise 附加参数场景没有返回 URL 非法错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('null 场景（附加参数）', error)
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('null 场景（附加参数）', businessError)
                }
              })
            Button('configCookie Promise 附加参数 预期异常 undefined').cookieButton()
              .id('web_cookie_manager_config_cookie_promise_with_options_invalid_undefined')
              .onClick(() => {
                this.showPending('configCookie Promise 附加参数')
                try {
                  webview.WebCookieManager.configCookie(undefined, 'a=b', false, false)
                    .then(() => {
                      this.showExpectedError('undefined 场景（附加参数）',
                        '未命中预期异常：Promise 附加参数场景没有返回 URL 非法错误，请确认当前设备 API 行为。')
                    })
                    .catch((error: BusinessError<void>) => {
                      this.showError('undefined 场景（附加参数）', error)
                    })
                } catch (error) {
                  let businessError: BusinessError<void> = error as BusinessError<void>
                  this.showError('undefined 场景（附加参数）', businessError)
                }
              })
          }
          .width('100%')
        }
        .sectionCard()

      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}
