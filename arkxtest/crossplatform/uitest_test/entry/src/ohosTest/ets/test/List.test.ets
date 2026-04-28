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

import dragTest from './drag.test'
import waitForComponentTest from './waitForComponent.test'
import screenCaptureTest from './screenCapture.test'
import isComponentPresentWhenLongClick from './isComponentPresentWhenLongClick.test'
import setDisplayRotationTest from './setDisplayRotation.test'
import getDisplaySizeTest from './getDisplaySize.test'
import waitForIdleTest from './waitForIdle.test'

export default function testsuite() {
    dragTest()
    waitForComponentTest()
    screenCaptureTest()
    isComponentPresentWhenLongClick()
    setDisplayRotationTest()
    getDisplaySizeTest()
    waitForIdleTest()
}