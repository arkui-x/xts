import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State url: string = ''
  @State message: string = ''
  @State value: string = ''

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
        .id('url')
      Text('message: ' + this.message)
        .id('message')
      Text('value: ' + this.value)
        .id('value')
      Web({ src: $rawfile("OnPromptEvent.html"), controller: this.controller })
        .onPrompt((event:OnPromptEvent) => {
          if (event) {
            this.url = event.url
            console.log("url:" + event.url);
            this.message = event.message
            console.log("message:" + event.message);
            this.value = event.value
            console.log("value:" + event.value);
            AlertDialog.show({
              title: 'onPrompt',
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