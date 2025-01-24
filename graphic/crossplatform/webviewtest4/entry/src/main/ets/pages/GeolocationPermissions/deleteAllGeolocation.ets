import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { URLUtils } from '../../utils/urlUtil';

@Entry
@Component
struct DeleteAllGeolocation {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  private controller: TextInputController = new TextInputController();
  @State origin: string = 'https://developer.huawei.com/';
  @State callMsg: string = '默认';
  @State getAccessibleResult: string = '默认';
  @State getStoredGeolocation: string = '默认';

  aboutToDisappear(): void {
    webview.GeolocationPermissions.deleteAllGeolocation(true);
    webview.GeolocationPermissions.deleteAllGeolocation(false);
  }

  error(error: BusinessError) {
    this.getStoredGeolocation = '';
    this.callMsg = `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
  }

  build() {
    Column({ space: 5 }) {
      Column({ space: 5 }) {
        Row({ space: 10 }) {
          Button('返回').onClick(() => {
            router.back()
          })
          Text('deleteAllGeolocation')
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
              this.getStoredGeolocation = '';
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
              this.getStoredGeolocation = '';
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

        Button('getStoredG incognito is true')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getStoredGeolocation((error, origins) => {
                if (error) {
                  this.error(error);
                  return;
                }
                this.getStoredGeolocation = origins.join();
                this.callMsg = 'getStoredG incognito is true 执行成功';
              }, true);
            } catch (error) {
              this.error(error);
            }
          }).id('getStoredGTrue')

        Button('getStoredG incognito is false')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getStoredGeolocation((error, origins) => {
                if (error) {
                  this.error(error);
                  return;
                }
                this.getStoredGeolocation = origins.join();
                this.callMsg = 'getStoredG incognito is false 执行成功';
              }, false);
            } catch (error) {
              this.error(error);
            }
          }).id('getStoredGFalse')

        Button('deleteAllG incognito is true')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.deleteAllGeolocation(true);
              this.getAccessibleResult = '';
              this.getStoredGeolocation = '';
              this.callMsg = 'deleteAllG incognito is true 执行成功';
            } catch (error) {
              this.error(error);
            }
          }).id('deleteAllGTrue')
        Button('deleteAllG incognito is false')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.deleteAllGeolocation(false);
              this.getAccessibleResult = '';
              this.getStoredGeolocation = '';
              this.callMsg = 'deleteAllG incognito is false 执行成功';
            } catch (error) {
              this.error(error);
            }
          }).id('deleteAllGFalse')
        Button('deleteAllG incognito is default')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.deleteAllGeolocation();
              this.getAccessibleResult = '';
              this.getStoredGeolocation = '';
              this.callMsg = 'deleteAllG incognito is default 执行成功';
            } catch (error) {
              this.error(error);
            }
          }).id('deleteAllGDefault')

        Column({ space: 5 }) {
          Text(`origin: ${this.origin}`)
          Text(`getAccessibleResult: ${this.getAccessibleResult}`).id('AccessibleResult')
          Text(`getStoredGeolocation: ${this.getStoredGeolocation}`).id('StoredGeolocation')
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