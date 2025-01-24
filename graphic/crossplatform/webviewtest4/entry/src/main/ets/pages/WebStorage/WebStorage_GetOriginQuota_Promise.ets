// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  origin: string = "resource://rawfile/";
  @State originValue: number = -200;
  @State errorMessage: BusinessError = {
    code: 0,
    name: '',
    message: ''
  };

  build() {
    Column() {
      Back()
      Button('getOriginQuota')
        .onClick(() => {
          try {
            webview.WebStorage.getOriginQuota(this.origin)
              .then(quota => {
                console.log('quota: ' + quota);
                this.originValue = quota;
              })
              .catch((e: BusinessError) => {
                console.log('error: ' + JSON.stringify(e));
              })
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Button('捕获错误401')
        .onClick(() => {
          try {
            webview.WebStorage.getOriginQuota(undefined)
              .then(quota => {
                console.log('quota: ' + quota);
                this.originValue = quota;
              })
              .catch((e: BusinessError) => {
                console.log('error: ' + JSON.stringify(e));
              })
          } catch (error) {
            this.errorMessage = error
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Text(`quota：${this.originValue}`).id("originValue");
      Text(`ErrorCode：${this.errorMessage.code}`).id("errorCode");
      Text(`ErrorMessage：${this.errorMessage.message}`);
      Web({ src: $rawfile('webStorage.html'), controller: this.controller })
    }
  }
}