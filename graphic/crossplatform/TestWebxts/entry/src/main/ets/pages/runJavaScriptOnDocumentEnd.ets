import router from '@ohos.router'
import { webview } from '@kit.ArkWeb'

@Entry
@Component
struct JavaScriptOnDocumentEndPage {
  private readonly webUrl: string = 'https://www.baidu.com/'
  // 注入绿色方块脚本 — 通用匹配命中标识，显示"注册成功"（使用readyState兼容runJavaScriptOnDocumentEnd时机）
  private readonly injectRedBlock: string =
    '(function() {' +
      'function mark() {' +
      '  var block = document.createElement(\'div\');' +
      '  block.innerText = \'注册成功\';' +
      '  block.style.cssText = \'position:fixed;left:20px;top:20px;width:140px;height:60px;' +
      'background:green;color:#fff;z-index:999999;border-radius:8px;' +
      'display:flex;align-items:center;justify-content:center;' +
      'font-size:18px;font-weight:bold;box-shadow:0 4px 12px rgba(0,0,0,.2);\';' +
      '  document.body.appendChild(block);' +
      '}' +
      'if (document.readyState === \'loading\') {' +
      '  document.addEventListener(\'DOMContentLoaded\', mark);' +
      '} else {' +
      '  mark();' +
      '}' +
      '})();'
  // 自定义协议拦截返回的页面HTML
  private readonly customProtocolPageHtml: string =
    '<!DOCTYPE html><html><head><meta charset="UTF-8">' +
      '<meta name="viewport" content="width=device-width, initial-scale=1.0">' +
      '<title>scriptRules 规则5</title></head>' +
      '<body style="font-family:sans-serif;padding:24px;">' +
      '<h1>scriptRules 规则5</h1>' +
      '<p>当前页面通过 testweb:// 自定义协议加载。</p>' +
      '<p>预期左上角出现蓝色注入块。</p>' +
      '</body></html>'
  // 自定义协议命中脚本 — 显示蓝色文本标识
  private readonly injectCustomProtocol: string =
    '(function() {' +
      'function mark() {' +
      '  var block = document.createElement(\'div\');' +
      '  block.innerText = \'规则5命中\\ntestweb://\';' +
      '  block.style.cssText = \'position:fixed;left:16px;top:16px;width:220px;min-height:88px;' +
      'background:#0a59f7;color:#fff;z-index:999999;border-radius:8px;padding:12px;' +
      'font-size:14px;line-height:22px;box-shadow:0 4px 12px rgba(0,0,0,.2);\';' +
      '  document.body.appendChild(block);' +
      '}' +
      'if (document.readyState === \'loading\') {' +
      '  document.addEventListener(\'DOMContentLoaded\', mark);' +
      '} else {' +
      '  mark();' +
      '}' +
      '})();'
  // ========== scriptRules 测试用数组 ==========
  // 规则1: 通配符 * 命中所有
  private readonly scriptsWildcard: Array<ScriptItem> = [
    { script: this.injectRedBlock, scriptRules: ['*'] }
  ]
  // 规则3: 模糊匹配正确写法 *.baidu.com，命中
  private readonly scriptsValidFuzzy: Array<ScriptItem> = [
    { script: this.injectRedBlock, scriptRules: ['https://*.baidu.com'] }
  ]
  // 规则2: 精确匹配完整URL，命中
  private readonly scriptsExactUrl: Array<ScriptItem> = [
    { script: this.injectRedBlock, scriptRules: ['https://www.baidu.com'] }
  ]
  // 规则6: 其中一条无效，整组无效(但有一条有效则命中)
  private readonly scriptsOneMatch: Array<ScriptItem> = [
    { script: this.injectRedBlock, scriptRules: ['https://*baidu.com', '*'] }
  ]
  // 规则7: secondLevelDomain 二级域名精确匹配 + rule URL正则匹配（urlRegexRules）
  private readonly scriptsDomainRegex: Array<ScriptItem> = [
    {
      script: this.injectRedBlock,
      scriptRules: [],
      urlRegexRules: [
        { secondLevelDomain: 'baidu.com', rule: 'https://www\\.baidu\\.com/.*' }
      ]
    }
  ]
  // 规则8: 验证 scriptRules:[] 空数组 + urlRegexRules 独立生效 + 正则锚点差异
  private readonly injectUrlRegexTrigger: string =
    '(function() {' +
      'function mark() {' +
      '  try { console.log(\'scriptDOMEnd: urlRegexRules ok\'); } catch(e) {}' +
      '  try { if (typeof SyncObj !== \'undefined\') SyncObj.NdkJsBridge(); } catch(e) {}' +
      '  try { if (typeof ASyncObj !== \'undefined\') ASyncObj.NdkAsyncJsBridge(); } catch(e) {}' +
      '  try { if (typeof SyncObjEx !== \'undefined\') SyncObjEx.NdkJsBridgeEx(); } catch(e) {}' +
      '  try { if (typeof ASyncObjEx !== \'undefined\') ASyncObjEx.NdkAsyncJsBridgeEx(); } catch(e) {}' +
      '  var block = document.createElement(\'div\');' +
      '  block.innerText = \'urlRegexRules独立触发\\nscriptRules为空数组\';' +
      '  block.style.cssText = \'position:fixed;left:16px;top:90px;width:220px;min-height:60px;' +
      'background:#ff6600;color:#fff;z-index:999998;border-radius:8px;padding:8px;' +
      'font-size:12px;line-height:18px;box-shadow:0 4px 12px rgba(0,0,0,.2);\';' +
      '  document.body.appendChild(block);' +
      '}' +
      'if (document.readyState === \'loading\') {' +
      '  document.addEventListener(\'DOMContentLoaded\', mark);' +
      '} else { mark(); }' +
      '})();'
  private readonly scriptsUrlRegexLoose: Array<ScriptItem> = [
    {
      script: this.injectUrlRegexTrigger,
      scriptRules: [],
      urlRegexRules: [{ secondLevelDomain: 'baidu.com', rule: '.*baidu.*' }]
    }
  ]
  private readonly scriptsUrlRegexHttpsAnchor: Array<ScriptItem> = [
    {
      script: this.injectUrlRegexTrigger,
      scriptRules: [],
      urlRegexRules: [{ secondLevelDomain: 'baidu.com', rule: '^https:\\/\\/' }]
    }
  ]
  // 规则8 正例3: 严格锚点 ^https://www.* → 预期命中
  private readonly scriptsUrlRegexWwwAnchor: Array<ScriptItem> = [
    {
      script: this.injectUrlRegexTrigger,
      scriptRules: [],
      urlRegexRules: [{ secondLevelDomain: 'baidu.com', rule: '^https:\\/\\/www.*' }]
    }
  ]
  // 规则5: 自定义协议（非http/https），必须以://结尾，不支持精确匹配和模糊匹配
  private readonly customProtocolUrl: string = 'testweb://index.html'
  private readonly scriptsCustomProtocol: Array<ScriptItem> = [
    { script: this.injectCustomProtocol, scriptRules: ['testweb://'] }
  ]
  // Web页面加载计数
  @State webLoadedCount: number = 0

  aboutToAppear(): void {
    console.info('JavaScriptOnDocumentEndPage 进入页面，等待Web加载完成')
  }

  // 每块 Web 的高度
  private readonly webHeight: number = 380

  // 普通 Web 块构建器（无请求拦截）
  @Builder
  webBlock(label: string, url: string, ruleDesc: string, scripts: Array<ScriptItem>) {
    Column({ space: 8 }) {
      Row({ space: 6 }) {
        Text(label)
          .fontSize(14)
          .fontWeight(600)
          .fontColor('#0A59F7')
          .backgroundColor('#E8F0FE')
          .padding({
            left: 8,
            right: 8,
            top: 4,
            bottom: 4
          })
          .borderRadius(6)
        Text(url)
          .fontSize(11)
          .fontColor('#888')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
      }.width('100%')

      Text(ruleDesc)
        .fontSize(11).fontColor('#666').width('100%').maxLines(2)
      Web({ src: url, controller: new webview.WebviewController() })
        .javaScriptAccess(true)
        .runJavaScriptOnDocumentEnd(scripts)
        .onPageEnd(() => {
          this.webLoadedCount++
        })
        .width('100%')
        .height(this.webHeight)
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .border({ width: 1, color: '#E5E7EB' })
  }

  // 构建自定义协议拦截响应
  private buildCustomProtocolResponse(): WebResourceResponse {
    const response = new WebResourceResponse()
    response.setResponseData(this.customProtocolPageHtml)
    response.setResponseEncoding('UTF-8')
    response.setResponseMimeType('text/html')
    response.setResponseCode(200)
    response.setReasonMessage('OK')
    return response
  }

  // 带请求拦截的 Web 块构建器（用于自定义协议测试）
  @Builder
  webBlockWithIntercept(label: string, url: string, ruleDesc: string, scripts: Array<ScriptItem>) {
    Column({ space: 8 }) {
      Row({ space: 6 }) {
        Text(label)
          .fontSize(14)
          .fontWeight(600)
          .fontColor('#0A59F7')
          .backgroundColor('#E8F0FE')
          .padding({
            left: 8,
            right: 8,
            top: 4,
            bottom: 4
          })
          .borderRadius(6)
        Text(url)
          .fontSize(11)
          .fontColor('#888')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
      }.width('100%')

      Text(ruleDesc)
        .fontSize(11).fontColor('#666').width('100%').maxLines(2)
      Web({ src: url, controller: new webview.WebviewController() })
        .javaScriptAccess(true)
        .runJavaScriptOnDocumentEnd(scripts)
        .onPageEnd(() => {
          this.webLoadedCount++
        })
        .width('100%')
        .height(this.webHeight)
        .onInterceptRequest((event) => {
          return this.buildCustomProtocolResponse()
        })
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .border({ width: 1, color: '#E5E7EB' })
  }

  build() {
    Column() {
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
      .width('100%')
      .height(44)
      .justifyContent(0)
      .alignItems(1)
      .onClick(() => router.back())
      .id('javascript_doc_end_back')

      if (this.webLoadedCount >= 1) {
        Row() {
          Text('✓  Web 页面加载成功')
            .id('js_doc_end_feedback')
            .fontSize(13).fontColor('#FFFFFF')
        }
        .width('100%')
        .height(32)
        .padding({ left: 12, right: 12 })
        .backgroundColor('#52C41A')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .shadow({ radius: 6, color: '#52C41A33', offsetY: 2 })
      }

      Scroll() {
        Column({ space: 12 }) {
          this.webBlock(
            '✅ 规则1 通配符命中', this.webUrl,
            'scriptRules: [\'*\'] — 使用通配符"*"，允许所有来源的网址,当前 www.baidu.com 命中',
            this.scriptsWildcard)

          this.webBlock(
            '✅ 规则2 精确命中', this.webUrl,
            'scriptRules: [\'https://www.baidu.com\'] — 精确匹配 www.baidu.com，当前页面命中',
            this.scriptsExactUrl)

          this.webBlock(
            '✅ 规则3 模糊命中', this.webUrl,
            'scriptRules: [\'https://*.baidu.com\'] — 模糊匹配 *.baidu.com，当前 www.baidu.com 命中',
            this.scriptsValidFuzzy)

          this.webBlockWithIntercept(
            '✅ 规则5 自定义协议命中', this.customProtocolUrl,
            'scriptRules: [\'testweb://\'] — 自定义协议必须以://结尾，不支持精确/模糊匹配，命中',
            this.scriptsCustomProtocol)

          this.webBlock(
            '✅ 规则6 其中一条满足,命中', this.webUrl,
            'scriptRules: [\'https://*baidu.com, "*"\'] — 一条无效则整组无效，命中',
            this.scriptsOneMatch)

          this.webBlock(
            '✅ 规则7 二级域名+正则匹配 命中', this.webUrl,
            'urlRegexRules: [{secondLevelDomain:\'baidu.com\', rule:\'https://www\\\\.baidu\\\\.com/.*\'}] — 命中',
            this.scriptsDomainRegex)

          this.webBlock(
            '✅ 规则8 空scriptRules+宽松正则 命中', this.webUrl,
            'scriptRules:[], urlRegexRules:[{baidu.com, \'.*baidu.*\'}] — 空数组+urlRegexRules独立生效',
            this.scriptsUrlRegexLoose)

          this.webBlock(
            '✅ 规则8 ^https锚点正则 命中', this.webUrl,
            'scriptRules:[], urlRegexRules:[{baidu.com, \'^https:\\\\/\\\\/\'}] — 锚点匹配https',
            this.scriptsUrlRegexHttpsAnchor)

          this.webBlock(
            '✅ 规则8 ^https://www锚点 命中', this.webUrl,
            'scriptRules:[], urlRegexRules:[{baidu.com, \'^https:\\\\/\\\\/www.*\'}] — 严格www锚点匹配',
            this.scriptsUrlRegexWwwAnchor)

        }
        .width('100%')
        .padding({ top: 8, bottom: 16 })
      }
      .scrollBar(BarState.Auto)
      .width('100%').height('100%').layoutWeight(1)
    }
    .width('100%').height('100%')
    .padding(12)
    .id('JavaScriptOnDocumentEndPage')
  }
}
