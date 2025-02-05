import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { Back } from '../../components/goBack';

interface  PostMessage{
  postMessage:(data: string)=>void
}
@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  controller1: webview.WebviewController = new webview.WebviewController();
  @State errorMsg:string = "";
  @State currentOffsetY:number = 0;
  build() {
    Column() {
      Back().id("go_back")
      Row(){
        Button('pageDown_false').id("pageDownFalse")
          .onClick(() => {
            try {
              this.controller.pageDown(false);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
        Button('pageDown_true').id("pageDownTrue")
          .onClick(() => {
            try {
              this.controller.pageDown(true);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
      }
      Row(){
        Button('error 17100001').id("pageDown17100001")
          .onClick(() => {
            try {
              this.controller1.pageDown(false);
            } catch (error) {
              this.errorMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
              console.error(this.errorMsg);
            }
          })
        Button('error 401').id("pageDown401")
          .onClick(() => {

            try {
              this.controller.pageDown(undefined);
            } catch (error) {
              this.errorMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
              console.error(this.errorMsg);
            }
          })
      }
      Row(){
        Text(`currentOffsetY:`)
        Text(`${this.currentOffsetY}`).id("currentOffsetY")
      }

      Text(`errorMsg:${this.errorMsg}`).id("errorMsg")

      Web({ src: $rawfile("indexPageDown.html"), controller: this.controller }).id("webId")
        .height(500)
        .javaScriptAccess(true)
        .onScroll((event) => {
           this.currentOffsetY = event.yOffset;
        })
    }
  }
}