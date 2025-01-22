import { DATASOURCES, TypeSources } from '../dataSources/dataSources'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State DataSources: Array<DATASOURCES> = TypeSources
  @State text: string = ""

  goPage(item: DATASOURCES) {
    router.pushUrl({
      url: item.path
    })
  }

  build() {
    Scroll() {
      Column() {

        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.DataSources, (item: DATASOURCES) => {
            ListItem() {
              Text(item.title)
                .width('100%')
                .height(100)
                .fontSize(16)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }.onClick(() => this.goPage(item))
          }, (item: DATASOURCES) => item.title)
        }
        .listDirection(Axis.Vertical)
        .scrollBar(BarState.Off)
        .friction(0.6)
        .divider({
          strokeWidth: 2,
          color: 0xFFFFFF,
          startMargin: 20,
          endMargin: 20
        })
        .edgeEffect(EdgeEffect.Spring)
        .width("90%")
      }
      .height('100%')
      .width("100%")
      .backgroundColor(0xDCDCDC)
      .padding({ top: 5 })
    }

  }
}