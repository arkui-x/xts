import { MyTabContent } from '../beans/MyTabContent'

const HTMLControl: MyTabContent = new MyTabContent('HTMLControl', 'index_controller.html', '')
const ACCESS_STEP_TAB_CONTENT: MyTabContent = new MyTabContent('accessStep', 'index_page_visible.html', '')
const PAGE_OPERATION_TAB: MyTabContent = new MyTabContent('operation', 'https://www.example.com', '')
const LOAD: MyTabContent = new MyTabContent('load', 'index_page_visible.html', 'notLoad')

const MY_TAB_CONTENTS: MyTabContent[] = [
  HTMLControl,
  ACCESS_STEP_TAB_CONTENT,
  PAGE_OPERATION_TAB,
  LOAD
]

export default MY_TAB_CONTENTS