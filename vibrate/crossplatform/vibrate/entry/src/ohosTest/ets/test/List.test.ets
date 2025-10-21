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

import Vibrator_star_normal from './vibrate_star_and_stop/Vibrator_star_normal.test'
import Vibrator_star_noparam from './vibrate_star_and_stop/Vibrator_star_noparam.test'
import testStopVibration from './vibrate_star_and_stop/Vibrate_stop_Test.test'
import vibrate_isSupportEffectSync_Test from './vibrate_isSupportEffect/vibrate_isSupportEffectSync_Test.test';
import vibrate_isSupportEffect_Test from './vibrate_isSupportEffect/vibrate_isSupportEffect_Test.test';
import vibrate_getEffectInfoSync from './vibrate_getVibInfoSync/vibrate_getEffectInfoSync.test';
import vibrate_getVibratorInfoSync from './vibrate_getVibInfoSync/vibrate_getVibratorInfoSync.test';
import Vibtate_PatternBuilder from './vibtate_PatternBuilder/Vibtate_PatternBuilder.test';
import Vibrator_isHdHapticSupported from './vibtate_PatternBuilder/Vibrator_isHdHapticSupported.test';
// import vibrator_nop_Test from './miscdevice_standard_nop/Vibrator_nop_Test.test';

export default function testsuite() {
  Vibrator_star_normal();
  Vibrator_star_noparam();
  testStopVibration();
  vibrate_isSupportEffect_Test();
  vibrate_isSupportEffectSync_Test();
  vibrate_getEffectInfoSync();
  vibrate_getVibratorInfoSync();
  Vibtate_PatternBuilder();
  Vibrator_isHdHapticSupported();
  // vibrator_nop_Test()
}