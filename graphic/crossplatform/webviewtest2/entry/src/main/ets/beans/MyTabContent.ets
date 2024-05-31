export class MyTabContent {
  tabBarName: string // 页签名
  htmlName: string // 文件名，包含文件类型
  funcName: string // 需要执行的方法名

  constructor(tabBarName: string, htmlName: string, funcName: string) {
    this.tabBarName = tabBarName
    this.htmlName = htmlName
    this.funcName = funcName
  }
}