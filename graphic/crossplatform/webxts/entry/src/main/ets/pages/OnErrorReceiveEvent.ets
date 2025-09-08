import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State getErrorInfo: string = ''
  @State getErrorCode: number = 0;
  @State url: string = '';
  @State isMainFrame: Boolean = false;
  @State isRedirect: Boolean = false;
  @State isRequestGesture: Boolean = false;
  @State getRequestHeader_headerKey: string = '';
  @State requestSize: number = 0;
  @State getRequestMethod: string = '';

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)

      Text('getErrorInfo: ' + this.getErrorInfo)
        .id('getErrorInfo')
        .fontSize(8)
      Text('getErrorCode: ' + this.getErrorCode)
        .id('getErrorCode')
      Text('url: ' + this.url)
        .id('url')
      Text('isMainFrame: ' + this.isMainFrame)
        .id('isMainFrame')
      Text('isRedirect: ' + this.isRedirect)
        .id('isRedirect')
      Text('isRequestGesture: ' + this.isRequestGesture)
        .id('isRequestGesture')
      Text('getRequestHeader_headerKey: ' + this.getRequestHeader_headerKey)
        .id('getRequestHeader_headerKey')
      Text('requestSize: ' + this.requestSize)
        .id('requestSize')
      Text('getRequestMethod: ' + this.getRequestMethod)
        .id('getRequestMethod')
      Web({ src: 'http://www.1qaz!QAZ.com/', controller: this.controller })
        .onErrorReceive((event:OnErrorReceiveEvent) => {
          if (event) {
            this.getErrorInfo = event.error.getErrorInfo()
            console.log('getErrorInfo:' + event.error.getErrorInfo());
            this.getErrorCode = event.error.getErrorCode()
            console.log('getErrorCode:' + event.error.getErrorCode());
            this.url = event.request.getRequestUrl()
            console.log('url:' + event.request.getRequestUrl());
            this.isMainFrame = event.request.isMainFrame()
            console.log('isMainFrame:' + event.request.isMainFrame());
            this.isRedirect = event.request.isRedirect()
            console.log('isRedirect:' + event.request.isRedirect());
            this.isRequestGesture = event.request.isRequestGesture()
            console.log('isRequestGesture:' + event.request.isRequestGesture());
            this.getRequestHeader_headerKey = event.request.getRequestHeader().toString()
            console.log('getRequestHeader_headerKey:' + JSON.stringify(event.request.getRequestHeader()));
            let result = event.request.getRequestHeader();
            this.requestSize = result.length
            console.log('The request header result size is ' + result.length);
            for (let i of result) {
              console.log('The request header key is : ' + i.headerKey + ', value is : ' + i.headerValue);
            }
            this.getRequestMethod = event.request.getRequestMethod()
            console.log('getRequestMethod: ' + event.request.getRequestMethod());
          }
        })
    }
  }
}