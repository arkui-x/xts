import { MyTabContent } from '../beans/MyTabContent'

const ALERT_TAB_CONTENT: MyTabContent = new MyTabContent('onAlert', 'index_alert.html', 'my_alert')
const CONFIRM_TAB_CONTENT: MyTabContent = new MyTabContent('onConfirm', 'index_confirm.html', 'my_confirm')
const PROMPT_TAB_CONTENT: MyTabContent = new MyTabContent('onPrompt', 'index_prompt.html', 'my_prompt')
const HTTP_TAB_CONTENT: MyTabContent = new MyTabContent('onHttpAuthRequest', 'https://www.spincast.org/demos-tutorials/http-authentication/protected', '')
// const GEOLOCATION_TAB_CONTENT: MyTabContent = new MyTabContent('onGeolocationShow', 'index_geolocation.html', 'my_getLocation')
const FILE_SELECTOR_TAB_CONTENT: MyTabContent = new MyTabContent('onShowFileSelector', 'index_file_selector.html', 'readFile')
const PERMISSION_REQ_TAB_CONTENT: MyTabContent = new MyTabContent('onPermissionRequest', 'index_permission_req.html', 'getMedia')
const PAGE_VISIBLE_TAB_CONTENT: MyTabContent = new MyTabContent('onPageVisible', 'index_page_visible.html', 'page_alert')
const DOWNLOAD_TAB_CONTENT: MyTabContent = new MyTabContent('onDownloadStart', 'index_download.html', 'my_download')
const VIDEO: MyTabContent = new MyTabContent('playVideo', 'index_video.html', 'getStatus')
const HTTP_ERROR: MyTabContent = new MyTabContent('onHttpErrorReceive', 'https://www.huawei.com/cn/sss', '')
const MESSAGE: MyTabContent = new MyTabContent('WebMessagePort', 'index_message.html', 'PostMsgToEts')

const MY_TAB_CONTENTS: MyTabContent[] = [
  ALERT_TAB_CONTENT,
  CONFIRM_TAB_CONTENT,
  PROMPT_TAB_CONTENT,
  HTTP_TAB_CONTENT,
  HTTP_ERROR,
  // GEOLOCATION_TAB_CONTENT,
  FILE_SELECTOR_TAB_CONTENT,
  PERMISSION_REQ_TAB_CONTENT,
  PAGE_VISIBLE_TAB_CONTENT,
  DOWNLOAD_TAB_CONTENT,
  VIDEO,
  MESSAGE
]

export default MY_TAB_CONTENTS