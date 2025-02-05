import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State mode: CacheMode = CacheMode.Only;

  build() {
    Column() {
      Back()
      Web({ src: 'https://www.openharmony.cn/mainPlay', controller: this.controller })
        .cacheMode(this.mode)
    }
  }
}