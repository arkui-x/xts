import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { buffer } from '@kit.ArkTS';
import { WebNetErrorList } from '@ohos.web.netErrorList';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  schemeHandler: webview.WebSchemeHandler = new webview.WebSchemeHandler();
  htmlData: string = "<html><body bgcolor=\"white\">Source:<pre>source</pre></body></html>";
  @State RequestUrl: string = '';
  @State RequestMethod: string = '';
  @State isMainFrame: string = '';
  @State hasGesture: string = '';
  @State Header: string = '';

  build() {
    Column() {
      Text(this.RequestUrl)
        .id("RequestUrl")
        .fontSize(10)

      Text(this.RequestMethod)
        .id("RequestMethod")
        .fontSize(10)

      Text(this.isMainFrame)
        .id("isMainFrame")
        .fontSize(10)

      Text(this.hasGesture)
        .id("hasGesture")
        .fontSize(10)

      Text(this.Header)
        .id("Header")
        .fontSize(10)


      Web({ src: 'https://www.example.com', controller: this.controller })
        .onControllerAttached(() => {
          try {
            this.schemeHandler.onRequestStart((request: webview.WebSchemeHandlerRequest,
              resourceHandler: webview.WebResourceHandler) => {
              console.info("[schemeHandler] onRequestStart");
              try {
                this.RequestUrl = request.getRequestUrl()
                this.RequestMethod = request.getRequestMethod()
                this.isMainFrame = JSON.stringify(request.isMainFrame())
                this.hasGesture = JSON.stringify(request.hasGesture())
                this.Header = JSON.stringify(request.getHeader())
                let header = request.getHeader();
                for (let i = 0; i < header.length; i++) {
                  console.info("[WebSchemeHandlerRequest] onRequestStart header:" + header[i].headerKey + " " +
                  header[i].headerValue);
                }
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }

              if (request.getRequestUrl().endsWith("example.com")) {
                return false;
              }

              let response = new webview.WebSchemeHandlerResponse();
              try {
                response.setNetErrorCode(WebNetErrorList.ERR_IO_PENDING);
                response.setStatus(200);
                response.setStatusText("OK");
                response.setMimeType("text/html");
                response.setEncoding("utf-8");
                response.setHeaderByName("header1", "value1", false);
              } catch (error) {
                console.error(`[schemeHandler] ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
              let buf = buffer.from(this.htmlData)
              try {
                if (buf.length == 0) {
                  console.info("[WebSchemeHandlerRequest] length 0");
                  resourceHandler.didReceiveResponse(response);
                  resourceHandler.didFail(WebNetErrorList.ERR_IO_PENDING);
                } else {
                  console.info("[WebSchemeHandlerRequest] length 1");
                  resourceHandler.didReceiveResponse(response);
                  resourceHandler.didReceiveResponseBody(buf.buffer);
                  resourceHandler.didFinish();
                }
              } catch (error) {
                console.error(`[WebSchemeHandlerRequest] ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
              }
              return true;
            })

            this.schemeHandler.onRequestStop((request: webview.WebSchemeHandlerRequest) => {
              console.info("[WebSchemeHandlerRequest] onRequestStop");
            });

            this.controller.setWebSchemeHandler('https', this.schemeHandler);
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
        .onErrorReceive((event) => {
          console.log('getErrorInfo:' + event.error.getErrorInfo());
          console.log('getErrorCode:' + event.error.getErrorCode());
        })
        .javaScriptAccess(true)
        .domStorageAccess(true)
    }
  }
}