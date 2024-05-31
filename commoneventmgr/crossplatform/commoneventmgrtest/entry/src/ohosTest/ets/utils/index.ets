import CommonEventManager from '@ohos.commonEventManager';
import { expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';

/**
 * Thread sleeps
 */
export function sleep (ms: number = 1000): Promise<void> {
  return new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}
/**
 * publish Events Without Parameters
 * @param event
 * @param done
 */
export function publishEventWithoutOpt(event: string,  done: Function):void {
  try {
    CommonEventManager.publish(event, (error: BusinessError) => {
      console.log(`PUBLISH ${event} SUCCESS`);
    })
  } catch (error) {
    console.log(`PUBLISH ${event} FAILED`);
    expect(false).assertTrue();
    done();
  }
}
/**
 * publish Events With Parameters
 * @param event
 * @param PUBLISH_OPT_DATA
 * @param done
 */
export function publishEvent(event: string, PUBLISH_OPT_DATA: CommonEventManager.CommonEventPublishData, done: Function):void {
  try {
    CommonEventManager.publish(event, PUBLISH_OPT_DATA, (error: BusinessError) => {
      console.log(`PUBLISH ${event} SUCCESS`);
    })
  } catch (error) {
    console.log(`PUBLISH ${event} FAILED`);
    expect(false).assertTrue();
    done();
  }
}