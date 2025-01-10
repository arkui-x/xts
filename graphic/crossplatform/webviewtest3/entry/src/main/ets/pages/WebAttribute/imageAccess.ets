import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI'

interface DATASOURCE {
  title:string,
  path:string
}

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  DataSources:Array<DATASOURCE>=[
    {
      title:"imageAccess true",
      path:"pages/WebAttribute/imageAccessTrue"
    },
    {
      title:"imageAccess false",
      path:"pages/WebAttribute/imageAccessFalse"
    },
  ]

  goPage(item: DATASOURCE) {
    router.pushUrl({
      url: item.path
    })
  }

  build() {
    Column() {
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.DataSources, (item: DATASOURCE) => {
          ListItem() {
            Text(item.title)
              .width('100%')
              .height(100)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0xFFFFFF)
          }.onClick(() => this.goPage(item))
        }, (item: DATASOURCE) => item.title)
      }
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      .friction(0.6)
      .divider({
        strokeWidth: 2,
        color: 0xFFFFFF,
        startMargin: 20,
        endMargin: 20
      }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
      .width("90%")
    }
    .height('100%')
    .width("100%")
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}