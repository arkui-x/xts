import { webview } from '@kit.ArkWeb';
import { sleep } from '../../../../ohosTest/ets/utils';
import { Back } from '../../components/goBack';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  handler: FullScreenExitHandler | null = null;
  @State widths: number | undefined = 0;
  @State heights: number | undefined = 0;
  @State texts: string = "";
  build() {
    Column() {
      Back()
      Text(`宽度=${this.widths},高度=${this.heights}`)
        .id('onRefreshAccessedHistory_text');
      Text(this.texts).id("onFullScreenEnter") ;// 使用 @State 变量来显示文本
      Web({ src: "https://media.w3.org/2010/05/sintel/trailer.mp4", controller: this.controller })
        .onFullScreenEnter((event) => {
          this.widths = event.videoWidth;
          this.heights = event.videoHeight;
          console.log("onFullScreenEnter videoWidth: " + event.videoWidth +
            ", videoHeight: " + event.videoHeight);
          this.texts = '已进入全屏'; // 更新 @State 变量的值
          console.log('xxxxxxxxxxxxxxx',`宽度=${this.widths},高度=${this.heights}`.length)
          this.handler = event.handler;
          setTimeout(() => {
            event.handler.exitFullScreen();
          }, 2000)
        })
    }
  }
}