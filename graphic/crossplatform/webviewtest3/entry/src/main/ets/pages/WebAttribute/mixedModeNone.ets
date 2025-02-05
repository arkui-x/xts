import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State mode: MixedMode = MixedMode.None;

  build() {
    Column() {
      Back()
      Web({ src: 'https://mixed-script.badssl.com/', controller: this.controller })
        .mixedMode(this.mode).padding({ bottom: "100px" })
    }.height("100%")
  }
}