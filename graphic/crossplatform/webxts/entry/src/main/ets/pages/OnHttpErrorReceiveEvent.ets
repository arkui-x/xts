// xxx.ets
import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''
  @State isMainFrame: Boolean = false
  @State isRedirect: Boolean = false
  @State isRequestGesture: Boolean = false
  @State getResponseData: string = ''
  @State getResponseEncoding: string = ''
  @State getResponseMimeType: string = ''
  @State getResponseCode: number = 0
  @State getReasonMessage: string = ''
  @State getRequestMethod: string = ''
  @State requestSize: number = 0
  @State responseSize: number = 0
  @State responseHeader: string = ''
  @State getResponseDataEx: string | number | Resource | ArrayBuffer | undefined = ''
  @State getResponseIsReady: Boolean = false

  build() {
    Scroll() {
      Column() {
        Button("back")
          .width(200)
          .height(30)
          .onClick(() => {
            router.back()
          })
          .margin(5)
        Button('refresh')
          .onClick(() => {
            this.controller.refresh()
          })
          .margin(5)
        Text('url: ' + this.url)
          .id("url")
        Text('isMainFrame: ' + this.isMainFrame)
          .id("isMainFrame")
        Text('isRedirect: ' + this.isRedirect)
          .id("isRedirect")
        Text('isRequestGesture: ' + this.isRequestGesture)
          .id("isRequestGesture")
        Text('getResponseData: ' + this.getResponseData)
          .id("getResponseData")
        Text('getResponseEncoding: ' + this.getResponseEncoding)
          .id("getResponseEncoding")
        Text('getResponseMimeType: ' + this.getResponseMimeType)
          .id("getResponseMimeType")
        Text('getResponseCode: ' + this.getResponseCode)
          .id("getResponseCode")
        Text('getReasonMessage: ' + this.getReasonMessage)
          .id("getReasonMessage")
        Text('getRequestMethod: ' + this.getRequestMethod)
          .id("getRequestMethod")
        Text('requestSize: ' + this.requestSize)
          .id("requestSize")
        Text('responseSize: ' + this.responseSize)
          .id("responseSize")
        Text('responseHeader: ' + this.responseHeader)
          .id("responseHeader")
        Text('getResponseDataEx: ' + this.getResponseDataEx)
          .id("getResponseDataEx")
        Text('getResponseIsReady: ' + this.getResponseIsReady)
          .id("getResponseIsReady")
        Web({ src: 'https://gitee.com/openharmony/docs/blob/master/READE.md', controller: this.controller })
          .onHttpErrorReceive((event: OnHttpErrorReceiveEvent) => {
            if (event) {
              this.url = event.request.getRequestUrl()
              console.log('url:' + event.request.getRequestUrl());
              this.isMainFrame = event.request.isMainFrame()
              console.log('isMainFrame:' + event.request.isMainFrame());
              this.isRedirect = event.request.isRedirect()
              console.log('isRedirect:' + event.request.isRedirect());
              this.isRequestGesture = event.request.isRequestGesture()
              console.log('isRequestGesture:' + event.request.isRequestGesture());
              this.getResponseData = event.response.getResponseData()
              console.log('getResponseData:' + event.response.getResponseData());
              this.getResponseEncoding = event.response.getResponseEncoding()
              console.log('getResponseEncoding:' + event.response.getResponseEncoding());
              this.getResponseMimeType = event.response.getResponseMimeType()
              console.log('getResponseMimeType:' + event.response.getResponseMimeType());
              this.getResponseCode = event.response.getResponseCode()
              console.log('getResponseCode:' + event.response.getResponseCode());
              this.getReasonMessage = event.response.getReasonMessage()
              console.log('getReasonMessage:' + event.response.getReasonMessage());
              this.getRequestMethod = event.request.getRequestMethod()
              console.log('getRequestMethod:' + event.request.getRequestMethod());
              let result = event.request.getRequestHeader();
              this.requestSize = result.length
              console.log('The request header result size is ' + result.length);
              for (let i of result) {
                console.log('The request header key is : ' + i.headerKey + ' , value is : ' + i.headerValue);
              }
              let resph = event.response.getResponseHeader();
              this.responseSize = resph.length
              console.log('The response header result size is ' + resph.length);
              for (let i of resph) {
                console.log('The response header key is : ' + i.headerKey + ' , value is : ' + i.headerValue);
              }
              this.responseHeader = resph[0].headerKey + ' ' + resph[0].headerValue
              this.getResponseDataEx = event.response.getResponseDataEx()
              console.log('getResponseDataEx: ' + event.response.getResponseDataEx())
              this.getResponseIsReady = event.response.getResponseIsReady()
              console.log('getResponseIsReady: ' + event.response.getResponseIsReady())
            }
          })
      }
    }
  }
}