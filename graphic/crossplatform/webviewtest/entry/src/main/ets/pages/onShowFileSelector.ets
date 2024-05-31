import MyTabContents from '../datasource/TabContentData'
import { MyTabContent } from '../beans/MyTabContent';
import { WebContent } from '../components/Web';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  private tabs: MyTabContent[] = MyTabContents;
  private currentTab: MyTabContent = MyTabContents[5]

  @Styles
  commonStyle() {
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {
      Text(this.currentTab.tabBarName)
      Column() {
        WebContent({ htmlName: this.currentTab.htmlName, funcName: this.currentTab.funcName })
      }
      .height('85%')
      .width('100%')

      Column() {
        Button('设置页签')
          .onClick(async e => {
            const buttons: promptAction.Button[] = this.tabs.map((item: MyTabContent) => {
              const button: promptAction.Button = {
                text: `Goto ${item.tabBarName}`,
                color: '#333333'
              }
              return button
            })
            const type: promptAction.ShowDialogSuccessResponse = await promptAction.showDialog({
              title: '请选择跳转的页签',
              buttons: buttons
            })
            const index: number = type.index
            const url: string = 'pages/' + this.tabs[index].tabBarName
            router.pushUrl({ url: url })
          })
          .size({ height: 20 })
      }
      .height('10%')
      .width('100%')
    }
    .commonStyle()
    .padding({
      top: 30
    })
  }
}