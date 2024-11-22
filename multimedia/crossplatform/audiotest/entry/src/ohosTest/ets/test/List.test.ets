/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import audioRendererTest from './AudioRenderer.test'
import audioRenderer_CreateTest from './AudioRenderer_Create.test'
import audioCapturerTest from './AudioCapturer.test'
import audioCapturer_CreateTest from './AudioCapturer_Create.test'
import audioManagerTest from './AudioManager.test'
import audioVolumeManagerTest from './AudioVolumeManager.test'
import audioStreamManagerTest from './AudioStreamManager.test'
import audioRoutingManagerTest from './AudioRoutingManager.test'

export default function testsuite() {
   audioStreamManagerTest()
   audioRendererTest()
   audioCapturerTest()
   audioCapturer_CreateTest()
   audioVolumeManagerTest()
   audioRoutingManagerTest()
   audioRenderer_CreateTest()
   audioManagerTest()
}