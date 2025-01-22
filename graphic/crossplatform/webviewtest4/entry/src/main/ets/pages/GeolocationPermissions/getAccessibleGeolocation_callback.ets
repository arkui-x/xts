import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { URLUtils } from '../../utils/urlUtil';

@Entry
@Component
struct GetAccessibleGeolocationCallback {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private controller: TextInputController = new TextInputController();
  @State origin: string = 'https://developer.huawei.com/';
  @State errOrigin: string = '123456';
  @State callMsg: string = '默认';
  @State getAccessibleResult: string = '默认';

  aboutToDisappear(): void {
    webview.GeolocationPermissions.deleteAllGeolocation(true);
    webview.GeolocationPermissions.deleteAllGeolocation(false);
  }

  error(error: BusinessError) {
    this.getAccessibleResult = '';
    this.callMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
  }

  build() {
    Column({ space: 5 }) {
      Column({ space: 5 }) {
        Row({ space: 10 }) {
          Button('返回').onClick(() => {
            router.back()
          })
          Text('getAccessibleGeolocation_callback')
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
              this.getAccessibleResult = '';
              this.callMsg = 'allowG incognito is true 执行成功';
            } catch (error) {
              this.error(error);
            }
          }).id('allowGTrue')
        Button('allowG incognito is false')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.allowGeolocation(this.origin, false);
              this.getAccessibleResult = '';
              this.callMsg = 'allowG incognito is false 执行成功';
            } catch (error) {
              this.error(error);
            }
          }).id('allowGFalse')

        Button('getAccessibleG incognito is true')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getAccessibleGeolocation(this.origin, (error, result) => {
                if (error) {
                  this.error(error);
                  return;
                }
                this.getAccessibleResult = result.toString();
                this.callMsg = 'getAccessibleG incognito is true 执行成功';
              }, true);
            } catch (error) {
              this.error(error);
            }
          }).id('getAccessibleGTrue')
        Button('getAccessibleG incognito is false')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getAccessibleGeolocation(this.origin, (error, result) => {
                if (error) {
                  this.error(error);
                  return;
                }
                this.getAccessibleResult = result.toString();
                this.callMsg = 'getAccessibleG incognito is false 执行成功';
              }, false);
            } catch (error) {
              this.error(error);
            }
          }).id('getAccessibleGFalse')
        Button('getAccessibleG incognito is default')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getAccessibleGeolocation(this.origin, (error, result) => {
                if (error) {
                  this.error(error);
                  return;
                }
                this.getAccessibleResult = result.toString();
                this.callMsg = 'getAccessibleG incognito is default 执行成功';
              });
            } catch (error) {
              this.error(error);
            }
          }).id('getAccessibleGDefault')

        Row() {
          Button('error 17100011')
            .width('48%')
            .onClick(() => {
              try {
                webview.GeolocationPermissions.getAccessibleGeolocation(this.errOrigin, (error, result) => {
                  if (error) {
                    this.error(error);
                    return;
                  }
                  this.getAccessibleResult = result.toString();
                  this.callMsg = 'error 17100011 执行成功';
                }, false);
              } catch (error) {
                this.error(error);
              }
            }).id('error11')
          Button('error 401')
            .width('48%')
            .onClick(() => {
              try {
                webview.GeolocationPermissions.getAccessibleGeolocation(null);
              } catch (error) {
                this.error(error);
              }
            })
            .id('error401')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 5 }) {
          Text(`origin: ${this.origin}`)
          Text(`getAccessibleResult: ${this.getAccessibleResult}`).id('AccessibleResult')
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
