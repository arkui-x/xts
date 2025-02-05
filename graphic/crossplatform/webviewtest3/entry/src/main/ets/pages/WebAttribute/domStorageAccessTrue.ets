import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State webResult: string = '';

  build() {
    Column() {
      Back()
      Text(this.webResult).fontSize(20).id("domStorageAccessTrue")
      Web({ src: $rawfile("domApi.html"), controller: this.controller })
        .domStorageAccess(true)
        .javaScriptAccess(true)
        .onPageEnd(e => {
          try {
            this.controller.runJavaScript(
              'getDomResult()',
              (error, result) => {
                if (error) {
                  console.error(`run JavaScript error, ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
                  return;
                }
                if (result) {
                  this.webResult = `localStorage: ${result}`;
                  console.info(`The test() return value is: ${result}`);
                }
              });
            if (e) {
              console.info('url: ', e.url);
            }
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
    }
  }
}