import { webview } from "@kit.ArkWeb";
import { BusinessError } from "@kit.BasicServicesKit";
import { Back } from '../../components/goBack';

const MULTIPLY_RATE: number = 100;
const MSG_SUCCESS: string = "执行成功";

@Entry
@Component
struct ZoomOut {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private webviewControllerE: webview.WebviewController = new webview.WebviewController();
  private isFirst:boolean = true;
  @State scaleMode: string = "";
  @State scaleValue: string = "";
  @State callMsg: string = "";
  @State zoomAccessV: boolean = false;
  @State showForm: boolean = false;
  @State showFormBtn: boolean = true;
  @State userScale: string = "";
  @State initScale: string = "";
  @State minScale: string = "";
  @State maxScale: string = "";

  handleScaleChange(newScale: number, oldScale: number) {
    if (this.isFirst && newScale <= 100) {
      return;
    }
    this.scaleMode = (newScale - oldScale) > 0 ? "magnify" : "shrink";
    this.scaleValue = `newScale: ${newScale}; oldScale: ${oldScale}`;
    const scaleChange: number = (newScale - oldScale) / oldScale;
    const scaleChangeRate: string = `${(scaleChange * MULTIPLY_RATE).toFixed(0)}%`;
    this.scaleValue =
      `scaleChange: ${scaleChangeRate}`;
  }

  build() {
    Column() {
      Column({ space: 5 }) {
        Back()
        Row() {
          Button("zoomAccess_true")
            .width("48%")
            .id("zoomAccess_true")
            .onClick(() => {
              this.zoomAccessV = true;
              this.callMsg = `zoomAccess_true${MSG_SUCCESS}`;
            })
          Button("zoomAccess_false")
            .width("48%")
            .id("zoomAccess_false")
            .onClick(() => {
              this.zoomAccessV = false;
              this.callMsg = `zoomAccess_false${MSG_SUCCESS}`;
            })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Button("zoomIn")
            .width("48%")
            .id("zoomIn")
            .onClick(() => {
              try {
                this.isFirst = false;
                this.webviewController.zoomIn();
                this.callMsg = `zoomIn${MSG_SUCCESS}`;
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                console.error(this.callMsg);
              }
            })
          Button("zoomOut")
            .width("48%")
            .id("zoomOut")
            .onClick(() => {
              try {
                if (this.isFirst) {
                  this.isFirst = false;
                }
                this.webviewController.zoomOut();
                this.callMsg = `zoomOut${MSG_SUCCESS}`;
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                console.error(this.callMsg);
              }
            })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Button("error 17100001")
            .width("48%")
            .id("error-17100001")
            .onClick(() => {
              try {
                this.webviewControllerE.zoomOut();
                this.callMsg = `zoomOut${MSG_SUCCESS}`;
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                console.error(this.callMsg);
              }
            })
          Button("验证w3c")
            .width("48%")
            .id("w3c")
            .onClick(() => {
              this.showForm = !this.showForm;
            })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        if (this.showForm) {
          Row() {
            TextInput({ text: this.userScale, placeholder: "设置user-scale" })
              .onChange((value) => {
                this.userScale = value;
              })
              .fontSize(14)
              .width("48%")
              .flexGrow(1)
              .id("userScale")

            TextInput({ text: this.initScale, placeholder: "设置init-scale" })
              .onChange((value) => {
                this.initScale = value;
              })
              .fontSize(14)
              .width("48%")
              .flexGrow(1)
              .id("initScale")
          }

          Row({ space: 10 }) {
            TextInput({ text: this.minScale, placeholder: "设置min-scale" })
              .onChange((value) => {
                this.minScale = value;
              })
              .fontSize(14)
              .width("48%")
              .flexGrow(1)
              .id("minScale")

            TextInput({ text: this.maxScale, placeholder: "设置max-scale" })
              .onChange((value) => {
                this.maxScale = value;
              })
              .fontSize(14)
              .width("48%")
              .flexGrow(1)
              .id("maxScale")
          }

          if (this.showFormBtn) {
            Row({ space: 10 }) {
              Button("重置w3c标签").onClick(() => {
                const userScale: string = this.userScale;
                const initScale: string = this.initScale;
                const minScale: string = this.minScale;
                const maxScale: string = this.maxScale;
                this.webviewController.runJavaScript(
                  `open("${userScale}", "${initScale}", "${minScale}", "${maxScale}")`,
                  (error, result) => {
                    if (error) {
                      this.callMsg =
                        `run JavaScript error, ErrorCode: ${(error as BusinessError).code},
                          Message: ${(error as BusinessError).message}`;
                      console.error(`run JavaScript error, ErrorCode: ${(error as BusinessError).code},
                        Message: ${(error as BusinessError).message}`);
                      return;
                    }
                    if (result) {
                      this.callMsg = `The open() return value is: ${result}`;
                      this.showFormBtn = false;
                    }
                  });
              }).id("resetW3c")
            }
          }
        }

        Column({ space: 5 }) {
          Text(`zoomAccess: ${this.zoomAccessV}`).id("zoomAccess")
          Text(`scaleMode: ${this.scaleMode}`).id("scaleMode")
          Text(`scaleValue: ${this.scaleValue}`).id("scaleValue")
          Text(`callMsg: ${this.callMsg}`).id("callMsg")
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")
      }
      .width("90%")
      .margin({ top: 10 })

      if (this.showForm) {
        Web({ src: $rawfile("index2.html"), controller: this.webviewController })
          .onScaleChange((event) => {
            this.handleScaleChange(event.newScale, event.oldScale);
          })
          .zoomAccess(this.zoomAccessV)
          .height(400)
      } else {
        Web({ src: "https://consumer.huawei.com/cn/", controller: this.webviewController })
          .onScaleChange((event) => {
            this.handleScaleChange(event.newScale, event.oldScale);
          })
          .zoomAccess(this.zoomAccessV)
          .height(400)
      }
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f1f3f5");
  }
}