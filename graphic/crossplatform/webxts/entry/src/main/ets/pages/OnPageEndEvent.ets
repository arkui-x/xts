import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  @State str: string = ''
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text("event.url: " + this.str)
        .id("event.url")

      Button('refresh')
        .width(200)
        .height(30)
        .onClick(() => {
          this.controller.refresh()
        })
        .margin(5)

      Button('clean')
        .width(200)
        .height(30)
        .onClick(() => {
          this.str = ''
        })
        .margin(5)

      Web({ src: 'https://www.baidu.com/', controller: this.controller })
        .onPageEnd((event: OnPageEndEvent) => {
          if (event) {
            this.str = event.url;
            console.log('OnPageEndEvent url:' + event.url);
          }
        })
    }
  }
}