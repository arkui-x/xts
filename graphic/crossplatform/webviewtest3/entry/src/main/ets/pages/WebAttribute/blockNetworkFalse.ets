import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Back()
      Web({ src: 'https://developer.huawei.com/consumer/cn/', controller: this.controller })
        .blockNetwork(false)
    }
  }
}