import common from '@ohos.app.ability.common';
import router from '@ohos.router';

@Entry
@Component
struct EnterPage {
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Row() {
      Scroll() {
        Column() {
          Text('')
            .fontSize(30)
            .width('100%')
            .height(80)
            .fontColor("#ff0a34d0")
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .margin({ top: 20 })
          Column() {
            Text('window Test')
              .fontSize(25)
              .fontColor("#ff0a34d0")
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
            Text('Arkui MainAbility' + '\n' + '根页面')
              .fontSize(25)
              .fontColor("#ff0a34d0")
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .margin({ top: 20 })
            Button("前往 Arkui EntryAbility 页面")
              .id('toEntryAbility')
              .width('100%')
              .height(55)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20 })
              .onClick(() => {
                // this.context.startAbility({
                //   deviceId: '',
                //   bundleName: "com.example.windowsubsystem",
                //   abilityName: "EntryAbility",
                //   moduleName: "entry"
                // }).then(() => {
                //   console.info('Succeeded in starting ability.');
                // })
                router.pushUrl({url:"pages/Index"})
              })
          }
        }
        .width('100%')
      }
    }
    .height('100%').backgroundColor(Color.Pink)
  }
}