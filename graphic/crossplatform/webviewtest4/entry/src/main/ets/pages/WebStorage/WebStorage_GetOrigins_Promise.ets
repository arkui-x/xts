// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State errorMessage: BusinessError = {
    code: 0,
    name: '',
    message: ''
  };
  @State origin: string = "";
  @State usage: number = 0;
  @State quota: number = 0;
  @State isSuccess: boolean = false;
  @State textString: string = '';

  build() {
    Column() {
      Back()
      Button('getOrigins有数据')
        .onClick(() => {
          try {
            webview.WebStorage.getOrigins()
              .then(origins => {
                this.isSuccess = true;
                console.log(`getOrigins --- ${JSON.stringify(origins)}`);
                for (let i = 0; i < origins.length; i++) {
                  this.origin = origins[i].origin;
                  this.usage = origins[i].usage;
                  this.quota = origins[i].quota;
                }
              })
              .catch((e: BusinessError) => {
                this.isSuccess = false;
                this.errorMessage = e;
                console.log('error: ' + JSON.stringify(e));
              })
          } catch (error) {
            this.isSuccess = false;
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            this.errorMessage = error;
          }
        })
      if (this.isSuccess) {
        Text(`SuccessOrigin：${this.origin}`).id('successOrigin');
        Text(`SuccessUsage：${this.usage}`);
        Text(`SuccessQuota：${this.quota}`);
      } else {
        Text(`ErrorCode：${this.errorMessage.code}`).id("errorCode");
        Text(`ErrorMessage：${this.errorMessage.message}`);
      }
      Web({ src: $rawfile('webStorage.html'), controller: this.controller })
    }
  }
}