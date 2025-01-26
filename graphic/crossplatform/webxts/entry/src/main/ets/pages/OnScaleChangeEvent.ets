import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State oldScale: number = 0
  @State newScale: number = 0

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text('Scale: ' + this.oldScale)
        .id("oldScale")
      Text('Scale: ' + this.newScale)
        .id("newScale")

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
        .onScaleChange((event:OnScaleChangeEvent) => {
          this.oldScale = event.oldScale
          this.newScale = event.newScale
          console.log('onScaleChange changed from ' + event.oldScale + ' to ' + event.newScale);
        })
        .zoomAccess(true)
    }
  }
}