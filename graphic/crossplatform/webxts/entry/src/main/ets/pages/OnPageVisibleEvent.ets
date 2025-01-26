import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''

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
      Web({ src: 'https://www.baidu.com/', controller: this.controller })
        .onPageVisible((event: OnPageVisibleEvent) => {
          this.url = event.url
          console.log('onPageVisible url:' + event.url);
        })
    }
  }
}