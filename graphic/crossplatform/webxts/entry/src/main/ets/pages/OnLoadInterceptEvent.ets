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
  @State getRequestMethod: string = ''
  @State getRequestHeader_length: number = 0

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
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
      Text('getRequestMethod: ' + this.getRequestMethod)
        .id("getRequestMethod")
      Text('getRequestHeader_length: ' + this.getRequestHeader_length)
        .id("getRequestHeader_length")
        Web({ src: 'http://www.baidu.com/', controller: this.controller })
        .onLoadIntercept((event: OnLoadInterceptEvent) => {
          this.url = event.data.getRequestUrl()
          console.log('url:' + event.data.getRequestUrl());
          this.isMainFrame = event.data.isMainFrame()
          console.log('isMainFrame:' + event.data.isMainFrame());
          this.isRedirect = event.data.isRedirect()
          console.log('isRedirect:' + event.data.isRedirect());
          this.isRequestGesture = event.data.isRequestGesture()
          console.log('isRequestGesture:' + event.data.isRequestGesture());
          this.getRequestMethod = event.data.getRequestMethod()
          console.log('getRequestMethod:' + event.data.getRequestMethod());
          this.getRequestHeader_length = event.data.getRequestHeader().length
          console.log('getRequestHeader length:' + event.data.getRequestHeader().length);
          return true;
        })
    }
  }
}