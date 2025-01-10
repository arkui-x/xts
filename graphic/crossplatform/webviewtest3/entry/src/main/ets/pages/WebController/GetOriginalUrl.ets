import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct PageUp {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private webviewControllerE: webview.WebviewController = new webview.WebviewController();
  @State originalUrl: string = "";
  @State currentUrl: string = "";
  @State callMsg: string = "";
  @State changeValue: string = "";
  @State inputUrl: string = "https://www.baidu.com/";

  build() {
    Column({ space: 5 }) {
      Column({ space: 5 }) {
        Back()
        Flex() {
          TextInput({ text: this.inputUrl, placeholder: "请输入url" }).id("inputUrl")
          Button("加载").onClick(() => {
            this.webviewController.loadUrl(this.inputUrl);
          }).id("loadUrl").width("120")
        }

        Button("getOriginalUrl")
          .id("getOriginalUrl")
          .onClick(() => {
            try {
              this.originalUrl = this.webviewController.getOriginalUrl();
              this.currentUrl = this.webviewController.getUrl();
              this.callMsg = "getOriginalUrl执行成功";
            } catch (error) {
              console.error(`ErrorCode:
                ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
          .width("100%")
        Button("error 17100001")
          .onClick(() => {
            try {
              this.webviewControllerE.getOriginalUrl();
            } catch (error) {
              this.callMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
              console.error(this.callMsg);
            }
          }).id("17100001")
          .width("100%")
        Column({ space: 5 }) {
          Text(`originalURL： ${this.originalUrl}`).id("getOriginalUrl_before")
          Text(`currentURL：  ${this.currentUrl}`).id("getOriginalUrl_after")
          Text(`callMsg: ${this.callMsg}`).id("callMsg")
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")
      }
      .width("90%")
      .margin({ top: 10 })

      Web({ src: "https://developer.huawei.com/consumer/cn/", controller: this.webviewController })
        .height(400)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f3f5");
  }
}