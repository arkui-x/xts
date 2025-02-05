import { webview } from '@kit.ArkWeb';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  handler: FullScreenExitHandler | null = null;
  @State text: string = "";
  build() {

    Column() {

      Back()

      Text(this.text).id('onFullScreenExit');// 使用 @State 变量来显示文本
      Web({ src: 'https://media.w3.org/2010/05/sintel/trailer.mp4', controller: this.controller })
        .onFullScreenExit(() => {
          console.log("onFullScreenExit...");
          this.text = '已退出全屏'; // 更新 @State 变量的值

          if (this.handler) {
            this.handler.exitFullScreen();

          }
        });

    }
  }

}