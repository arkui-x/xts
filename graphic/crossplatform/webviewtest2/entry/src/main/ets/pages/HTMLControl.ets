import web_view from '@ohos.web.webview';
import business_error, { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';
import MY_TABS from '../datasource/ControllerTabContentData'
import { MyTabContent } from '../beans/MyTabContent';
import router from '@ohos.router';

@Entry
@Component
struct Controller {
  private my_tabs: MyTabContent[] = MY_TABS
  private web_controller: web_view.WebviewController = new web_view.WebviewController();
  @State MY_TO_STRING: string = ''
  @State MY_COUNT: string = ''
  @State MY_VALUE: string = ''
  @State MY_TIPS: string = ''
  @State SHOW_BUTTON_TYPE: string = 'zoom'
  @State horizontal: boolean = false
  @State vertical: boolean = false

  async runJSFunc(funcName: string): Promise<string> {
    try {
      const result: string = await this.web_controller.runJavaScript(funcName)
      console.log(`runJavaScript ${funcName}: ${result}`)
      return result
    } catch (resError) {
      let e: business_error.BusinessError = resError as business_error.BusinessError;
      console.error(`runJavaScript ErrorCode: ${e.code},  Message: ${e.message}`);
      return ''
    }
  }

  getRandomNum(min: number, max: number, toFixed?: boolean): number {
    if (!toFixed) {
      return Math.floor(Math.random() * (1 + max - min)) + min
    } else {
      return Math.round((Math.random() * (max - min) + min) * 10) / 10
    }
  }

  @Styles
  commonStyle() {
    .width('100%')
    .height('100%')
  }

  @Styles
  commonTextStyle()  {
    .height(25)
    .width('100%')
  }

  @Builder
  getHeight() {
    Button('GET_HEIGHT')
      .onClick(e => {
        const height: number = this.web_controller.getPageHeight()
        this.MY_COUNT = `pageHeight: ${height}`
        this.MY_VALUE = `pageHeight: ${height}`
      })
      .size({ height: 20 })
  }

  build() {
    Column() {
      Text('HTMLControl')

      Flex({
        alignItems: ItemAlign.Start,
        direction: FlexDirection.Column,
      }) {
        Text(this.MY_TO_STRING)
          .id('MY_TO_STRING')
          .textAlign(TextAlign.Center)
          .commonTextStyle()
        Text(this.MY_COUNT)
          .id('MY_COUNT')
          .textAlign(TextAlign.Center)
          .commonTextStyle()
        Text(`${this.MY_VALUE}`)
          .id('MY_VALUE')
          .textAlign(TextAlign.Center)
          .commonTextStyle()
        Text(`${this.MY_TIPS}`)
          .id('MY_TIPS')
          .textAlign(TextAlign.Center)
          .commonTextStyle()

        Flex({
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center,
          direction: FlexDirection.Row,
        }) {
          Button('zoom')
            .id('zoom')
            .onClick(e => {
              this.SHOW_BUTTON_TYPE = 'zoom'
            })
          Button('scroll')
            .onClick(e => {
              this.SHOW_BUTTON_TYPE = 'scroll'
              this.web_controller.loadUrl($rawfile('index_controller.html'))
            })
        }
        .height(20)
        .width('100%')
        .margin({
          bottom: 5
        })

        Flex({
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center,
          direction: FlexDirection.Row,
          wrap: FlexWrap.Wrap
        }) {
          if (this.SHOW_BUTTON_TYPE === 'scroll') {
            Button('Restore')
              .onClick(e => {
                this.web_controller.scrollTo(0, 0)
                this.MY_VALUE = `scroll to: 0,0`
              })
              .size({ height: 20 })
            Button('Scroll Precise')
              .onClick(async e => {
                let x: number = 0
                let y: number = 0
                const type: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择滚动方式',
                  buttons: [
                    {
                      text: '滚动到指定位置',
                      color: '#333333'
                    },
                    {
                      text: '滚动指定偏移量',
                      color: '#333333'
                    }
                  ]
                })
                const typeValue: number = type.index
                const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择滚动精度',
                  buttons: [
                    {
                      text: '100',
                      color: '#333333'
                    },
                    {
                      text: '200',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = value.index
                x = index ? 200 : 100
                y = index ? 200 : 100
                if (typeValue) {
                  this.web_controller.scrollBy(x, y)
                  this.MY_VALUE = `水平偏移: ${x}, 垂直偏移: ${y}`
                } else {
                  this.web_controller.scrollTo(x, y)
                  this.MY_VALUE = `scroll to: ${x},${y}`
                }
              })
              .size({ height: 20 })
            Column()
              .width('100%')
              .height(5)
            Button('ScrollRandom')
              .onClick(async e => {
                const x: number = this.getRandomNum(0, 1000)
                const y: number = this.getRandomNum(0, 1000)
                const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择滚动方式',
                  buttons: [
                    {
                      text: '滚动到指定位置',
                      color: '#333333'
                    },
                    {
                      text: '滚动指定偏移量',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = value.index
                if (index) {
                  this.web_controller.scrollBy(x, y)
                  this.MY_VALUE = `水平偏移: ${x}, 垂直偏移: ${y}`
                } else {
                  this.web_controller.scrollTo(x, y)
                  this.MY_VALUE = `scroll to: ${x},${y}`
                }
              })
              .size({ height: 20 })
            Button('setUserAgent')
              .onClick(async e => {
                const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择自定义用户代理信息',
                  buttons: [
                    {
                      text: '苹果',
                      color: '#333333'
                    },
                    {
                      text: '西瓜',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = value.index
                const userAgent: string = index ? '西瓜' : '苹果'
                this.web_controller.setCustomUserAgent(userAgent)
                this.MY_VALUE = `设置自定义用户代理: ${userAgent}`
              })
              .size({ height: 20 })
            Column()
              .width('100%')
              .height(5)
            Button('getUserAgent')
              .onClick(e => {
                const userAgent: string = this.web_controller.getCustomUserAgent()
                this.MY_VALUE = `获取自定义用户代理: ${userAgent}`
              })
              .size({ height: 20 })
            Button('scrollable')
              .onClick(async e => {
                const value: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择显示或隐藏',
                  buttons: [
                    {
                      text: '显示横轴滚动条',
                      color: '#333333'
                    },
                    {
                      text: '隐藏横轴滚动条',
                      color: '#333333'
                    },
                    {
                      text: '显示纵轴滚动条',
                      color: '#333333'
                    },
                    {
                      text: '隐藏纵轴滚动条',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = value.index
                if (index === 0 || index === 1) {
                  this.horizontal = index === 0
                }
                if (index === 2 || index === 3) {
                  this.vertical = index === 2
                }
                this.web_controller.refresh()
                this.MY_VALUE = `horizontal scrollbar is ${this.horizontal ? 'show' : 'hide'},vertical scrollbar is ${this.vertical ? 'show' : 'hide'}`
              })
              .size({ height: 20 })
          }
          if (this.SHOW_BUTTON_TYPE === 'zoom') {
            Button('ZoomRestore')
              .onClick(e => {
                this.web_controller.zoom(1)
                this.MY_VALUE = '当前网页的缩放比例: 100%'
                setTimeout(() => {
                  this.web_controller.scrollTo(0, 0)
                }, 350)
              })
              .size({ height: 20 })
            Button('Zoom Precise')
              .id('ZoomPrecise')
              .onClick(async e => {
                const type: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
                  title: '请选择缩放比例',
                  buttons: [
                    {
                      text: 'shrink',
                      color: '#333333'
                    },
                    {
                      text: 'magnify',
                      color: '#333333'
                    }
                  ]
                })
                const index: number = type.index
                const factor: number = index ? 1.5 : 0.8
                this.web_controller.zoom(factor)
                setTimeout(() => {
                  this.web_controller.scrollTo(0, 0)
                }, 350)
              })
              .size({ height: 20 })
            Column()
              .width('100%')
              .height(5)
            Button('ZoomRandom')
              .id('ZoomRandom')
              .onClick(e => {
                const zoomTime: number = this.getRandomNum(0.25, 2, true)
                this.web_controller.zoom(zoomTime)
                setTimeout(() => {
                  this.web_controller.scrollTo(0, 0)
                }, 350)
              })
              .size({ height: 20 })
            Button('10毫秒后Stop')
              .onClick(event => {
                this.web_controller.loadUrl($rawfile('index_confirm.html'))
                setTimeout(() => {
                  this.web_controller.stop()
                  AlertDialog.show({
                    title: 'StopTest',
                    message: '停止加载Confirm页面',
                    primaryButton: {
                      value: 'ok',
                      action: () => {
                        this.MY_VALUE = '停止加载Confirm页面'
                      }
                    },
                  })
                }, 10)
              })
              .size({ height: 20 })
            Column()
              .width('100%')
              .height(5)
            Button('不调用Stop')
              .onClick(event => {
                this.MY_TO_STRING = 'pageConfirm loaded'
                this.web_controller.loadUrl($rawfile('index_confirm.html'))
              })
              .size({ height: 20 })
          }
          Column()
            .width('100%')
            .height(5)
          this.getHeight()
        }
        .width('100%')
        .margin({
          bottom: 5
        })

        Column() {
          Web({ src: $rawfile('index_alert.html'), controller: this.web_controller })
            .backgroundColor(Color.Pink)
            .javaScriptAccess(true)
            .zoomAccess(true)
            .horizontalScrollBarAccess(this.horizontal)
            .verticalScrollBarAccess(this.vertical)
            .onScroll((event) => {
              if (this.SHOW_BUTTON_TYPE === 'scroll') {
                this.MY_TIPS = `onScroll -> ${event.xOffset},${event.yOffset}`
              }
            })
            .onScaleChange((event) => {
              const scale: string = (event.newScale - event.oldScale) > 0 ? 'magnify' : 'shrink'
              this.MY_VALUE = `${scale}当前网页的比例`
              this.MY_TIPS = 'onScaleChange changed from ' + Number(event.oldScale).toFixed(0) + ' to ' + Number(event.newScale).toFixed(0)
            })
            .onProgressChange((event) => {
              if (event) {
                this.MY_TIPS = `newProgress: ${event.newProgress}`
              }
            })
            .onControllerAttached(() => {
              try {
                this.MY_TO_STRING = 'index_controller.html';
                const id: number = this.web_controller.getWebId();
                this.MY_COUNT = `id: ${id}`;
              } catch (e) {
                const error: BusinessError = e as BusinessError;
                this.MY_COUNT = `id: 0`;
                console.error(`获取WebId失败，error code: ${error.code}, msg: ${error.message}`)
              }
            })
        }
        .height('300vp')
        .width('100%')
      }
      .height('85%')
      .width('100%')

      Column() {
        Button('设置页签')
          .onClick(async e => {
            const buttons: promptAction.Button[] = this.my_tabs.map((item: MyTabContent) => {
              const button: promptAction.Button = {
                text: `Goto ${item.tabBarName}`,
                color: '#333333'
              }
              return button
            })
            const type: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
              title: '请选择跳转的页签',
              buttons: buttons
            })
            const index: number = type.index
            const url: string = 'pages/' + this.my_tabs[index].tabBarName
            router.pushUrl({ url: url })
          })
          .size({ height: 20 })
      }
      .height('10%')
      .width('100%')
    }
    .commonStyle()
    .padding({
      top: 30
    })
  }
}