// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State getOrigin: string = ''
  @State getAccessibleResource_length: number = 0
  @State getAccessibleResource: string = ''

  build() {
    Column() {
      Button("back")
        .width(200)
        .height(30)
        .onClick(() => {
          router.back()
        })
        .margin(5)
      Text('getOrigin: ' + this.getOrigin)
        .id('getOrigin')
      Text('getAccessibleResource_length: ' + this.getAccessibleResource_length)
        .id('getAccessibleResource_length')
      Text(this.getAccessibleResource)
        .id('getAccessibleResource')
      Web({ src: $rawfile('OnPermissionRequestEvent.html'), controller: this.controller })
        .onPermissionRequest((event:OnPermissionRequestEvent) => {
          this.getOrigin = event.request.getOrigin()
          console.log('getOrigin: ' + event.request.getOrigin())
          this.getAccessibleResource_length = event.request.getAccessibleResource().length
          console.log('getAccessibleResource length: ' + event.request.getAccessibleResource().length)
          for (let i of event.request.getAccessibleResource()) {
            this.getAccessibleResource += i + ' '
            console.log('event.request.getAccessibleResource: ' + i)
          }
          if (event) {
            AlertDialog.show({
              title: 'title',
              message: 'text',
              primaryButton: {
                value: 'deny',
                action: () => {
                  event.request.deny();
                }
              },
              secondaryButton: {
                value: 'onConfirm',
                action: () => {
                  event.request.grant(event.request.getAccessibleResource());
                }
              },
              cancel: () => {
                event.request.deny();
              }
            })
          }
        })
    }
  }
}