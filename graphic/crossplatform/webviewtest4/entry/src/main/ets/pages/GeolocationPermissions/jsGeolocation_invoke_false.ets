import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { checkPlatformUtil } from '../../utils/checkPlatformUtils';

let context = getContext(this) as common.UIAbilityContext;
let atManager = abilityAccessCtrl.createAtManager();

// Request location permission settings from the user.
atManager.requestPermissionsFromUser(context, ['ohos.permission.APPROXIMATELY_LOCATION'])
  .then((data) => {
    console.info('data:' + JSON.stringify(data));
    console.info('data permissions:' + data.permissions);
    console.info('data authResults:' + data.authResults);
  })
  .catch((error: BusinessError) => {
    console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
  })

@Entry
@Component
struct JsGeolocationFalse {
  controller: webview.WebviewController = new webview.WebviewController();
  private currentMode: boolean = false;
  private geolocationMode: boolean = false;
  @State origin: string = '';
  @State allowValue: boolean = true;
  @State tipMsg: string = '默认';
  @State origins_str: string = "";
  @State result: string = "";

  aboutToAppear(): void {
    this.origin = checkPlatformUtil.checkPlatform();
  }

  aboutToDisappear(): void {
    webview.GeolocationPermissions.deleteAllGeolocation(false);
  }

  build() {
    Column({ space: 5 }) {
      Web({ src: $rawfile('jsGeolocation.html'), controller: this.controller, incognitoMode: this.currentMode })
        .height(300)
        .geolocationAccess(true)
        .onGeolocationShow((event) => {
          AlertDialog.show({
            title: '位置权限请求',
            message: '是否允许获取位置信息',
            primaryButton: {
              value: 'cancel',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, false, false);
                }
              }
            },
            secondaryButton: {
              value: 'ok ',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, this.allowValue, true);
                  this.origin = event.origin;
                }
              }
            },
            cancel: () => {
              if (event) {
                event.geolocation.invoke(event.origin, false, false);
              }
            }
          })
        })

      Column({ space: 5 }) {
        Row({ space: 5 }) {
          Button('allow true')
            .width('48%')
            .onClick(() => {
              this.allowValue = true;
            })
          Button('allow false')
            .width('48%')
            .onClick(() => {
              this.allowValue = false;
            })
        }
        .width('100%')

        Button('allowGeolocation')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.allowGeolocation(this.origin, this.geolocationMode);
              this.tipMsg = 'allowGeolocation 执行成功';
            } catch (error) {
              this.tipMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          }).id('allowGeolocation')

        Button('getAccessibleGeolocation')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getAccessibleGeolocation(this.origin, this.geolocationMode)
                .then(result => {
                  this.result = result.toString();
                  this.tipMsg = 'getAccessibleGeolocation 执行成功';
                })
                .catch((error: BusinessError) => {
                  this.result = '';
                  this.origins_str = '';
                  this.tipMsg =
                    `getAccessibleGeolocationPromise error, ErrorCode: ${error.code},  Message: ${error.message}`;
                });
            } catch (error) {
              this.tipMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          }).id('getAccessibleGeolocation')

        Button('getStoredGeolocation')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.getStoredGeolocation(this.geolocationMode)
                .then(origins => {
                  let origins_str: string = origins.join();
                  this.origins_str = origins_str;
                  this.tipMsg = 'getStoredGeolocation 执行成功';
                })
                .catch((error: BusinessError) => {
                  this.tipMsg =
                    `getStoredGeolocationPromise error, ErrorCode: ${error.code},  Message: ${error.message}`;
                });
            } catch (error) {
              this.tipMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          }).id('getStoredGeolocation')

        Button('deleteAllGeolocation')
          .width('100%')
          .onClick(() => {
            try {
              webview.GeolocationPermissions.deleteAllGeolocation(this.geolocationMode);
              this.result = '';
              this.origins_str = '';
              this.tipMsg = 'deleteAllGeolocation 执行成功';
            } catch (error) {
              this.tipMsg =
                `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
            }
          })

        Column({ space: 5 }) {
          Text(`当前webView模式: ${(this.currentMode)}`)
          Text(`指定源的字符串索引(origin): ${(this.origin)}`)
          Text(`设置的地理位置权限状态(allow)：${(this.allowValue)}`)
          Text(`${(this.origin)} 的地理位置权限状态: ${(this.result)}`)
          Text(`获取的origins: ${(this.origins_str)}`)
          Text(`操作信息: ${(this.tipMsg)}`)
            .id('tipMsg')
            .height(100)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .width('90%')
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
  }
}