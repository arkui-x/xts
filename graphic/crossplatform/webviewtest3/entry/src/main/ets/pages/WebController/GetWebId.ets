import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct GetWebId {
  @State errorMessage: BusinessError= {
    code: 0,
    name: '',
    message: ''
  };
  controller: webview.WebviewController = new webview.WebviewController();
  controller2: webview.WebviewController = new webview.WebviewController();
  @State webId: number = -1;

  build() {
    Row() {
      Column() {
        Back()
        Button('getWebId').id("getWebId")
          .onClick(() => {
            try {
              this.webId = this.controller.getWebId();
              console.log("id: " + this.webId);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
        Button('捕获错误17100001').id("getError")
          .onClick(() => {
            try {
             this.controller2.getWebId();

            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              this.errorMessage = error as BusinessError;
            }
          })
        Text(`${this.webId}`).id("webId_value")
        Text(`错误码：${this.errorMessage.code}`).id("errorCode")
        Text(`错误信息：${this.errorMessage.message}`)
        Web({ src: 'https://developer.huawei.com/', controller: this.controller })
      }
      .width('100%')
    }
    .height('100%')
  }
}