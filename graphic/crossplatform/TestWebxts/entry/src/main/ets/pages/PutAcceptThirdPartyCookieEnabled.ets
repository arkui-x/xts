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

// ==================== 测试配置 ====================
// A 站：当前页面加载的主站点（第一方）。
const FIRST_PARTY_PAGE_URL: string = 'https://www.example.com/arkui-third-party-cookie.html';
// B 站：嵌套在 A 站中的跨域 iframe（第三方），用于探测第三方 Cookie 是否可用。
const THIRD_PARTY_IFRAME_URL: string =
  'https://cleantelligent.github.io/3rdPartyCookieChecker/3rdPartyCookieChecker.html';
// B 站 iframe 返回的成功标识（可读写 Cookie）。
const RESULT_ENABLED: string = 'CT-3rdPartyCookiesEnabled';
// B 站 iframe 返回的阻断标识（无法读写 Cookie）。
const RESULT_DISABLED: string = 'CT-3rdPartyCookiesDisabled';
// Web 侧通过 console 回传结果时的固定前缀，ArkTS 据此过滤有效日志。
const RESULT_PREFIX: string = 'ARKUI_THIRD_PARTY_COOKIE_RESULT:';
// iframe 加载超时时间（ms），超过后自动标记为 timeout。
const PROBE_TIMEOUT_MS: number = 6000;

// A 站探测页面的 HTML：负责嵌入 B 站 iframe，并通过 postMessage 获取 Cookie 探测结果。
const THIRD_PARTY_PROBE_HTML: string = `<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style>
    body { margin: 0; padding: 12px; background: #f7f8fa; color: #171a1f;
      font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", Arial, sans-serif; }
    .shell { border: 1px solid #d8dee8; background: #fff; border-radius: 8px; padding: 12px; }
    h1 { font-size: 17px; margin: 0 0 8px; }
    .status { white-space: pre-wrap; word-break: break-word; font-size: 12px;
      line-height: 1.45; color: #3f4a5a; }
    iframe { width: 100%; min-height: 96px; border: 1px solid #d8dee8; background: #fff; }
  </style>
</head>
<body>
  <div class="shell">
    <h1>Third-party Cookie iframe Probe</h1>
    <div id="status" class="status">ready</div>
    <iframe id="probeFrame" title="third-party-cookie-probe"></iframe>
  </div>
  <script>
    (function () {
      var state = { phase: 'ready', result: '', iframeUrl: '', detail: 'waiting' };
      function render() {
        document.getElementById('status').textContent = JSON.stringify(state, null, 2);
        return JSON.stringify(state);
      }
      function update(next) {
        Object.keys(next).forEach(function (key) { state[key] = next[key]; });
        console.info('${RESULT_PREFIX}' + JSON.stringify(state));
        return render();
      }
      window.addEventListener('message', function (event) {
        if (event.data === '${RESULT_ENABLED}' || event.data === '${RESULT_DISABLED}') {
          update({ phase: 'finished', result: String(event.data), detail: 'message from ' + event.origin });
        }
      });
      window.getThirdPartyCookieProbeState = function () { return render(); };
      window.runThirdPartyCookieProbe = function (iframeUrl) {
        var frame = document.getElementById('probeFrame');
        state = { phase: 'running', result: '', iframeUrl: String(iframeUrl || ''), detail: 'loading third-party iframe' };
        render();
        frame.src = 'about:blank';
        setTimeout(function () { frame.src = state.iframeUrl + '?t=' + Date.now(); }, 50);
        setTimeout(function () {
          if (state.phase === 'running') {
            update({ phase: 'timeout', result: '', detail: 'no postMessage received within ${PROBE_TIMEOUT_MS} ms' });
          }
        }, ${PROBE_TIMEOUT_MS});
        return render();
      };
      render();
    })();
  </script>
</body>
</html>`;

const LOG_TAG: string = '[kzh][ThirdPartyCookieNetworkTest] ';

// ==================== UI 样式扩展 ====================
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
struct ThirdPartyCookieNetworkTest {
  private controller: webview.WebviewController = new webview.WebviewController();
  private uiContext: UIContext = this.getUIContext();
  private pendingProbe: boolean = false;
  private pendingAccept: boolean = true;
  @State acceptStatus: string = '-';
  @State probeResult: string = '-';
  @State errorInfo: string = '-';
  @State logs: Array<string> = ['ready'];

  aboutToAppear(): void {
    this.logInfo('aboutToAppear start');
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
      this.appendLog('setWebDebuggingAccess success');
    } catch (err) {
      this.errorInfo = 'setWebDebuggingAccess failed: ' + this.getErrorMessage(err as BusinessError);
      this.logInfo(this.errorInfo);
    }
  }

  private logInfo(message: string): void {
    console.info(LOG_TAG + message);
  }

  private updateState(task: () => void): void {
    try {
      this.uiContext.runScopedTask(task);
    } catch (err) {
      this.logInfo('runScopedTask failed, fallback: ' + this.getErrorMessage(err as BusinessError));
      task();
    }
  }

  private appendLog(message: string): void {
    this.logInfo(message);
    this.logs = [new Date().toLocaleTimeString() + ' ' + message].concat(this.logs).slice(0, 12);
  }

  private getErrorMessage(err: Object | null | undefined): string {
    if (!err) {
      return 'unknown';
    }
    let businessError = err as BusinessError;
    return businessError.message || JSON.stringify(err);
  }

  private loadFirstPartyPage(autoProbe: boolean, accept: boolean): void {
    try {
      this.pendingProbe = autoProbe;
      this.pendingAccept = accept;
      this.probeResult = autoProbe ? '等待 Web onPageEnd 后加载 B 站 iframe...' : '-';
      this.errorInfo = '-';
      this.controller.loadData(
        THIRD_PARTY_PROBE_HTML, 'text/html', 'UTF-8',
        FIRST_PARTY_PAGE_URL, FIRST_PARTY_PAGE_URL
      );
      this.appendLog('loadData first-party page: ' + FIRST_PARTY_PAGE_URL);
    } catch (err) {
      this.pendingProbe = false;
      this.errorInfo = 'loadData failed: ' + this.getErrorMessage(err as BusinessError);
      this.appendLog(this.errorInfo);
    }
  }

  private setAcceptAndProbe(accept: boolean): void {
    try {
      this.logInfo('call putAcceptThirdPartyCookieEnabled(' + accept + ')');
      webview.WebCookieManager.putAcceptThirdPartyCookieEnabled(accept);
      this.acceptStatus = 'putAcceptThirdPartyCookieEnabled(' + accept + ') success';
      this.appendLog(this.acceptStatus);
      this.loadFirstPartyPage(true, accept);
    } catch (err) {
      this.pendingProbe = false;
      this.acceptStatus =
        'putAcceptThirdPartyCookieEnabled(' + accept + ') failed: ' + this.getErrorMessage(err as BusinessError);
      this.appendLog(this.acceptStatus);
    }
  }

  private getProbeJudgement(result: string, accept: boolean): string {
    if (result.indexOf(RESULT_ENABLED) >= 0) {
      return accept
        ? '✅ 符合预期：打开开关后，第三方 iframe 可以正常读写 Cookie。'
        : '❌ 不符合预期：关闭开关后，第三方 iframe 仍然可以读写 Cookie。';
    }
    if (result.indexOf(RESULT_DISABLED) >= 0) {
      return accept
        ? '⚠️ 受限结果：已打开 ArkUI 开关，但系统 WebKit 仍可能阻断第三方 Cookie（iOS 常见）。'
        : '✅ 符合预期：关闭开关后，第三方 iframe 无法读写 Cookie。';
    }
    return '⏳ 未完成：未收到 B 站 iframe 的 postMessage 结果，请检查网络或 iframe 加载。';
  }

  private async runThirdPartyProbe(accept: boolean): Promise<void> {
    try {
      this.appendLog('runThirdPartyCookieProbe iframe=' + THIRD_PARTY_IFRAME_URL);
      this.updateState(() => {
        this.probeResult = 'running, accept=' + accept + '\niframe=' + THIRD_PARTY_IFRAME_URL;
      });
      let script = 'window.runThirdPartyCookieProbe ? window.runThirdPartyCookieProbe(' +
        JSON.stringify(THIRD_PARTY_IFRAME_URL) +
        ') : JSON.stringify({phase:"error", detail:"runThirdPartyCookieProbe not ready"})';
      await this.controller.runJavaScript(script);
      await new Promise<void>((resolve) => setTimeout(() => resolve(), PROBE_TIMEOUT_MS + 800));
      let result = await this.controller.runJavaScript(
        'window.getThirdPartyCookieProbeState ? window.getThirdPartyCookieProbeState() : "not ready"'
      );
      this.appendLog('runThirdPartyProbe result=' + result);
      let judgement = this.getProbeJudgement(result, accept);
      this.updateState(() => {
        this.probeResult = judgement + '\n\n【开关状态】accept=' + accept +
          '\n【B 站 iframe】' + THIRD_PARTY_IFRAME_URL +
          '\n【原始返回】' + result;
      });
      this.appendLog('probe finished, accept=' + accept + ', judgement=' + judgement);
    } catch (err) {
      this.updateState(() => {
        this.errorInfo = 'runJavaScript probe failed: ' + this.getErrorMessage(err as BusinessError);
      });
      this.appendLog(this.errorInfo);
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
      .id('thirdPartyCookieBack')
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
        Text('第三方 Cookie 跨域测试')
          .fontSize(16)
          .fontWeight(700)
          .width('100%')
          .fontColor('#1A1A1A')
        Text('验证 putAcceptThirdPartyCookieEnabled 对跨域 iframe Cookie 的管控效果')
          .fontSize(10)
          .fontColor('#888888')
          .width('100%')
      }
      .padding({ left: 12, right: 12 })

      Column({ space: 4 }) {
        // ========== 结果展示区 ==========
        Column({ space: 4 }) {
          Text('📊 测试结果')
            .fontSize(11).fontWeight(FontWeight.Medium).width('100%').fontColor('#1A1A1A')

          Text('开关调用结果：' + this.acceptStatus)
            .id('thirdPartyAcceptStatus').fontSize(10).width('100%').fontColor('#555555')

          Text('探测结论与详情：\n' + this.probeResult)
            .id('thirdPartyProbeResult')
            .fontSize(10)
            .padding(8)
            .backgroundColor('#F7F8FA')
            .borderRadius(6)
            .width('100%')
            .lineHeight(14)

          if (this.errorInfo !== '-') {
            Text('错误信息：' + this.errorInfo)
              .id('thirdPartyErrorInfo').fontSize(10).width('100%').fontColor('#E84026')
          }
        }
        .card()


        // ========== 核心测试场景 ==========
        Column({ space: 4 }) {
          Text('🔴 场景一：关闭第三方 Cookie 开关')
            .fontSize(11).fontWeight(FontWeight.Medium).width('100%').fontColor('#1A1A1A')

          Button('🔴 关闭开关后探测')
            .id('thirdPartyAcceptFalseProbe')
            .width('100%')
            .height(36)
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#E84026')
            .borderRadius(8)
            .onClick(() => {
              this.setAcceptAndProbe(false);
            })

          Text('🟢 场景二：打开第三方 Cookie 开关')
            .fontSize(11).fontWeight(FontWeight.Medium).width('100%').fontColor('#1A1A1A')

          Button('🟢 打开开关后探测')
            .id('thirdPartyAcceptTrueProbe')
            .width('100%')
            .height(36)
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#2AAE67')
            .borderRadius(8)
            .onClick(() => {
              this.setAcceptAndProbe(true);
            })
        }
        .card()


        // ========== Web 容器 ==========
        Column({ space: 4 }) {
          Text('🌐 Web 容器（A 站页面 + B 站 iframe）')
            .fontSize(11).fontWeight(FontWeight.Medium).width('100%').fontColor('#1A1A1A')

          Web({ src: 'about:blank', controller: this.controller })
            .onPageBegin((event) => {
              this.logInfo('Web onPageBegin url=' + event.url);
            })
            .onPageEnd((event) => {
              this.logInfo('Web onPageEnd url=' + event.url);
              if (this.pendingProbe) {
                let accept = this.pendingAccept;
                this.pendingProbe = false;
                this.runThirdPartyProbe(accept);
              }
            })
            .onConsole((event) => {
              let message = event.message.getMessage();
              if (message.indexOf(RESULT_PREFIX) >= 0) {
                this.appendLog(message);
              }
              return false;
            })
            .onErrorReceive((event) => {
              if (event) {
                this.errorInfo = 'ErrorCode: ' + event.error.getErrorCode() +
                  ', ErrorInfo: ' + event.error.getErrorInfo();
                this.logInfo('Web onErrorReceive ' + this.errorInfo);
              }
            })
            .width('100%')
            .height(100)
            .borderRadius(6)
            .backgroundColor('#F7F8FA')
        }
        .card()

        // ========== 执行日志 ==========
        Column({ space: 4 }) {
          Text('📝 执行日志（最近 12 条）')
            .fontSize(11).fontWeight(FontWeight.Medium).width('100%').fontColor('#1A1A1A')

          Text(this.logs.join('\n'))
            .id('thirdPartyLogs')
            .fontSize(9)
            .width('100%')
            .fontColor('#666666')
            .lineHeight(14)
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
