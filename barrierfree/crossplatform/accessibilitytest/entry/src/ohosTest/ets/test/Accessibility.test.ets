/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';
import accessibility from '@ohos.accessibility';
import { BusinessError } from '@kit.BasicServicesKit';

const WAIT_MS_500 = 500;
const WAIT_MS_1000 = 1000;
const WAIT_MS_2000 = 2000;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function accessibilityTest() {
  describe('AccessibilityTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_2000);
    });
    beforeEach(async () => {
      await sleep(WAIT_MS_500);
    });

    /**
     * @tc.number ArkUIX_Accessibility_isOpenAccessibilitySync_0100
     * @tc.name ArkUIX_Accessibility_isOpenAccessibilitySync_0100
     * @tc.desc Test the accessibility interface isOpenAccessibilitySync
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_isOpenAccessibilitySync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let isOpenAccessibilitySync = accessibility.isOpenAccessibilitySync();
          expect(isOpenAccessibilitySync === true || isOpenAccessibilitySync === false).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_isOpenTouchGuideSync_0100
     * @tc.name ArkUIX_Accessibility_isOpenTouchGuideSync_0100
     * @tc.desc Test the accessibility interface isOpenTouchGuideSync
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_isOpenTouchGuideSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let isOpenTouchGuideSync = accessibility.isOpenTouchGuideSync();
          expect(isOpenTouchGuideSync === true || isOpenTouchGuideSync === false).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_isScreenReaderOpenSync_0100
     * @tc.name ArkUIX_Accessibility_isScreenReaderOpenSync_0100
     * @tc.desc Test the accessibility interface isScreenReaderOpenSync
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_isScreenReaderOpenSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let isScreenReaderOpenSync = accessibility.isScreenReaderOpenSync();
          expect(isScreenReaderOpenSync === true || isScreenReaderOpenSync === false).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getTouchModeSync_0100
     * @tc.name ArkUIX_Accessibility_getTouchModeSync_0100
     * @tc.desc Test the accessibility interface getTouchModeSync
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getTouchModeSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let touchMode = accessibility.getTouchModeSync();
          expect(touchMode === "singleTouchMode" || touchMode === "doubleTouchMode" || touchMode === "none")
            .assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0100
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0100
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          await accessibility.sendAccessibilityEvent(eventInfo).then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(isPass).assertTrue();

          eventInfo.type = 'announceForAccessibility';
          await accessibility.sendAccessibilityEvent(eventInfo).then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0200
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0200
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'abcde',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          await accessibility.sendAccessibilityEvent(eventInfo).then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0300
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0300
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'abcde'
          });

          await accessibility.sendAccessibilityEvent(eventInfo).then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0400
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0400
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          accessibility.sendAccessibilityEvent(eventInfo, (err: BusinessError) => {
            if (err) {
              isPass = false;
            } else {
              isPass = true;
            }
          });
          await sleep(WAIT_MS_1000);
          expect(isPass).assertTrue();

          eventInfo.type = 'announceForAccessibility';
          accessibility.sendAccessibilityEvent(eventInfo, (err: BusinessError) => {
            if (err) {
              isPass = false;
            } else {
              isPass = true;
            }
          });
          await sleep(WAIT_MS_1000);
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0500
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0500
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'abcde',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          accessibility.sendAccessibilityEvent(eventInfo, (err: BusinessError) => {
            if (err) {
              isPass = false;
            } else {
              isPass = true;
            }
          });
          await sleep(WAIT_MS_1000);
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0600
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0600
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'abcde'
          });

          accessibility.sendAccessibilityEvent(eventInfo, (err: BusinessError) => {
            if (err) {
              isPass = false;
            } else {
              isPass = true;
            }
          });
          await sleep(WAIT_MS_1000);
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0700
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0700
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          accessibility.sendAccessibilityEvent(eventInfo, null);
          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_sendAccessibilityEvent_0800
     * @tc.name ArkUIX_Accessibility_sendAccessibilityEvent_0800
     * @tc.desc Test the accessibility interface sendAccessibilityEvent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Accessibility_sendAccessibilityEvent_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let isPass = false;
        try {
          let eventInfo: accessibility.EventInfo = ({
            type: 'requestFocusForAccessibility',
            bundleName: 'com.example.accessibilitytest',
            triggerAction: 'accessibilityFocus',
            customId: 'Text'
          });

          accessibility.sendAccessibilityEvent(eventInfo, undefined);
          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_accessibilityStateChange_0100
     * @tc.name ArkUIX_Accessibility_accessibilityStateChange_0100
     * @tc.desc Test the accessibility interface accessibilityStateChange
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_accessibilityStateChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let isPass = false;
        let callbackdata = (data: boolean) => { }
        try {
          accessibility.on('accessibilityStateChange', callbackdata);
          accessibility.off('accessibilityStateChange', callbackdata);

          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_touchGuideStateChange_0100
     * @tc.name ArkUIX_Accessibility_touchGuideStateChange_0100
     * @tc.desc Test the accessibility interface touchGuideStateChange
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_touchGuideStateChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let isPass = false;
        let callbackdata = (data: boolean) => { }
        try {
          accessibility.on('touchGuideStateChange', callbackdata);
          accessibility.off('touchGuideStateChange', callbackdata);

          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_screenReaderStateChange_0100
     * @tc.name ArkUIX_Accessibility_screenReaderStateChange_0100
     * @tc.desc Test the accessibility interface screenReaderStateChange
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_screenReaderStateChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let isPass = false;
        let callbackdata = (data: boolean) => { }
        try {
          accessibility.on('screenReaderStateChange', callbackdata);
          accessibility.off('screenReaderStateChange', callbackdata);

          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_touchModeChange_0100
     * @tc.name ArkUIX_Accessibility_touchModeChange_0100
     * @tc.desc Test the accessibility interface touchModeChange
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_touchModeChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let isPass = false;
        let callbackdata = (data: string) => { }
        try {
          accessibility.on('touchModeChange', callbackdata);
          accessibility.off('touchModeChange', callbackdata);

          await sleep(WAIT_MS_1000);
          isPass = true;
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0100
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0100
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let abilityType: accessibility.AbilityType[] = ['audible', 'generic', 'haptic', 'spoken', 'visual', 'all'];
        let accessibilityAbilityInfo: accessibility.AccessibilityAbilityInfo[];
        try {
          for (let index = 0; index < abilityType.length; index++) {
            accessibilityAbilityInfo = accessibility.getAccessibilityExtensionListSync(abilityType[index], 'enable');
            expect(accessibilityAbilityInfo.length).assertLargerOrEqual(0);
            if (accessibilityAbilityInfo.length) {
              for (let index2 = 0; index2 < accessibilityAbilityInfo.length; index2++) {
                expect(accessibilityAbilityInfo[index2].id).not().assertUndefined();
                expect(accessibilityAbilityInfo[index2].name).not().assertUndefined();
                expect(accessibilityAbilityInfo[index2].bundleName).not().assertUndefined();
              }
            }
          }
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0200
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0200
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let stateType: accessibility.AbilityState[] = ['enable', 'disable', 'install'];
        let accessibilityAbilityInfo: accessibility.AccessibilityAbilityInfo[];
        try {
          for (let index = 0; index < stateType.length; index++) {
            accessibilityAbilityInfo = accessibility.getAccessibilityExtensionListSync('audible', stateType[index]);
            expect(accessibilityAbilityInfo.length).assertLargerOrEqual(0);
            if (accessibilityAbilityInfo.length) {
              for (let index2 = 0; index2 < accessibilityAbilityInfo.length; index2++) {
                expect(accessibilityAbilityInfo[index2].id).not().assertUndefined();
                expect(accessibilityAbilityInfo[index2].name).not().assertUndefined();
                expect(accessibilityAbilityInfo[index2].bundleName).not().assertUndefined();
              }
            }
          }
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0300
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0300
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let abilityType: accessibility.AbilityType[] = ['audible', 'generic', 'haptic', 'spoken', 'visual', 'all'];
        let isPass = false;
        try {
          for (let index = 0; index < abilityType.length; index++) {
            await accessibility.getAccessibilityExtensionList(abilityType[index], 'enable')
              .then((data: accessibility.AccessibilityAbilityInfo[]) => {
                isPass = true;
                expect(data.length).assertLargerOrEqual(0);
                if (data.length) {
                  for (let index2 = 0; index2 < data.length; index2++) {
                    expect(data[index2].id).not().assertUndefined();
                    expect(data[index2].name).not().assertUndefined();
                    expect(data[index2].bundleName).not().assertUndefined();
                  }
                }
            }).catch((err: BusinessError) => {
              expect().assertFail();
            });
          }
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0400
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0400
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let stateType: accessibility.AbilityState[] = ['enable', 'disable', 'install'];
        let isPass = false;
        try {
          for (let index = 0; index < stateType.length; index++) {
            await accessibility.getAccessibilityExtensionList('audible', stateType[index])
              .then((data: accessibility.AccessibilityAbilityInfo[]) => {
                isPass = true;
                expect(data.length).assertLargerOrEqual(0);
                if (data.length) {
                  for (let index2 = 0; index2 < data.length; index2++) {
                    expect(data[index2].id).not().assertUndefined();
                    expect(data[index2].name).not().assertUndefined();
                    expect(data[index2].bundleName).not().assertUndefined();
                  }
                }
            }).catch((err: BusinessError) => {
              expect().assertFail();
            });
          }
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0500
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0500
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let abilityType: accessibility.AbilityType[] = ['audible', 'generic', 'haptic', 'spoken', 'visual', 'all'];
        let isPass = false;
        try {
          for (let index = 0; index < abilityType.length; index++) {
            accessibility.getAccessibilityExtensionList(abilityType[index], 'enable',
              (err: BusinessError, data: accessibility.AccessibilityAbilityInfo[]) => {
              if (!err) {
                isPass = true;
                expect(data.length).assertLargerOrEqual(0);
                if (data.length) {
                  for (let index2 = 0; index2 < data.length; index2++) {
                    expect(data[index2].id).not().assertUndefined();
                    expect(data[index2].name).not().assertUndefined();
                    expect(data[index2].bundleName).not().assertUndefined();
                  }
                }
              }
            });
            await sleep(WAIT_MS_1000);
          }
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_Accessibility_getAccessibilityExtensionList_0600
     * @tc.name ArkUIX_Accessibility_getAccessibilityExtensionList_0600
     * @tc.desc Test the accessibility interface getAccessibilityExtensionList
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Accessibility_getAccessibilityExtensionList_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform === "iOS") {
          done();
          return;
        }

        let stateType: accessibility.AbilityState[] = ['enable', 'disable', 'install'];
        let isPass = false;
        try {
          for (let index = 0; index < stateType.length; index++) {
            accessibility.getAccessibilityExtensionList('audible', stateType[index],
              (err: BusinessError, data: accessibility.AccessibilityAbilityInfo[]) => {
                if (!err) {
                  isPass = true;
                  expect(data.length).assertLargerOrEqual(0);
                  if (data.length) {
                    for (let index2 = 0; index2 < data.length; index2++) {
                      expect(data[index2].id).not().assertUndefined();
                      expect(data[index2].name).not().assertUndefined();
                      expect(data[index2].bundleName).not().assertUndefined();
                    }
                  }
                }
              });
            await sleep(WAIT_MS_1000);
          }
          expect(isPass).assertTrue();
        } catch (error) {
          expect().assertFail();
        }
        done();
      });
  })
}