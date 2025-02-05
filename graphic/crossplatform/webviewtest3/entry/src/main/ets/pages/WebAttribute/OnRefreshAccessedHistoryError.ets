import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State texts: string = "";
  build() {
    Column() {
      Back()
      Text(`${this.texts}`).id('button')
      Button('refresh').id("refreshs")
        .onClick(() => {
          this.controller.refresh();
        });
      Web({ src: "https://developer.huawei.com/cn/", controller: this.controller })
        .onRefreshAccessedHistory((event) =>                                  {
            console.log("event.isRefreshed"+event.isRefreshed);
        }) .onErrorReceive((event) => {
        if (event) {
          console.log('getErrorInfo:' + event.error.getErrorInfo());
          console.log('getErrorCode:' + event.error.getErrorCode());
          this.texts = 'error = ' + event.error.getErrorInfo() + event.error.getErrorCode();
          console.log("event.isRefreshedgetErrorCode"+event.error.getErrorCode());
        }
        console.log(this.texts);
      })
    }
  }
}