import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';
const DOMAIN = 0x0000;
let abilityName:string = "";
function recordLife(ownList:Array<string>, abilityName:string, lifeName:string) {
  ownList.push(abilityName + ' ' + lifeName);
}
export default class OneAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onCreate');
    AppStorage.setOrCreate<common.UIAbilityContext>("testAbilityContext", this.context);
    globalThis.list1 = [];
    globalThis.parameters = null;
    recordLife(globalThis.list1, abilityName,'OneAbility onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onDestroy');
    recordLife(globalThis.list1, abilityName, 'onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onWindowStageCreate');
    try {
      this.context.windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        hilog.info(DOMAIN, 'testTag', `OneAbility on_windowStageEvent received event:${stageEventType}`);
      });
    } catch (exception) {
      hilog.error(DOMAIN, 'testTag', `on_windowStageEvent failed:${JSON.stringify(exception)}`);
    };
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'OneAbility Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'OneAbility onBackground');
  }
}
