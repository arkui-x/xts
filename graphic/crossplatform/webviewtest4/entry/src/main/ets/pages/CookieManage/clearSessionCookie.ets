import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct ClearSessionCookie {
  @State message: BusinessError = {
    code: 0,
    name: '',
    message: ''
  };
  controller: webview.WebviewController = new webview.WebviewController();
  @State clearSessionCookieResult: string = "还未执行";
  @State cookies: string = "fetchCookie cookies"

  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  build() {
    Row() {
      Column() {
        Back()
        Button('ClearSessionCookie').id("ClearSessionCookieId")
          .onClick(() => {
            try {
              webview.WebCookieManager.clearSessionCookie((error) => {
                this.clearSessionCookieResult = "已经清除完毕";
                if (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
                }
              })
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);

            }
          })
        Button('捕获错误401').id("getError")
          .onClick(() => {
            try {
              webview.WebCookieManager.clearSessionCookie(undefined)
            } catch (error) {
              this.message = error
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
        Text(this.cookies).fontColor('red')
          .id('TextId')
        Text(`${this.clearSessionCookieResult}`).id("clearSessionCookie_Text");
        Text(`ErrorCode:${this.message.code}`).id("clearSessionCookie_errorCode");
        Text(`ErrorMessage:${this.message.message}`);

        Web({ src: 'https://developer.huawei.com/', controller: this.controller })
      }
      .width('100%')
    }
    .height('100%')
  }
}