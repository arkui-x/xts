import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import { AbilityConstant } from '@kit.AbilityKit';
import Want from '@ohos.app.ability.Want';

export default class Main3Ability extends UIAbility {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log('testTag', '%{public}s', 'Ability onCreate');
        globalThis.want = want;
    }

    onDestroy() {
        console.log('testTag', '%{public}s', 'Ability onDestroy');
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log('testTag', '%{public}s', 'Ability onWindowStageCreate');

        windowStage.loadContent('pages/Main3', (err, data) => {
            if (err.code) {
                console.log('testTag', '%{public}s', 'Ability onWindowStageCreate');
                return;
            }
            console.log('testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log('testTag', '%{public}s', 'Ability onWindowStageDestroy');
    }

    onForeground() {
        // Ability has brought to foreground
        console.log('testTag', '%{public}s', 'Ability onForeground');
    }

    onBackground() {
        // Ability has back to background
        console.log('testTag', '%{public}s', 'Ability onBackground');
    }
}
