import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State xOffset: number = 0
  @State yOffset: number = 0

  build() {
    Scroll() {
      Column() {
        Text('xOffset: ' + this.xOffset)
          .id("xOffset")
        Text('yOffset: ' + this.yOffset)
          .id("yOffset")

        Button("back")
          .width(200)
          .height(30)
          .onClick(() => {
            router.back()
          })
          .margin(5)
        Button('change_percent')
          .width(200)
          .height(30)
          .onClick(() => {
            try {
              this.controller.zoom(2);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
        Web({ src: 'https://www.example.com/', controller: this.controller })
          .onScroll((event:OnScrollEvent) => {
            this.xOffset = event.xOffset
            console.info("event.xOffset: " + event.xOffset);
            this.yOffset = event.yOffset
            console.info("event.yOffset: " + event.yOffset);
          })
          .zoomAccess(true)
          .id('Web')

      }
    }
  }
}