/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import sliderTest from './SliderEnableHapticFeedbackTest.test'
import searchTest from './SearchEnableHapticFeedBack.test'
import textTest from './TextEnableHapticFeedbackTest.test'
import textInputTest from './TextInputEnableHapticFeedbackTest.test'
import textAreaTest from './TextAreaEnableHapticFeedbackTest.test'
import richEditorTest from './RichEditorEnableHapticFeedbackTest.test'
import alphabetIndexerTest from './AlphabetIndexerEnableHapticFeedbackTest.test'
import webTest from './WebEnableHapticFeedbackTest.test'
import uiPickerComponentTest from './UIPickerComponentEnableHapticFeedbackTest.test'
import textPickerTest from './TextPickerEnableHapticFeedbackTest.test'
import timePickerTest from './TimePickerEnableHapticFeedbackTest.test'
import datePickerTest from './DatePickerEnableHapticFeedbackTest.test'
import textPickerDialogTest from './TextPickerDialogEnableHapticFeedback.test'
import timePickerDialogTest from './TimePickerDialogEnableHapticFeedback.test'
import datePickerDialogTest from './DatePickerDialogEnableHapticFeedback.test'
import imageDragTest from './ImageDragEnableHapticFeedbackTest.test'

export default function testsuite() {
  sliderTest()
  searchTest()
  textTest()
  textInputTest()
  textAreaTest()
  richEditorTest()
  alphabetIndexerTest()
  webTest()
  uiPickerComponentTest()
  textPickerTest()
  timePickerTest()
  datePickerTest()
  textPickerDialogTest()
  timePickerDialogTest()
  datePickerDialogTest()
  imageDragTest()
}