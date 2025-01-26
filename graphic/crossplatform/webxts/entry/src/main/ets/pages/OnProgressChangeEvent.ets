import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  @State num: number = 0
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
      Text("event.newProgress: " + this.num)
        .id("event.progress")

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
          this.num = 0
        })
        .margin(5)

      Web({ src: 'https://www.baidu.com/', controller: this.controller })
        .onProgressChange((event:OnProgressChangeEvent) => {
          if (event) {
            this.num = event.newProgress;
            console.log('event.newProgress::' + event.newProgress);
          }
        })
    }
  }
}