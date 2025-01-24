// xxx.ets
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''
  @State message: string = ''

  build() {
    Column() {
      Text('event.url: ' + this.url)
        .id('url')
      Text('event.message: ' + this.message)
        .id('message')
      Web({ src: $rawfile("OnAlertEvent.html"), controller: this.controller })
        .onAlert((event: OnAlertEvent) => {
          if (event) {
            this.url = event.url
            console.log("event.url:" + event.url);
            this.message = event.message
            console.log("event.message:" + event.message);
            AlertDialog.show({
              title: 'onAlert',
              message: 'text',
              primaryButton: {
                value: 'cancel',
                action: () => {
                  event.result.handleCancel();
                }
              },
              secondaryButton: {
                value: 'ok',
                action: () => {
                  event.result.handleConfirm();
                }
              },
              cancel: () => {
                event.result.handleCancel();
              }
            })
          }
          return true;
        })
    }
  }
}