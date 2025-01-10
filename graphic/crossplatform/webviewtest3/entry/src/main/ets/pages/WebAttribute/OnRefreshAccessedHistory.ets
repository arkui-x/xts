import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State text: string = "";
  build() {
    Column() {
      Back()
      Text(`${this.text}`).id('refreshs');
      Button('refresh').id('refresh')
        .onClick(() => {
          this.controller.refresh();
        });
      Web({ src: "https://developer.huawei.com/cn/", controller: this.controller })
        .onRefreshAccessedHistory((event) =>                                  {
          this.text = 'url =' + event.url + ' isReload=' + event.isRefreshed;
          console.log("event.isRefreshed"+event.isRefreshed);
        }) .onErrorReceive((event) => {
        if (event) {
          console.log('getErrorInfo:' + event.error.getErrorInfo());
          console.log('getErrorCode:' + event.error.getErrorCode());
          console.log("event.isRefreshedgetErrorCode"+event.error.getErrorCode());
        }
        console.log(this.text);
      })
    }
  }
}