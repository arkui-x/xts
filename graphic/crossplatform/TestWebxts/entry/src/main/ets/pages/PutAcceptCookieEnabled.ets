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

import { BusinessError } from '@kit.BasicServicesKit';
import { webview } from '@kit.ArkWeb';
import router from '@ohos.router';

const NETWORK_COOKIE_ORIGIN: string = 'https://postman-echo.com';
const NETWORK_SET_COOKIE_PREFIX: string = 'https://postman-echo.com/cookies/set?';
const PROBE_TYPE_NETWORK: string = 'network';
const LOG_TAG: string = '[kzh][PutAcceptCookieEnabledTest] ';

// ==================== UI 样式扩展 ====================
@Extend(Text)
function sectionTitle() {
  .fontSize(11)
  .fontWeight(700)
  .fontColor('#1A1A1A')
  .width('100%')
}

@Extend(Text)
function sectionDesc() {
  .fontSize(9)
  .fontColor('#666666')
  .lineHeight(14)
  .width('100%')
}

@Extend(Button)
function primaryButton() {
  .width('100%')
  .height(32)
  .borderRadius(8)
  .fontSize(10)
  .fontColor('#FFFFFF')
  .backgroundColor('#0A59F7')
}

@Extend(Column)
function card() {
  .width('100%')
  .padding(6)
  .backgroundColor('#FFFFFF')
  .borderRadius(8)
  .border({ width: 1, color: '#E5EAF0' })
}

@Entry
@Component
struct PutAcceptCookieEnabledTest {
  private controller: webview.WebviewController = new webview.WebviewController();
  private uiContext: UIContext = this.getUIContext();
  private pendingProbe: boolean = false;
  private pendingAccept: boolean = true;
  private pendingProbeType: string = '';
  private pendingCookieName: string = '';
  private pendingCookieValue: string = '';
  private pendingCookieUrl: string = '';
  @State pageStatus: string = 'ready';
  @State acceptStatus: string = '-';
  @State probeResult: string = '点击按钮执行 putAcceptCookieEnabled 测试';
  @State errorInfo: string = '-';
  @State logs: Array<string> = [];

  aboutToAppear(): void {
    this.logInfo('aboutToAppear');
    try {
      this.logInfo('call setWebDebuggingAccess(true)');
      webview.WebviewController.setWebDebuggingAccess(true);
      this.logInfo('setWebDebuggingAccess(true) success');
    } catch (err) {
      this.errorInfo = 'setWebDebuggingAccess failed: ' + this.getErrorMessage(err as BusinessError);
      this.logInfo(this.errorInfo);
    }
  }

  private logInfo(message: string): void {
    console.info(LOG_TAG + message);
  }

  private appendLog(message: string): void {
    this.logInfo(message);
    this.logs = [message].concat(this.logs).slice(0, 8);
  }

  private updateState(task: () => void): void {
    try {
      this.uiContext.runScopedTask(task);
    } catch (err) {
      this.logInfo('runScopedTask failed, fallback direct task: ' + this.getErrorMessage(err as BusinessError));
      task();
    }
  }

  private getErrorMessage(err: Object | null | undefined): string {
    if (!err) {
      return 'unknown';
    }
    let businessError = err as BusinessError;
    if (businessError.message) {
      return businessError.message;
    }
    return JSON.stringify(err);
  }

  private clearDefaultCookies(): void {
    try {
      this.appendLog('call clearAllCookiesSync(false)');
      webview.WebCookieManager.clearAllCookiesSync(false);
      this.appendLog('clearAllCookiesSync(false) success');
    } catch (err) {
      this.errorInfo = 'clearAllCookiesSync(false) failed: ' + this.getErrorMessage(err as BusinessError);
      this.appendLog(this.errorInfo);
    }
  }

  private resetProbeState(accept: boolean, probeType: string): void {
    this.clearDefaultCookies();
    this.pendingProbe = false;
    this.pendingAccept = accept;
    this.pendingProbeType = probeType;
    this.pendingCookieName = '';
    this.pendingCookieValue = '';
    this.pendingCookieUrl = '';
    this.acceptStatus = '-';
    this.probeResult = 'waiting putAcceptCookieEnabled(' + accept + ')';
    this.errorInfo = '-';
    this.logInfo('state reset, pendingProbe=' + this.pendingProbe + ', pendingAccept=' + this.pendingAccept +
      ', pendingProbeType=' + this.pendingProbeType);
  }

  private setAcceptAndLoadNetworkCookiePage(accept: boolean): void {
    this.logInfo('setAcceptAndLoadNetworkCookiePage start, accept=' + accept);
    this.resetProbeState(accept, PROBE_TYPE_NETWORK);
    try {
      this.appendLog('call putAcceptCookieEnabled(' + accept + ')');
      webview.WebCookieManager.putAcceptCookieEnabled(accept);
      this.acceptStatus = 'putAcceptCookieEnabled(' + accept + ') success';
      this.pendingCookieName = accept ? 'accept_cookie_network_true' : 'accept_cookie_network_false';
      this.pendingCookieValue = 'v' + Date.now();
      this.pendingCookieUrl = NETWORK_COOKIE_ORIGIN;
      let networkUrl = NETWORK_SET_COOKIE_PREFIX + encodeURIComponent(this.pendingCookieName) +
        '=' + encodeURIComponent(this.pendingCookieValue);
      this.pendingProbe = true;
      this.pageStatus = 'loading network Set-Cookie redirect: ' + networkUrl;
      this.logInfo('putAcceptCookieEnabled(' + accept + ') success, pendingProbe=' + this.pendingProbe +
        ', cookieName=' + this.pendingCookieName + ', cookieValue=' + this.pendingCookieValue);
      this.logInfo('call loadUrl network Set-Cookie redirect url=' + networkUrl);
      this.controller.loadUrl(networkUrl);
      this.appendLog('loadUrl network Set-Cookie redirect after putAcceptCookieEnabled(' + accept + ')');
    } catch (err) {
      this.pendingProbe = false;
      this.acceptStatus = 'putAcceptCookieEnabled(' + accept + ') failed: ' +
        this.getErrorMessage(err as BusinessError);
      this.probeResult = '当前平台未完成 Cookie 总开关能力调用，无法继续网络 Set-Cookie 探测。';
      this.appendLog(this.acceptStatus);
    }
  }

  private getNetworkJudgement(accept: boolean, visibleInServer: boolean, visibleInManager: boolean): string {
    if (accept) {
      return visibleInServer && visibleInManager ?
        '主结论：符合预期。打开 Cookie 总开关后，网络响应中的 Set-Cookie 被接收，并在后续请求中成功带回。' :
        '主结论：不符合预期。打开 Cookie 总开关后，服务端回显或 CookieManager 未观察到探测 Cookie。';
    }
    return !visibleInServer && !visibleInManager ?
      '主结论：符合预期。关闭 Cookie 总开关后，网络响应中的 Set-Cookie 未被接收，也未在后续请求中带回。' :
      '主结论：不符合预期。关闭 Cookie 总开关后，服务端回显或 CookieManager 仍观察到探测 Cookie。';
  }

  private async runNetworkCookieProbe(accept: boolean): Promise<void> {
    try {
      this.logInfo('runNetworkCookieProbe start, accept=' + accept + ', cookieName=' + this.pendingCookieName +
        ', cookieValue=' + this.pendingCookieValue + ', cookieUrl=' + this.pendingCookieUrl);
      let bodyScript = 'document.body ? document.body.innerText : ""';
      this.logInfo('runJavaScript read network /cookies body script=' + bodyScript);
      let bodyResult = await this.controller.runJavaScript(bodyScript);
      this.logInfo('runJavaScript network body result=' + bodyResult);
      let managerCookie = webview.WebCookieManager.fetchCookieSync(this.pendingCookieUrl, false);
      let expectedCookie = this.pendingCookieName + '=' + this.pendingCookieValue;
      let visibleInServer = bodyResult.indexOf(this.pendingCookieName) >= 0 &&
        bodyResult.indexOf(this.pendingCookieValue) >= 0;
      let visibleInManager = managerCookie.indexOf(expectedCookie) >= 0;
      let judgement = this.getNetworkJudgement(accept, visibleInServer, visibleInManager);
      this.logInfo('network probe judgement accept=' + accept + ', visibleInServer=' + visibleInServer +
        ', visibleInManager=' + visibleInManager + ', judgement=' + judgement);
      this.updateState(() => {
        this.probeResult = '【主验证】putAcceptCookieEnabled(' + accept + ') 网络 Set-Cookie 探测完成\n' +
          '【加载地址】' + this.pageStatus + '\n' +
          '【期望 Cookie】' + expectedCookie + '\n' +
          '【服务端回显可见】' + visibleInServer + '\n' +
          '【fetchCookieSync 可见】' + visibleInManager + '\n' +
          '【服务端回显返回】' + bodyResult + '\n' +
          '【fetchCookieSync 返回】' + (managerCookie || '(empty)') + '\n' +
          '【主结论】' + judgement;
      });
      this.appendLog('network probe finished, accept=' + accept + ', serverVisible=' + visibleInServer +
        ', managerVisible=' + visibleInManager);
    } catch (err) {
      this.updateState(() => {
        this.errorInfo = 'run network cookie probe failed: ' + this.getErrorMessage(err as BusinessError);
      });
      this.appendLog(this.errorInfo);
    } finally {
      if (!accept) {
        this.restoreAcceptCookieEnabled();
      }
    }
  }

  private restoreAcceptCookieEnabled(): void {
    try {
      this.appendLog('restore putAcceptCookieEnabled(true)');
      webview.WebCookieManager.putAcceptCookieEnabled(true);
      this.acceptStatus = this.acceptStatus + '\nrestore putAcceptCookieEnabled(true) success';
      this.logInfo('restore putAcceptCookieEnabled(true) success');
    } catch (err) {
      let message = 'restore putAcceptCookieEnabled(true) failed: ' +
        this.getErrorMessage(err as BusinessError);
      this.acceptStatus = this.acceptStatus + '\n' + message;
      this.appendLog(message);
    }
  }

  build() {
    Column() {
      // ========== 返回按钮 ==========
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
      .id('acceptCookieBack')
      .width('100%')
      .height(28)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        try {
          router.back()
        } catch (error) {
          this.appendLog('返回失败: ' + this.getErrorMessage(error as BusinessError))
        }
      })

      // ========== 标题区 ==========
      Column({ space: 2 }) {
        Text('putAcceptCookieEnabled 测试')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .width('100%')
        Text('验证 putAcceptCookieEnabled 对网络 Set-Cookie 的管控效果')
          .fontSize(10)
          .fontColor('#888888')
          .width('100%')
      }
      .padding({ left: 12, right: 12 })

      // ========== 内容区（无滚动） ==========
      Column({ space: 4 }) {
        // ========== 结果总览 ==========
        Column({ space: 4 }) {
          Text('📊 当前结果总览').sectionTitle()
          Text(this.probeResult)
            .id('acceptCookieProbeResult')
            .fontSize(10)
            .lineHeight(14)
            .fontColor('#333333')
            .width('100%')
          Text('页面加载结果：' + this.pageStatus)
            .id('acceptCookiePageStatus')
            .fontSize(10)
            .fontColor('#555555')
            .width('100%')
          Text('开关调用结果：' + this.acceptStatus)
            .id('acceptCookieStatus')
            .fontSize(10)
            .fontColor('#555555')
            .width('100%')
          if (this.errorInfo !== '-') {
            Text('错误信息：' + this.errorInfo)
              .id('acceptCookieErrorInfo')
              .fontSize(10)
              .fontColor('#E84026')
              .width('100%')
          }
        }
        .card()

        // ========== 主验证：网络 Set-Cookie ==========
        Column({ space: 4 }) {
          Text('🔴 主验证：网络 Set-Cookie').sectionTitle()

          Button('putAcceptCookieEnabled(true)')
            .id('acceptCookieTrueProbe')
            .primaryButton()
            .onClick(() => {
              this.logInfo('button acceptCookieTrueProbe clicked');
              this.setAcceptAndLoadNetworkCookiePage(true);
            })

          Button('putAcceptCookieEnabled(false)')
            .id('acceptCookieFalseProbe')
            .primaryButton()
            .onClick(() => {
              this.logInfo('button acceptCookieFalseProbe clicked');
              this.setAcceptAndLoadNetworkCookiePage(false);
            })
        }
        .card()

        // ========== Web 预览区域 ==========
        Column({ space: 4 }) {
          Text('🌐 Web 预览区域').sectionTitle()
          Text('用于承载真实网络页面与 loadData 文档。')
            .sectionDesc()

          Web({
            src: 'about:blank',
            controller: this.controller
          })
            .onPageBegin((event) => {
              this.pageStatus = 'onPageBegin: ' + event.url;
              this.logInfo('Web onPageBegin url=' + event.url);
            })
            .onPageEnd((event) => {
              this.pageStatus = 'onPageEnd: ' + event.url;
              this.logInfo('Web onPageEnd url=' + event.url + ', pendingProbe=' + this.pendingProbe +
                ', pendingAccept=' + this.pendingAccept + ', pendingProbeType=' + this.pendingProbeType);
              if (this.pendingProbe) {
                let accept = this.pendingAccept;
                this.pendingProbe = false;
                this.logInfo('Web onPageEnd trigger probe, accept=' + accept);
                this.runNetworkCookieProbe(accept);
              }
            })
        }
        .card()

      }
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}
