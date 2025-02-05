import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';

let context = getContext(this) as common.UIAbilityContext;
let atManager = abilityAccessCtrl.createAtManager();

// 向用户请求位置权限设置。
atManager.requestPermissionsFromUser(context, ["ohos.permission.APPROXIMATELY_LOCATION"]).then((data) => {
  console.info('data:' + JSON.stringify(data));
  console.info('data permissions:' + data.permissions);
  console.info('data authResults:' + data.authResults);
}).catch((error: BusinessError) => {
  console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
})

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State webResult: string = '';

  build() {
    Column() {
      Back()
      Text(this.webResult).fontSize(20).id("geolocationFalse")
      Web({ src: "https://www.amap.com/", controller: this.controller })
        .geolocationAccess(false)
        .onGeolocationShow((event) => { // 地理位置权限申请通知
          event.geolocation.invoke(event.origin, false, false); // 允许此站点地理位置权限请求
        })
    }
  }
}