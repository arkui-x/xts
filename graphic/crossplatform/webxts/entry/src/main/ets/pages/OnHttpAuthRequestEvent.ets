import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

const HTTP_AUTH_URLS: string[] = [
  'https://testpages.eviltester.' + 'com/pages/auth/basic-auth/basic-auth-results.html',
  'https://httpbin.' + 'org/basic-auth/user/passwd',
  'http://httpbin.' + 'org/basic-auth/user/passwd',
];

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  httpAuth: boolean = false;
  @State isTrue: boolean = false;
  @State authUrlIndex: number = 0;
  httpAuthReceived: boolean = false;

  tryNextHttpAuthUrl(): void {
    if (this.httpAuthReceived || this.authUrlIndex >= HTTP_AUTH_URLS.length - 1) {
      return;
    }
    this.authUrlIndex++;
    this.controller.loadUrl(HTTP_AUTH_URLS[this.authUrlIndex]);
  }

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

      Web({ src: HTTP_AUTH_URLS[0], controller: this.controller })
        .onHttpErrorReceive(() => {
          if (!this.httpAuthReceived) {
            this.tryNextHttpAuthUrl();
          }
        })
        .onHttpAuthRequest((event: OnHttpAuthRequestEvent) => {
          if (event) {
            this.httpAuthReceived = true;
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
                      "authorized",
                      "password001"
                    )
                    event.handler.confirm('authorized', 'password001');
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
