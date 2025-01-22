import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct IncognitoModeFalse {
  controller: webview.WebviewController = new webview.WebviewController();

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
      Web({
        src: 'https://developer.huawei.com/consumer/cn/?ha_source=sem&ha_sourceId=89000605',
        controller: this.controller,
        incognitoMode: false
      })
    }
  }
}