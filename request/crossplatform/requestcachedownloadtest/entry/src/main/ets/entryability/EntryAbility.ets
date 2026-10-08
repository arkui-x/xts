import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    console.log('Ability onCreate');
  }

  onDestroy() {
    console.log('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    console.log('Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load the content. Cause: ' + (JSON.stringify(err) ?? ''));
        return;
      }
      console.log('Succeeded in loading the content. Data: ' + (JSON.stringify(data) ?? ''));
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    console.log('Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    console.log('Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    console.log('Ability onBackground');
  }
}
