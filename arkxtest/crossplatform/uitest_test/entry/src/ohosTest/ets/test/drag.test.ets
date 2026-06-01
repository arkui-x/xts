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

import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, afterEach, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, waitForComponentById } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_DragTest';
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const DIAGONAL_DRAG_OFFSET_PX = 10;
const BASIC_DRAG_SPEED = 500;
const HIGH_SPEED_DRAG = 30000;
const MIN_SPEED_FALLBACK_CASE = 100;
const MAX_SPEED_FALLBACK_CASE = 50000;
const INVALID_NEGATIVE_SPEED = -1;
const BAD_PARAMETER_ERROR_CODE = 401;

enum BackButtonBehavior {
  REQUIRED,
  OPTIONAL
}

interface UiBounds {
  left: number;
  right: number;
  top: number;
  bottom: number;
}

interface DragPoint {
  x: number;
  y: number;
}

interface DragTargets {
  dragSource: UiTestComponent;
  dropZone: UiTestComponent;
}

interface DragCenterPoints {
  start: DragPoint;
  end: DragPoint;
  sourceBounds: UiBounds;
  targetBounds: UiBounds;
}

interface DragError extends Error {
  code?: number;
}

interface DragSpeedTestCase {
  speed: number;
  shouldThrow: boolean;
  description: string;
  expectedCode?: number;
}

interface UiTestComponent {
  getText(): Promise<string>;

  click(): Promise<void>;

  inputText(text: string): Promise<void>;

  getBounds(): Promise<UiBounds>;
}

const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

async function createDragDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start dragTest APP success');
  const driver = await Driver.create();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  return driver;
}

function getBoundsCenter(bounds: UiBounds): DragPoint {
  return {
    x: Math.round((bounds.left + bounds.right) / 2),
    y: Math.round((bounds.top + bounds.bottom) / 2)
  };
}

async function getDragTargets(driver: Driver): Promise<DragTargets> {
  const dragSource =
    await waitForComponentById(driver, 'dragSourceText')
  if (!dragSource) {
    throw new Error(TAG + ' not find drag source');
  }
  await sleep(WAIT_PAGE_READY_MS_500);
  const dropZone =
    await waitForComponentById(driver, 'dragDropZone');
  if (!dropZone) {
    throw new Error(TAG + ' not find drop zone');
  }
  await sleep(WAIT_PAGE_READY_MS_500);
  return {
    dragSource,
    dropZone
  };
}

async function getDragCenterPoints(driver: Driver): Promise<DragCenterPoints> {
  const targets = await getDragTargets(driver);
  const sourceBounds = await targets.dragSource.getBounds();
  const targetBounds = await targets.dropZone.getBounds();
  return {
    start: getBoundsCenter(sourceBounds),
    end: getBoundsCenter(targetBounds),
    sourceBounds,
    targetBounds
  };
}

async function ensureIndexPage(driver: Driver): Promise<void> {
  const backButton = await waitForComponentById(driver, 'dragBackButton');
  if (backButton) {
    await backButton.click();
    await sleep(WAIT_PAGE_READY_MS_1000);
  }
}

async function clickDragBackButton(driver: Driver,
  behavior: BackButtonBehavior = BackButtonBehavior.REQUIRED): Promise<void> {
  const waitMs = behavior === BackButtonBehavior.REQUIRED ? WAIT_PAGE_READY_MS_1000 : WAIT_PAGE_READY_MS_500;
  await sleep(waitMs);
  const backButton = await waitForComponentById(driver, 'dragBackButton');
  if (!backButton) {
    if (behavior === BackButtonBehavior.REQUIRED) {
      throw new Error(TAG + ' not find back button');
    }
    return;
  }
  await backButton.click();
}

async function openDragPage(driver: Driver): Promise<void> {
  await ensureIndexPage(driver);
  await sleep(WAIT_PAGE_READY_MS_1000);
  let inButton = await driver.findComponent(ON.id('indexDragNavButton'));
  await sleep(WAIT_PAGE_READY_MS_1000);
  if (!inButton) {
    throw new Error(TAG + ' not find drag button');
  }
  await inButton.click();
  await sleep(WAIT_PAGE_READY_MS_1000);
}

async function verifyDragSuccess(driver: Driver): Promise<void> {
  const dragResult = await waitForComponentById(driver, 'dragResultText');
  if (!dragResult) {
    throw new Error(TAG + ' not find dragResult');
  }
  const dragText = await dragResult.getText();
  await sleep(WAIT_PAGE_READY_MS_500);
  expect(dragText).assertEqual('拖拽成功');
}

function getDragErrorCode(error: Object): number | undefined {
  const dragError = error as DragError;
  return dragError.code;
}

async function assertDragError(action: () => Promise<void>, expectedCode: number, errorLog: string): Promise<void> {
  let errorCode: number | undefined = undefined;
  try {
    await action();
  } catch (error) {
    errorCode = getDragErrorCode(error as Object);
    console.log(`${errorLog}: ${JSON.stringify(error)}`);
  }
  expect(!!errorCode).assertTrue();
  expect(errorCode).assertEqual(expectedCode);
}

async function executeCenteredDrag(driver: Driver, speed: number | null | undefined): Promise<void> {
  const centerPoints = await getDragCenterPoints(driver);
  await driver.drag(centerPoints.start.x, centerPoints.start.y, centerPoints.end.x, centerPoints.end.y, speed);
}

export default function dragTest() {
  describe('dragTest', () => {
    let driver: Driver;
    let bundleName = '';
    let shouldRestartApp = false;

    const runDragCase = async (action: () => Promise<void>): Promise<void> => {
      try {
        await action();
      } catch (error) {
        shouldRestartApp = true;
        if (error instanceof Error) {
          throw error;
        } else {
          throw new Error(typeof error === 'string' ? error : JSON.stringify(error));
        }
      }
    };

    beforeAll(async () => {
      // start app
      hilog.info(0x0000, TAG, 'beforeAll start dragTest APP');
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      hilog.info(0x0000, TAG, `beforeAll bundleName: ${bundleName}`);
      driver = await createDragDriver(bundleName);
    });

    beforeEach(async () => {
      if (!shouldRestartApp) {
        return;
      }
      hilog.info(0x0000, TAG, 'beforeEach restart dragTest APP after previous failure');
      driver = await createDragDriver(bundleName);
      shouldRestartApp = false;
    });

    afterEach(async () => {
      try {
        await clickDragBackButton(driver, BackButtonBehavior.OPTIONAL);
      } catch (error) {
        shouldRestartApp = true;
        console.log(`${TAG} afterEach cleanup ignored: ${JSON.stringify(error)}`);
      }
      await sleep(WAIT_PAGE_READY_MS_1000);
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0100
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0100
     * @tc.desc Basic drag: drag from the center of dragSlider to the center of dropZone and verify success
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      await runDragCase(async () => {
        await openDragPage(driver);
        // Verify the initial state
        let dragResult = await waitForComponentById(driver, 'dragResultText');
        if (!dragResult) {
          throw new Error(TAG + ' not find dragResultText');
        }
        let dragText = await dragResult.getText();
        expect(dragText).assertEqual('未拖拽');

        // Get the coordinates of the drag source and drop target
        const centerPoints = await getDragCenterPoints(driver);
        const sourceBounds = centerPoints.sourceBounds;
        const targetBounds = centerPoints.targetBounds;
        console.log(`${TAG} Source bounds: ${JSON.stringify(sourceBounds)}`);
        console.log(`${TAG} Target bounds: ${JSON.stringify(targetBounds)}`);

        const startX = centerPoints.start.x;
        const startY = centerPoints.start.y;
        const endX = centerPoints.end.x;
        const endY = centerPoints.end.y;

        console.log(`${TAG} Drag from (${startX}, ${startY}) to (${endX}, ${endY})`);
        await driver.drag(startX, startY, endX, endY, BASIC_DRAG_SPEED);
        console.log(TAG + ' Drag operation completed');
        await sleep(WAIT_PAGE_READY_MS_1000);

        // Verify the drag result
        dragResult = await waitForComponentById(driver, 'dragResultText');
        if (!dragResult) {
          throw new Error(TAG + ' not find dragResultText after drag');
        }
        console.log(TAG + ' dragResult 1');
        await sleep(WAIT_PAGE_READY_MS_500);
        await verifyDragSuccess(driver);
        console.log(TAG + 'getText 1');
        await sleep(WAIT_PAGE_READY_MS_500);
        // Verify that the drop zone text also changed
        const dropZoneAfter = await waitForComponentById(driver, 'dragDropZone');
        await sleep(WAIT_PAGE_READY_MS_500);
        if (dropZoneAfter) {
          const dropText = await dropZoneAfter.getText();
          await sleep(WAIT_PAGE_READY_MS_500);
          console.log(TAG + `Drop zone text after drag: ${dropText}`);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0200
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0200
     * @tc.desc Diagonal drag: drag from the upper-left corner of dragSlider to the lower-right corner of dropZone
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runDragCase(async () => {
        await openDragPage(driver);
        let dragResult = await waitForComponentById(driver, 'dragResultText');
        if (!dragResult) {
          throw new Error(TAG + ' not find dragResultText');
        }
        let dragText = await dragResult.getText();
        expect(dragText).assertEqual('未拖拽');

        const targets = await getDragTargets(driver);
        const sourceBounds = await targets.dragSource.getBounds();
        const targetBounds = await targets.dropZone.getBounds();

        // Diagonal drag: use the upper-left corner of the source component as the start point
        // and the lower-right corner of the target component as the end point
        const startX = sourceBounds.left + DIAGONAL_DRAG_OFFSET_PX;
        const startY = sourceBounds.top + DIAGONAL_DRAG_OFFSET_PX;
        const endX = targetBounds.right - DIAGONAL_DRAG_OFFSET_PX;
        const endY = targetBounds.bottom - DIAGONAL_DRAG_OFFSET_PX;

        console.log(`${TAG} Diagonal drag from (${startX}, ${startY}) to (${endX}, ${endY})`);
        await driver.drag(startX, startY, endX, endY, WAIT_PAGE_READY_MS_1000);
        await sleep(WAIT_PAGE_READY_MS_1000);

        await verifyDragSuccess(driver);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0300
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0300
     * @tc.desc drag with high speed (30000 px/s)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runDragCase(async () => {
        await openDragPage(driver);
        const centerPoints = await getDragCenterPoints(driver);
        const startX = centerPoints.start.x;
        const startY = centerPoints.start.y;
        const endX = centerPoints.end.x;
        const endY = centerPoints.end.y;

        await driver.drag(startX, startY, endX, endY, HIGH_SPEED_DRAG);
        await sleep(WAIT_PAGE_READY_MS_1000);

        await verifyDragSuccess(driver);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0400
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0400
     * @tc.desc Special speed values: 100 (should default to 600), 50000 (should default to 600), -1 (should throw error)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runDragCase(async () => {
        const speedTestCases: DragSpeedTestCase[] = [
          {
            speed: MIN_SPEED_FALLBACK_CASE,
            shouldThrow: false,
            description: 'should default to 600'
          },
          {
            speed: MAX_SPEED_FALLBACK_CASE,
            shouldThrow: false,
            description: 'should default to 600'
          },
          {
            speed: INVALID_NEGATIVE_SPEED,
            shouldThrow: true,
            expectedCode: BAD_PARAMETER_ERROR_CODE,
            description: 'should throw 401 error'
          }
        ];

        for (const testCase of speedTestCases) {
          await openDragPage(driver);
          try {
            console.log(`${TAG} Test speed = ${testCase.speed} (${testCase.description})`);
            if (testCase.shouldThrow) {
              await assertDragError(
                async () => {
                  await executeCenteredDrag(driver, testCase.speed);
                  await sleep(WAIT_PAGE_READY_MS_1000);
                },
                testCase.expectedCode ?? BAD_PARAMETER_ERROR_CODE,
                TAG + ' Expected drag invalid speed error'
              );
            } else {
              await executeCenteredDrag(driver, testCase.speed);
              await sleep(WAIT_PAGE_READY_MS_1000);
              await verifyDragSuccess(driver);
            }
          } finally {
            await sleep(WAIT_PAGE_READY_MS_500);
          }
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0500
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0500
     * @tc.desc Drag speed is null/undefined, should use default value 600
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runDragCase(async () => {
        await openDragPage(driver);
        const centerPoints = await getDragCenterPoints(driver);
        const startX = centerPoints.start.x;
        const startY = centerPoints.start.y;
        const endX = centerPoints.end.x;
        const endY = centerPoints.end.y;

        // speed = null
        console.log(TAG + 'Test speed = null (should default to 600)');
        await driver.drag(startX, startY, endX, endY, null);
        await sleep(WAIT_PAGE_READY_MS_1000);
        await verifyDragSuccess(driver);

        await sleep(WAIT_PAGE_READY_MS_500);

        await openDragPage(driver);

        // Get coordinates again
        const centerPoints2 = await getDragCenterPoints(driver);
        const startX2 = centerPoints2.start.x;
        const startY2 = centerPoints2.start.y;
        const endX2 = centerPoints2.end.x;
        const endY2 = centerPoints2.end.y;

        // speed = undefined
        console.log(TAG + 'Test speed = undefined (should default to 600)');
        await driver.drag(startX2, startY2, endX2, endY2, undefined);
        await sleep(WAIT_PAGE_READY_MS_1000);
        await verifyDragSuccess(driver);

        await sleep(WAIT_PAGE_READY_MS_500);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0600
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0600
     * @tc.desc Drag with negative coordinates should throw 401 error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runDragCase(async () => {
        await assertDragError(
          async () => {
            await driver.drag(-1, 100, 200, 300, 600);
          },
          BAD_PARAMETER_ERROR_CODE,
          TAG + ' Expected drag invalid coordinate error'
        );
      });
    });
    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0700
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0700
     * @tc.desc Drag with decimal coordinates should throw 401 error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runDragCase(async () => {
        await assertDragError(
          async () => {
            await driver.drag(100.5, 200, 300, 400, 600);
          },
          BAD_PARAMETER_ERROR_CODE,
          TAG + ' Expected drag invalid coordinate(decimal) error'
        );
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_drag_0800
     * @tc.name ArkUIX_ArkTS_UiTest_drag_0800
     * @tc.desc Drag with decimal speed should throw 401 error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_drag_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runDragCase(async () => {
        await assertDragError(
          async () => {
            await driver.drag(100, 200, 300, 400, 600.5);
          },
          BAD_PARAMETER_ERROR_CODE,
          TAG + ' Expected drag invalid speed(decimal) error'
        );
      });
    });
  })
}
