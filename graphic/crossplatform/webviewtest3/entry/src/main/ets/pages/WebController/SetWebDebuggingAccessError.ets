// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State errorMsg: string = "";
  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(undefined);
    } catch (error) {
      this.errorMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
      console.error(this.errorMsg);
    }
  }

  build() {
    Column() {
      Back()
      Text(`errorMsg:${this.errorMsg}`).id("errorCode")
      Web({ src: 'https://www.baidu.com', controller: this.controller })
    }
  }
}