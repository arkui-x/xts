import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';


@Entry
@Component
struct ExistCookie {
  controller: webview.WebviewController = new webview.WebviewController();
  @State result: boolean = true;

  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  build() {
    Column() {
      Back()
      Text(this.result ? "true" : "false").fontColor('red')
        .id('TextId')
      Button('existCookie')
        .onClick(() => {
          this.result = webview.WebCookieManager.existCookie();
        }).id('existCookieId')
      Web({ src: $rawfile('index_cookie.html'), controller: this.controller })
    }
  }
}