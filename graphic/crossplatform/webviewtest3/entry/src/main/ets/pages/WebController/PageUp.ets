import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

@Entry
@Component
struct PageUp {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private webviewControllerE: webview.WebviewController = new webview.WebviewController();
  @State currentOffsetY: number = 0;
  @State pageUpMode: string = "默认";
  @State callMsg: string = "默认";

  build() {
    Column({ space: 5 }) {
      Column({ space: 5 }) {
        Back()
        Row() {
          Button("scrollPage")
            .id("pageUp_scrollTo")
            .onClick(() => {
              this.webviewController.scrollTo(0, 1800);
            })
            .width("100%")
        }

        Row() {
          Button("pageUp_true")
            .id("pageUp_true")
            .onClick(() => {
              try {
                this.webviewController.pageUp(true);
                this.pageUpMode = "pageUp_true";
                this.callMsg = "pageUp_true执行成功";
              } catch (error) {
                console.error(`ErrorCode:
                  ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
            .width("48%")
          Button("pageUp_false")
            .id("pageUp_false")
            .onClick(() => {
              try {
                this.webviewController.pageUp(false);
                this.pageUpMode = "pageUp_false";
                this.callMsg = "pageUp_false执行成功";
              } catch (error) {
                console.error(`ErrorCode:
                  ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
            })
            .width("48%")
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Button("error 17100001")
            .onClick(() => {
              try {
                this.webviewControllerE.pageUp(false);
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
              }
            })
            .width("48%").id("17100001")

          Button("error 401")
            .onClick(() => {
              try {
                this.webviewController.pageUp(undefined);
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
              }
            })
            .width("48%").id("401")
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 5 }) {
          Text(`currentOffsetY: ${this.currentOffsetY}`).id("MY_VALUE_SCROLL")
          Text(`pageUpMode: ${this.pageUpMode}`).id("MY_VALUE_SCROLL_type")
          Text(`callMsg: ${this.callMsg}`).id("callMsg")
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")
      }
      .width("90%")
      .margin({ top: 10 })

      Web({ src: "https://developer.huawei.com/consumer/cn/", controller: this.webviewController })
        .height(400)
        .onScroll((event) => {
          this.currentOffsetY = event.yOffset;
        });
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f3f5");
  }
}