import web_webview from '@ohos.web.webview'
import business_error from '@ohos.base';
import { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';
import fs from '@ohos.file.fs';

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
      const hasName: boolean = this.htmlName.includes('video') || this.htmlName.includes('page_visible') || this.htmlName.includes('download');
      if (hasName && funcName === 'getType') {
        this.USER_AGENT = result;
      }
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
        if (this.htmlName.includes('video') || this.htmlName.includes('page_visible') || this.htmlName.includes('download')) {
          Button('UA')
            .onClick(e => {
              this.runJSFunc('getType', this.controller)
            })
            .size({ height: 20 })
        }
        if (this.htmlName.includes('alert')) {
          Button('loadData')
            .onClick(e => {
              this.controller.loadData(
                `<body><div><image src=${$rawfile('assets/icon.png')} alt="image -- end" width="500" height="250"></image></div></body>`,
                "text/html", "UTF-8", " ", " "
              )
              setTimeout(async () => {
                this.ON_EVENT_VALUE = `hasImage: true`
              }, 500)
            })
            .size({ height: 20 })
          Button('SET')
            .onClick(e => {
              this.minFontSize = this.minFontSize === 12 ? 16 : 12
              this.myBackgroundColor = this.myBackgroundColor === Color.Grey ? Color.Pink : Color.Grey
              this.ON_EVENT_MESSAGE = `minFontSize:${this.minFontSize}, backgroundColor:${this.myBackgroundColor}`
            })
            .size({ height: 20 })
        }
        if (this.htmlName.includes('geolocation')) {
          Button('clearWatch')
            .onClick(async e => {
              this.ON_EVENT_VALUE = await this.controller.runJavaScript('clearLoc()')
            })
            .size({ height: 20 })
        }
        Column()
          .width('100%')
          .height(5)
        if (this.htmlName.includes('file')) {
          Button('DOCUMENT_SAVE')
            .id('DOCUMENT_SAVE')
            .onClick(async e => {
              try {
                const pathDir: string|undefined = AppStorage.get('pathDir');
                const path: string = pathDir + '/test.txt';
                const file: fs.File = await fs.open(path, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
                this.fileUri = path;
                console.log('DOCUMENT_SAVE', path);
                this.ON_EVENT_MESSAGE = 'SAVE test.txt';
                this.ON_EVENT_VALUE = this.fileUri;
              } catch (err) {
                console.error('save failed with err: ' + JSON.stringify(err));
              }
            })
            .size({ height: 20 })
        }
        if (this.htmlName.includes('http')) {
          Button('GET_HAC')
            .onClick(e => {
              const up: string[] = web_webview.WebDataBase.getHttpAuthCredentials(this.host, this.realm)
              this.ON_EVENT_MESSAGE = up.join(',')
            })
            .size({ height: 20 })
          Button('EXIST_HAC')
            .onClick(e => {
              const result: boolean = web_webview.WebDataBase.existHttpAuthCredentials()
              this.ON_EVENT_MESSAGE = `existHttpAuthCredentials: ${result}`
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          Button('DELETE_HAC')
            .onClick(e => {
              web_webview.WebDataBase.deleteHttpAuthCredentials();
              this.ON_EVENT_MESSAGE = '已删除'
            })
            .size({ height: 20 })
          Button('SAVE_HAC')
            .onClick(e => {
              this.ON_EVENT_MESSAGE = `save host: ${this.host}, realm: ${this.realm}`
              web_webview.WebDataBase.saveHttpAuthCredentials(
                this.host, this.realm,
                "2222",
                "2222"
              )
            })
            .size({ height: 20 })
        }
        if (this.htmlName.includes('message')) {
          Button('createPorts')
            .onClick(e => {
              // 1、创建两个消息端口。
              this.ports = this.controller.createWebMessagePorts();
              this.ON_EVENT_VALUE = `create ports: ${this.ports.length}个`
            })
            .size({ height: 20 })
          Button('postMessage')
            .onClick(() => {
              if (this.ports && this.ports.length == 2) {
                // 2、在应用侧的消息端口(如端口1)上注册回调事件。
                this.ports[1].onMessageEvent((result: web_webview.WebMessage) => {
                  this.ON_EVENT_VALUE = 'Got msg from HTML:' + result;
                })
                // 3、将另一个消息端口(如端口0)发送到HTML侧，由HTML侧保存并使用。
                this.controller.postMessage('__init_port__', [this.ports[0]], '*');
              } else {
                this.ON_EVENT_MESSAGE = 'msgPort is null, Please initialize first'
              }
            })
            .size({ height: 20 })
          Column()
            .width('100%')
            .height(5)
          // 4、使用应用侧的端口给另一个已经发送到html的端口发送消息。
          Button('SendToHTML')
            .onClick(async e => {
              if (this.ports && this.ports.length == 2) {
                const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择发送的消息',
                  buttons: [
                    {
                      text: 'HelloArkTs',
                      color: '#333333'
                    },
                    {
                      text: 'HelloOH',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = value.index
                const msg: web_webview.WebMessage = index ? 'HelloOH' : 'HelloArkTs'
                this.ON_EVENT_MESSAGE = `post message: ${msg}`
                if (this.ports && this.ports[1]) {
                  this.ports[1].postMessageEvent(msg);
                }
              } else {
                this.ON_EVENT_MESSAGE = 'msgPort is null, Please initialize first'
              }
            })
            .size({ height: 20 })
          Button('close')
            .onClick(e => {
              if (this.ports && this.ports.length == 2) {
                this.ports[1].close();
                this.ON_EVENT_MESSAGE = 'close port'
              } else {
                this.ON_EVENT_MESSAGE = 'msgPort is null, Please initialize first'
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
          .onAlert((event) => {
            if (event) {
              this.ON_EVENT_URL = 'index_alert.html'
              this.ON_EVENT_MESSAGE = event.message
              AlertDialog.show({
                title: 'onAlert',
                message: event.message,
                primaryButton: {
                  value: 'cancel',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'CANCEL_CLICKED'
                    event.result.handleCancel()
                  }
                },
                secondaryButton: {
                  value: 'ok',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'OK_CLICKED'
                    event.result.handleConfirm()
                  }
                },
                cancel: () => {
                  event.result.handleCancel()
                }
              })
            }
            return true
          })
          .onConfirm((event) => {
            if (event) {
              this.ON_EVENT_URL = 'index_confirm.html'
              this.ON_EVENT_MESSAGE = event.message
              AlertDialog.show({
                title: 'onConfirm',
                message: event.message,
                primaryButton: {
                  value: 'cancel',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'CANCEL_CLICKED'
                    event.result.handleCancel()
                  }
                },
                secondaryButton: {
                  value: 'ok',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'OK_CLICKED'
                    event.result.handleConfirm()
                  }
                },
                cancel: () => {
                  event.result.handleCancel()
                }
              })
            }
            return true
          })
          .onPrompt((event) => {
            if (event) {
              this.ON_EVENT_URL = 'index_prompt.html'
              this.ON_EVENT_MESSAGE = event.message
              this.ON_EVENT_VALUE = event.value
              promptAction.showDialog({
                title: 'onPrompt',
                message: event.message,
                buttons: [
                  {
                    text: 'cancel',
                    color: '#409eff'
                  },
                  {
                    text: 'ok',
                    color: '#409eff'
                  }
                ],

              }, (err, data) => {
                if (err) {
                  return;
                }
                if (data.index === 0) {
                  this.ON_BUTTON_CLICK = 'CANCEL_CLICKED'
                  event.result.handleCancel()
                } else {
                  this.ON_BUTTON_CLICK = 'OK_CLICKED'
                  event.result.handlePromptConfirm(event.value)
                }
                console.info('showDialog success callback, click button: ' + data.index);
              });
            }
            return true
          })
          .onHttpAuthRequest((event) => {
            if (event) {
              this.ON_EVENT_MESSAGE = `host: ${event.host}, realm: ${event.realm}`
              this.host = event.host
              this.realm = event.realm
              event.handler.cancel()
            }
            return true
          })
          .onHttpErrorReceive((event) => {
            if (event) {
              this.ON_EVENT_URL = event.request.getRequestUrl()
              this.ON_EVENT_VALUE = event.response.getResponseCode().toString()
            }
          })
          .onShowFileSelector((event) => {
            if (event) {
              event.result.handleFileList([]);
              this.ON_EVENT_VALUE = this.fileUri
            }
            return true
          })
          .onPermissionRequest((event) => {
            if (event) {
              this.ON_EVENT_URL = 'index_permission_req.html'
              AlertDialog.show({
                title: 'onPermissionRequest',
                message: 'onPermissionRequest callback',
                primaryButton: {
                  value: 'deny',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'DENY_CLICKED'
                    event.request.deny()
                  }
                },
                secondaryButton: {
                  value: 'ok',
                  action: () => {
                    this.ON_BUTTON_CLICK = 'OK_CLICKED'
                    const resource: string[] = event.request.getAccessibleResource()
                    this.ON_EVENT_VALUE = resource.join(',')
                    event.request.grant(resource)
                  }
                },
                cancel: () => {
                  event.request.deny()
                }
              })
            }
          })
          .onPageVisible((event) => {
            if (this.htmlName.includes('page')) {
              this.ON_EVENT_URL = 'onPageVisible ' + event.url
            }
          })
          .onDownloadStart((event) => {
            if (event) {
              this.ON_EVENT_URL = event.url
              this.ON_EVENT_VALUE = event.mimetype
            }
          })
          .onSearchResultReceive((event) => {
            if (event) {
              this.ON_EVENT_VALUE = `查找到:${event.numberOfMatches}个，当前第${event.activeMatchOrdinal}个`
            }
          })
          .onConsole((event) => {
            if (event) {
              if (!this.htmlName.includes('permission') && !this.htmlName.includes('http')) {
                const level: MessageLevel = event.message.getMessageLevel()
                const msg: string = event.message.getMessage()
                const levelStr: string = level === 2 ? 'log' : 'error'
                this.ON_EVENT_VALUE = `console ${levelStr}:${msg}`
              }
              if (this.htmlName.includes('file')) {
                this.ON_EVENT_VALUE = this.fileUri
              }
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
              this.ON_EVENT_URL = 'index_alert.html'
              this.ON_EVENT_VALUE = 'onLoadIntercept return true: 阻止此次加载'
              return true
            }
            return false
          })
          .mediaPlayGestureAccess(false)
      }
      .width('100%')
      .height(200)
    }
    .width('100%')
    .height('100%')
  }
}