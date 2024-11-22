import web_webview from '@ohos.web.webview'
import business_error from '@ohos.base';
import { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';

@Component
export struct WebContent {
  @Prop funcName: string = ''
  @Prop htmlName: string = ''
  @State url: string | Resource = ''
  @State minFontSize: number = 12
  @State myBackgroundColor: string | Color = Color.Pink
  @State USER_AGENT: string = ''
  @State ON_EVENT_URL: string = ''
  @State ON_EVENT_MESSAGE: string = ''
  @State ON_EVENT_VALUE: string = ''
  @State ON_BUTTON_CLICK: string = ''
  @State changeTitle: boolean = false
  @State fileUri: string = ''
  @State host: string = ''
  @State realm: string = ''
  @State ports: web_webview.WebMessagePort[] = []
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  textController: TextInputController = new TextInputController()

  @Styles
  commonTextStyle()  {
    .height(25)
    .width('100%')

  }

  aboutToAppear() {
    this.url = !this.htmlName.includes('http') ? $rawfile(this.htmlName) : this.htmlName
  }

  async runJSFunc(funcName: string, controller: web_webview.WebviewController) {
    try {
      const result: string = await controller.runJavaScript(`${funcName}()`)
      console.log(`runJavaScript ${funcName}: ${result}`)
      const hasName: boolean = this.htmlName.includes('video') || this.htmlName.includes('page_visible')
      if (hasName && funcName === 'getType') this.USER_AGENT = result
    } catch (resError) {
      let e: business_error.BusinessError = resError as business_error.BusinessError;
      console.error(`runJavaScript ErrorCode: ${e.code},  Message: ${e.message}`);
    }
  }

  build() {
    Flex({
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Start,
      direction: FlexDirection.Column,
    }) {
      Text()
        .height(20)
      Text(this.USER_AGENT)
        .id('USER_AGENT')
        .textAlign(TextAlign.Center)
        .textOverflow({
          overflow: TextOverflow.MARQUEE
        })
        .commonTextStyle()
      Text(this.ON_EVENT_URL)
        .id('ON_EVENT_URL')
        .textAlign(TextAlign.Center)
        .textOverflow({
          overflow: TextOverflow.MARQUEE
        })
        .commonTextStyle()
      Text(this.ON_EVENT_MESSAGE)
        .id('ON_EVENT_MESSAGE')
        .textAlign(TextAlign.Center)
        .textOverflow({
          overflow: TextOverflow.MARQUEE
        })
        .commonTextStyle()
      Text(this.ON_EVENT_VALUE)
        .id('ON_EVENT_VALUE')
        .textAlign(TextAlign.Center)
        .textOverflow({
          overflow: TextOverflow.MARQUEE
        })
        .commonTextStyle()
      Text(this.ON_BUTTON_CLICK)
        .id('ON_BUTTON_CLICK')
        .textAlign(TextAlign.Center)
        .commonTextStyle()

      Flex({
        justifyContent: FlexAlign.SpaceAround,
        alignItems: ItemAlign.Center,
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap
      }) {
        Button('TRIGGER')
          .onClick(e => {
            if (this.htmlName.includes('page')) {
              try {
                const origin: string = this.controller.getUrl()
                if (origin.includes('page')) {
                  this.controller.loadUrl($rawfile('index_alert.html'));
                } else {
                  this.controller.loadUrl($rawfile(this.htmlName))
                }
              } catch (error) {
                let e: business_error.BusinessError = error as business_error.BusinessError;
                console.error(`ErrorCode: ${e.code},  Message: ${e.message}`);
              }
            }
            if (this.funcName) {
              this.runJSFunc(this.funcName, this.controller)
            }
          })
          .size({ height: 20 })
        if (this.htmlName.includes('video') || this.htmlName.includes('page_visible')) {
          Button('UA')
            .onClick(e => {
              this.runJSFunc('getType', this.controller)
            })
            .size({ height: 20 })
        }
        Column()
          .width('100%')
          .height(5)
        if (this.htmlName.includes('page')) {
          Button('ACCESS_STEP')
            .id('ACCESS_STEP')
            .onClick(async e => {
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: '请选择',
                buttons: [
                  {
                    text: '-1',
                    color: '#333333'
                  },
                  {
                    text: '0',
                    color: '#333333'
                  },
                  {
                    text: '1',
                    color: '#333333'
                  }
                ]
              })
              const index: number = value.index
              const result: number = index === 0 ? -1 : (index === 1 ? 0 : 1)
              const isAccess: boolean = await this.controller.accessStep(result)
              this.ON_EVENT_VALUE = `accessStep: ${result}, result: ${isAccess}`
            })
            .size({ height: 20 })
          Button('BOF')
            .onClick(async e => {
              const result: string = await this.controller.runJavaScript('jumpToAlert()')
              this.ON_EVENT_VALUE = result
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: '请选择',
                buttons: [
                  {
                    text: '-1',
                    color: '#333333'
                  },
                  {
                    text: '1',
                    color: '#333333'
                  }
                ]
              })
              const index: number = value.index
              const step: number = index ? 1 : -1
              this.controller.backOrForward(step)
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('History_LIST')
            .onClick(e => {
              const list: web_webview.BackForwardList = this.controller.getBackForwardEntries()
              this.ON_EVENT_URL = list.getItemAtIndex(list.currentIndex).historyUrl
              this.ON_EVENT_VALUE = `${list.size}`
            })
            .size({ height: 20 })
          Button('access')
            .onClick(async e => {
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: 'access',
                buttons: [
                  {
                    text: '前进',
                    color: '#333'
                  },
                  {
                    text: '后退',
                    color: '#333'
                  },
                ]
              })
              const index: number = value.index
              if (index) {
                const result: boolean = this.controller.accessBackward()
                this.ON_EVENT_VALUE = `accessBackward: ${result}`
              } else {
                const result: boolean = this.controller.accessForward()
                this.ON_EVENT_VALUE = `accessForward: ${result}`
              }
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('forward')
            .onClick(e => {
              this.controller.forward()
              this.ON_EVENT_URL = this.controller.getUrl()
            })
            .size({ height: 20 })
          Button('backward')
            .onClick(e => {
              this.controller.backward()
              this.ON_EVENT_URL = this.controller.getUrl()
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('GET_TITLE')
            .onClick(e => {
              this.ON_EVENT_VALUE = this.controller.getTitle()
            })
            .size({ height: 20 })
          Button('SET_TITLE')
            .onClick(async e => {
              this.changeTitle = true
              await this.controller.runJavaScript('changeTitle()')
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('CLEAR History')
            .backgroundColor(Color.Red)
            .onClick(e => {
              this.controller.clearHistory()
            })
            .size({ height: 20 })
        }
        if (this.htmlName.includes('example')) {
          Button('CONFIG')
            .onClick(async e => {
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: 'configCookie',
                buttons: [
                  {
                    text: 'callback',
                    color: '#333333'
                  },
                  {
                    text: 'promise',
                    color: '#333333'
                  }
                ]
              })
              const index: number = value.index
              if (index) {
                web_webview.WebCookieManager.configCookie(this.htmlName, 'test=123')
                  .then(() => {
                    this.ON_EVENT_VALUE = 'config cookie success, cookie: test=123'
                  })
                  .catch((error: BusinessError) => {
                    this.ON_EVENT_VALUE = `config cookie error, code: ${error.code}, msg: ${error.message}`
                  })
              } else {
                web_webview.WebCookieManager.configCookie(this.htmlName, 'test=123', (error: BusinessError) => {
                  if (!error) {
                    this.ON_EVENT_VALUE = 'config cookie success, cookie: test=123'
                  } else {
                    this.ON_EVENT_VALUE = `config cookie error, code: ${error.code}, msg: ${error.message}`
                  }
                })
              }
            })
            .size({ height: 20 })
          Button('FETCH')
            .onClick(async e => {
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: 'fetchCookie',
                buttons: [
                  {
                    text: 'callback',
                    color: '#333333'
                  },
                  {
                    text: 'promise',
                    color: '#333333'
                  }
                ]
              })
              const index: number = value.index
              if (index) {
                web_webview.WebCookieManager.fetchCookie(this.htmlName)
                  .then((result: string) => {
                    this.ON_EVENT_VALUE = result
                  })
                  .catch((error: BusinessError) => {
                    this.ON_EVENT_VALUE = `config cookie error, code: ${error.code}, msg: ${error.message}`
                  })
              } else {
                web_webview.WebCookieManager.fetchCookie(this.htmlName, (error: BusinessError, result: string) => {
                  if (!error) {
                    this.ON_EVENT_VALUE = result
                  } else {
                    this.ON_EVENT_VALUE = `config cookie error, code: ${error.code}, msg: ${error.message}`
                  }
                })
              }
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('CLEAR_ALL')
            .onClick(async e => {
              this.ON_EVENT_VALUE = 'clear all'
              const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                title: 'clearAllCookies',
                buttons: [
                  {
                    text: 'callback',
                    color: '#333333'
                  },
                  {
                    text: 'promise',
                    color: '#333333'
                  }
                ]
              })
              const index: number = value.index
              if (index) {
                web_webview.WebCookieManager.clearAllCookies()
              } else {
                web_webview.WebCookieManager.clearAllCookies((error: BusinessError) => {})
              }
            })
            .size({ height: 20 })
        }
      }
      .margin({
        top: 10
      })

      Column() {
        Web({ src: this.url, controller: this.controller })
          .id(this.htmlName)
          .minFontSize(this.minFontSize)
          .backgroundColor(this.myBackgroundColor)
          .onPageVisible((event) => {
            if (this.htmlName.includes('page')) {
              this.ON_EVENT_URL = 'onPageVisible ' + event.url
            }
          })
          .onConsole((event) => {
            if (event) {
              const level: MessageLevel = event.message.getMessageLevel()
              const msg: string = event.message.getMessage()
              const levelStr: string = level === 2 ? 'log' : 'error'
              this.ON_EVENT_VALUE = `console ${levelStr}:${msg}`
            }
            return false
          })
          .onTitleReceive((event) => {
            if (event) {
              if (this.changeTitle) {
                this.ON_EVENT_VALUE = `newTitle:${event.title}`
                this.changeTitle = false
              }
            }
          })
          .onLoadIntercept((event) => {
            if (this.funcName === 'notLoad') {
              setTimeout(() => {
                this.ON_EVENT_URL = 'index_alert.html'
                this.ON_EVENT_VALUE = 'onLoadIntercept return true: 阻止此次加载'
              }, 1000)
              return true
            }
            return false
          })
      }
      .width('100%')
      .height(200)
    }
    .width('100%')
    .height('100%')
  }
}