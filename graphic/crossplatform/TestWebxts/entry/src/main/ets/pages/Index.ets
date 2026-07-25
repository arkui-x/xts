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
import { promptAction } from '@kit.ArkUI'
import deviceInfo from '@ohos.deviceInfo'


@Extend(Button)
function cookieNavButton() {
  .width('100%')
  .height(32)
  .borderRadius(8)
  .fontSize(11)
  .fontWeight(FontWeight.Medium)
  .fontColor('#FFFFFF')
  .backgroundColor('#0A59F7')
}

@Extend(Button)
function attrNavButton() {
  .width('100%')
  .height(32)
  .borderRadius(8)
  .fontSize(11)
  .fontWeight(FontWeight.Medium)
  .fontColor('#FFFFFF')
  .backgroundColor('#0F9D58')
}

@Extend(Button)
function ctrlNavButton() {
  .width('100%')
  .height(32)
  .borderRadius(8)
  .fontSize(11)
  .fontWeight(FontWeight.Medium)
  .fontColor('#FFFFFF')
  .backgroundColor('#F4B400')
}

@Extend(Button)
function jsNavButton() {
  .width('100%')
  .height(32)
  .borderRadius(8)
  .fontSize(11)
  .fontWeight(FontWeight.Medium)
  .fontColor('#FFFFFF')
  .backgroundColor('#7C4DFF')
}


@Extend(Column)
function groupCard() {
  .width('100%')
  .padding(8)
  .borderRadius(10)
  .backgroundColor(Color.White)
  .border({ width: 1, color: '#E5EAF0' })
}

@Extend(Text)
function groupTitle() {
  .fontSize(12)
  .fontWeight(FontWeight.Bold)
  .width('100%')
  .margin({ bottom: 2 })
}

@Entry
@Component
struct Index {
  private jumpToWebCookieManager() {
    try {
      router.pushUrl({ url: 'pages/WebCookieManager1' })
    } catch (error) {
      console.error('跳转到 WebCookieManager 失败')
    }
  }

  private jumpToWebCookieManager2() {
    try {
      router.pushUrl({ url: 'pages/WebCookieManager2' })
    } catch (error) {
      console.error('跳转到 WebCookieManager2 失败')
    }
  }

  private jumpToWebAttribute() {
    try {
      router.pushUrl({ url: 'pages/WebAttribute' })
    } catch (error) {
      console.error('跳转到 WebAttribute 失败')
    }
  }

  private jumpToWebviewController() {
    try {
      router.pushUrl({ url: 'pages/WebviewController' })
    } catch (error) {
      console.error('跳转到 WebviewController 失败')
    }
  }

  private jumpToJavaScriptOnDocumentStart() {
    let platform = deviceInfo.osFullName.split(' ')[0];
    if (platform === 'Android') {
      promptAction.showToast({ message: 'Android 平台不支持 JavaScriptOnDocumentStart 接口', duration: 2000 });
      return;
    }
    try {
      router.pushUrl({ url: 'pages/runJavaScriptOnDocumentStart' })
    } catch (error) {
      console.error('跳转到 JavaScriptOnDocumentStart 失败')
    }
  }

  private jumpToThirdPartyCookieNetworkTest() {
    try {
      router.pushUrl({ url: 'pages/PutAcceptThirdPartyCookieEnabled' })
    } catch (error) {
      console.error('跳转到 putAcceptThirdPartyCookieEnabled 失败')
    }
  }

  private jumpToPutAcceptCookieEnabledTest() {
    try {
      router.pushUrl({ url: 'pages/PutAcceptCookieEnabled' })
    } catch (error) {
      console.error('跳转到 PutAcceptCookieEnabledTest 失败')
    }
  }

  private jumpToClearAllCookiesTest() {
    try {
      router.pushUrl({ url: 'pages/ClearAllCookiesTest' })
    } catch (error) {
      console.error('跳转到 ClearAllCookiesTest 失败')
    }
  }

  private jumpToClearSessionCookieTest() {
    try {
      router.pushUrl({ url: 'pages/ClearSessionCookieTest' })
    } catch (error) {
      console.error('跳转到 ClearSessionCookieTest 失败')
    }
  }

  private jumpToSslErrorInvalid() {
    try {
      router.pushUrl({ url: 'pages/SslErrorInvalid' })
    } catch (error) {
      console.error('跳转到 SslErrorInvalid 失败')
    }
  }


  private jumpToJavaScriptOnDocumentEnd() {
    try {
      router.pushUrl({ url: 'pages/runJavaScriptOnDocumentEnd' })
    } catch (error) {
      console.error('跳转到 JavaScriptOnDocumentEnd 失败')
    }
  }


  build() {
    Column({ space: 6 }) {
      // ===== 页面头部 =====
      Column({ space: 4 }) {
        Text('Web XTS')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('WebKit 能力测试集合，点击下方卡片进入各功能测试页。')
          .fontSize(11)
          .fontColor('#888888')
          .lineHeight(16)
      }
      .width('100%')

      // ===== Cookie 管理测试组 =====
      Column({ space: 6 }) {
        Row({ space: 4 }) {
          Text('🍪').fontSize(13)
          Text('Cookie 管理').groupTitle().fontColor('#0A59F7')
        }

        Button('WebCookieManager ① (configCookie/incognito)')
          .cookieNavButton()
          .id('index_nav_web_cookie_manager')
          .onClick(() => {
            this.jumpToWebCookieManager()
          })

        Button('WebCookieManager ② (保存/读取/开关)')
          .cookieNavButton()
          .id('index_nav_web_cookie_manager2')
          .onClick(() => {
            this.jumpToWebCookieManager2()
          })

        Button('Test putAcceptThirdPartyCookieEnabled')
          .cookieNavButton()
          .id('index_nav_third_party_cookie_network_test')
          .onClick(() => {
            this.jumpToThirdPartyCookieNetworkTest()
          })

        Button('Test putAcceptCookieEnabled')
          .cookieNavButton()
          .id('index_nav_put_accept_cookie_enabled_test')
          .onClick(() => {
            this.jumpToPutAcceptCookieEnabledTest()
          })

        Button('Test ClearAllCookies')
          .cookieNavButton()
          .id('index_nav_clear_all_cookies_test')
          .onClick(() => {
            this.jumpToClearAllCookiesTest()
          })

        Button('Test ClearSessionCookie')
          .cookieNavButton()
          .id('index_nav_clear_session_cookie_test')
          .onClick(() => {
            this.jumpToClearSessionCookieTest()
          })
      }
      .groupCard()

      // ===== 属性配置测试组 =====
      Column({ space: 6 }) {
        Row({ space: 4 }) {
          Text('⚙️').fontSize(13)
          Text('属性配置').groupTitle().fontColor('#0F9D58')
        }

        Button('WebAttribute')
          .attrNavButton()
          .id('index_nav_web_attribute')
          .onClick(() => {
            this.jumpToWebAttribute()
          })

        Button('Test SslErrorInvalid')
          .attrNavButton()
          .id('index_nav_ssl_error_invalid')
          .onClick(() => {
            this.jumpToSslErrorInvalid()
          })
      }
      .groupCard()

      // ===== 控制器测试组 =====
      Column({ space: 6 }) {
        Row({ space: 4 }) {
          Text('🎮').fontSize(13)
          Text('控制器').groupTitle().fontColor('#F4B400')
        }

        Button('WebviewController')
          .ctrlNavButton()
          .id('index_nav_webview_controller')
          .onClick(() => {
            this.jumpToWebviewController()
          })
      }
      .groupCard()

      // ===== JavaScript 测试组 =====
      Column({ space: 6 }) {
        Row({ space: 4 }) {
          Text('📜').fontSize(13)
          Text('JavaScript').groupTitle().fontColor('#7C4DFF')
        }

        Button('Test runJavaScriptOnDocumentStart')
          .jsNavButton()
          .id('index_nav_javascript_on_document_start')
          .onClick(() => {
            this.jumpToJavaScriptOnDocumentStart()
          })
        Button('Test runJavaScriptOnDocumentEnd')
          .jsNavButton()
          .id('index_nav_javascript_on_document_End')
          .onClick(() => {
            this.jumpToJavaScriptOnDocumentEnd()
          })
      }
      .groupCard()


    }
    .width('100%')
    .padding({
      left: 16,
      right: 16,
      top: 16,
      bottom: 8
    })
    .backgroundColor('#F7F9FC')
  }
}
