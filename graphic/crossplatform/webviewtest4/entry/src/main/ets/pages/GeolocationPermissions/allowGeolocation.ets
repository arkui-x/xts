import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { URLUtils } from '../../utils/urlUtil';

@Entry
@Component
struct AllowGeolocation {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private controller: TextInputController = new TextInputController();
  @State origin: string = 'https://developer.huawei.com/';
  @State errOrigin: string = '123456';
  @State callMsg: string = '默认';

  aboutToDisappear(): void {
    webview.GeolocationPermissions.deleteAllGeolocation(true);
    webview.GeolocationPermissions.deleteAllGeolocation(false);
  }

  build() {
    Column({ space: 5 }) {
      Column({ space: 5 }) {
        Row({ space: 10 }) {
          Button('返回').onClick(() => {
            router.back()
          })
          Text('allowGeolocation')
            .fontWeight(FontWeight.Bolder)
            .fontSize(15)
        }
        .width('100%')

        TextInput({ text: this.origin, placeholder: 'input origin', controller: this.controller })
          .onChange((value: string) => {
            if (URLUtils.validateURL(value)) {
              this.origin = value;
              this.callMsg = '当前origin为有效源';
            } else {
              this.callMsg = '当前origin为无效源';
              this.origin = '';
            }
          })

        Button('allowG incognito is true')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.allowGeolocation(this.origin, true);
              this.callMsg = 'allowG incognito is true 执行成功';
            } catch (error) {
              this.callMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          }).id('allowGTrue')
        Button('allowG incognito is false')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.allowGeolocation(this.origin, false);
              this.callMsg = 'allowG incognito is false 执行成功';
            } catch (error) {
              this.callMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          }).id('allowGFalse')
        Button('allowG incognito is default')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.allowGeolocation(this.origin);
              this.callMsg = 'allowG incognito is default 执行成功';
            } catch (error) {
              this.callMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`
            }
          }).id('allowGDefault')

        Row() {
          Button('error 17100011')
            .width('48%')
            .onClick(() => {
              try {
                webview.GeolocationPermissions.allowGeolocation(this.errOrigin);
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
              }
            }).id('error11')
          Button('error 401')
            .width('48%')
            .onClick(() => {
              try {
                webview.GeolocationPermissions.allowGeolocation(null);
              } catch (error) {
                this.callMsg =
                  `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
              }
            }).id('error401')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 5 }) {
          Text(`origin: ${this.origin}`)
          Text(`操作信息: ${this.callMsg}`)
            .height(80)
            .id('message')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .width('90%')
      .margin({ top: 10 })

      Web({ src: 'https://developer.huawei.com/consumer/cn/', controller: this.webviewController })
        .height(300)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
  }
}