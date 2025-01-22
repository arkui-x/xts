// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  origin: string = "resource://rawfile/";
  @State errMsg: string = ""
  @State originValue: number = -1;

  build() {
    Column() {
      Back()
      Button('getOriginUsage')
        .onClick(() => {
          try {
            webview.WebStorage.getOriginUsage(this.origin, (error, usage) => {
              console.log('deleteOrigin' + usage);
              if (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
                return;
              }
              this.originValue = usage

            })
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Button('deleteOrigin')
        .onClick(() => {
          try {
            webview.WebStorage.deleteOrigin(this.origin);
          } catch (error) {
            this.errMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
            console.error(this.errMsg);
          }
        })
      Button('deleteOrigin 错误入参时')
        .onClick(() => {
          try {
            webview.WebStorage.deleteOrigin("123445");
          } catch (error) {
            this.errMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
            console.error(this.errMsg);
          }
        }).id("btnErr1")
      Button('deleteOrigin 401')
        .onClick(() => {
          try {
            webview.WebStorage.deleteOrigin(undefined);
          } catch (error) {
            this.errMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
            console.error(this.errMsg);
          }
        })
      Text(`${this.errMsg}`).id("TEXT1")
      Text(`usage: ${this.originValue}`).id("originValue");
      Web({ src: $rawfile('webStorage.html'), controller: this.controller })
    }
  }
}