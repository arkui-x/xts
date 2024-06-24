@Entry
@Component
struct GetBoundsFullPage {

  build() {
    Column() {
      Image($r('sys.media.ohos_ic_public_camera'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Contain)
        .backgroundColor(0x66FFCC)
        .id('cameraImage')

    }
    .width('100%')
    .height('100%')
  }
}