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
      Text("event.title: " + this.str)
        .id("event.title")

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

      Button('change url')
        .width(200)
        .height(30)
        .onClick(() => {
          this.controller.loadUrl("https://uland.taobao.com/")
        })
        .margin(5)

      Web({ src: 'https://www.baidu.com/', controller: this.controller })
        .onTitleReceive((event:OnTitleReceiveEvent) => {
          if (event) {
            this.str = event.title;
            console.log('url:' + event.title);
          }
        })
    }
  }
}