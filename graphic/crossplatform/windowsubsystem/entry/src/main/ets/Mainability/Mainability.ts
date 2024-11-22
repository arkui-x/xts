import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';

export default class MainAbility extends UIAbility {
  onCreate(want, launchParam) {
    console.log('testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    console.log('testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    console.log('testTag', '%{public}s', 'Ability onWindowStageCreate');


    windowStage.loadContent('pages/Main', (err, data) => {
      if (err.code) {
        console.log('testTag', '%{public}s', 'Ability onWindowStageCreate');
        return;
      }
      console.log('testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');

    });

    try {
      let windowMainAbility = windowStage.getMainWindowSync();
      AppStorage.setOrCreate('windowMainAbility', windowMainAbility)
    } catch (exception) {
      console.error('Failed to obtain the main windowMainAbility. Cause: ' + JSON.stringify(exception));
    }
  }

  onWindowStageDestroy() {
    console.log('testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    console.log('testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    console.log('testTag', '%{public}s', 'Ability onBackground');
  }
}
