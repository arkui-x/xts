import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  httpAuth: boolean = false;
  @State isTrue: boolean = false;

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)

      Text('isTrue: ' + this.isTrue)
        .id('TAG')

      Web({ src: 'https://httpbin.org/basic-auth/user/pass', controller: this.controller })
        .onHttpAuthRequest((event: OnHttpAuthRequestEvent) => {
          if (event) {
            this.isTrue = true;
            AlertDialog.show({
              title: 'onHttpAuthRequest',
              message: 'text',
              primaryButton: {
                value: 'cancel',
                action: () => {
                  event.handler.cancel();
                }
              },
              secondaryButton: {
                value: 'ok',
                action: () => {
                  this.httpAuth = event.handler.isHttpAuthInfoSaved();
                  if (this.httpAuth == false) {
                    webview.WebDataBase.saveHttpAuthCredentials(
                      event.host,
                      event.realm,
                      "user",
                      "pass"
                    )
                    event.handler.confirm('user', 'pass');
                  }
                }
              },
              cancel: () => {
                event.handler.cancel();
              }
            })
          }
          return true;
        })
    }
  }
}