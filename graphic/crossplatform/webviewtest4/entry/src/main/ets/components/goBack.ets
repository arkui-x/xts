import { router } from '@kit.ArkUI'

@Component
export  struct Back {
  @Prop title:string
back(){
  router.back()
}
  build() {
   Row(){
     Button("返回")
       .onClick(()=>this.back())
       .margin({left:5})
       .height(25)
     Row(){
       Text(this.title)
         .width("100%")
         .textAlign(TextAlign.Center)
     }
   }.padding({
     top:5,
     bottom:5
   })
    .alignItems(VerticalAlign.Center)

  }
}