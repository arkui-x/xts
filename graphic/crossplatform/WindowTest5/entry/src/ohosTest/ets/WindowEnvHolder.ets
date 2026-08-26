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

import { window } from '@kit.ArkUI';

export class WindowEnvHolder {
  private static sVp: window.SizeInVP | null = null;
  private static sPx: window.Size | null = null;
  private static aVp: window.UIEnvWindowAvoidAreaInfoVP | null = null;
  private static aPx: window.UIEnvWindowAvoidAreaInfoPX | null = null;

  static setValues(
    sVp: window.SizeInVP,
    sPx: window.Size,
    aVp: window.UIEnvWindowAvoidAreaInfoVP,
    aPx: window.UIEnvWindowAvoidAreaInfoPX
  ) {
    WindowEnvHolder.sVp = sVp;
    WindowEnvHolder.sPx = sPx;
    WindowEnvHolder.aVp = aVp;
    WindowEnvHolder.aPx = aPx;
  }

  static getSizeVP(): window.SizeInVP | null { return WindowEnvHolder.sVp; }
  static getSizePX(): window.Size | null { return WindowEnvHolder.sPx; }
  static getAvoidAreaVP(): window.UIEnvWindowAvoidAreaInfoVP | null { return WindowEnvHolder.aVp; }
  static getAvoidAreaPX(): window.UIEnvWindowAvoidAreaInfoPX | null { return WindowEnvHolder.aPx; }
}