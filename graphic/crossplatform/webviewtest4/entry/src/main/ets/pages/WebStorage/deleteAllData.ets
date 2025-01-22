import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  origin: string = "resource://rawfile/";
  @State str: number = 0;

  build() {
    Column() {
      Back()
      Button('getOriginUsage')
        .onClick(() => {
          try {
            webview.WebStorage.getOriginUsage(this.origin)
              .then(usage => {
                console.log('deleteAllData: ' + usage);
                this.str = usage;
              }).catch((e: BusinessError) => {
              console.error('error: ' + JSON.stringify(e));
            })
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Button('deleteAllData')
        .onClick(() => {
          try {
            webview.WebStorage.deleteAllData();
            console.log("deleteAllData1111111111111111");
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code}, Message: ${(error as BusinessError).message}`);
            console.log("deleteAllData222222222222222222");
          }
        })
      Text(`${this.str}`).id("TEXT");
      Web({ src: $rawfile('webStorage.html'), controller: this.controller })
    }
  }
}
