// xxx.ets
import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State texts: string = "";
  build() {
    Column() {

      Back()
      Text(`${this.texts}`).id('onBeforeUnload');
      Web({ src: $rawfile("onrefreshAccess_onBeforeUnload.html"), controller: this.controller })
        .onAlert((event) => {
          if (event) {
            console.log("event.url:" + event.url);
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
                  event.result.handlePromptConfirm('t123123');
                }
              },
              cancel: () => {
                event.result.handleCancel();
              }
            })
          }
          return true;
        })
        .onBeforeUnload((event) => {
          if (event) {
            console.log(`--------------------${JSON.stringify(event)}`);
            console.log("event.url:" + event.url);
            console.log("event.message:" + event.message);
            AlertDialog.show({
              title: 'onBeforeUnload',
              message: `url为：${event.url}；message为：${event.message}`,
              primaryButton: {
                value: 'handle',
                action: () => {
                  event.result.handleCancel();
                }
              },
              secondaryButton: {
                value: 'ok',
                action: () => {
                  event.result.handleConfirm();
                  this.texts = 'onBeforeUnload';
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

