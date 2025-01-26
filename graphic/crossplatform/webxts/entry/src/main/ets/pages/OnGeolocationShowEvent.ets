import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State isTrue: Boolean = true

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Button('refresh')
        .width(200)
        .height(30)
        .onClick(() => {
          this.controller.refresh()
        })
        .margin(5)

      Text('isTrue: ' + this.isTrue)
        .id('isTrue')

      Web({ src: $rawfile('OnGeolocationShowEvent.html'), controller: this.controller })
        .geolocationAccess(true)
        .onGeolocationShow((event: OnGeolocationShowEvent) => {
          this.isTrue = true
          if (event) {
            AlertDialog.show({
              title: '权限请求',
              message: '请打开地理位置权限',
              confirm: {
                value: '打开',
                action: () => {
                  event.geolocation.invoke(event.origin, true, true);
                }
              },
              cancel: () => {
                event.geolocation.invoke(event.origin, false, false);
              }
            })
          }
        })
    }
  }
}