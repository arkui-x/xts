import UIAbility from '@ohos.app.ability.UIAbility';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Hypium } from '@ohos/hypium';
import testsuite from '../test/List.test';
import window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import common from '@ohos.app.ability.common';

export default class TestAbility extends UIAbility {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log('TestAbility onCreate');
        console.log('want param:' + JSON.stringify(want) ?? '');
        console.log('launchParam:' + JSON.stringify(launchParam) ?? '');
        AppStorage.setOrCreate('context', this.context);
        let abilityDelegator: AbilityDelegatorRegistry.AbilityDelegator;
        abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
        let abilityDelegatorArguments: AbilityDelegatorRegistry.AbilityDelegatorArgs;
        abilityDelegatorArguments = AbilityDelegatorRegistry.getArguments();
        let parameters = abilityDelegatorArguments.parameters;
        // If the parameters contain a 'socket' field, it means running in socket debug mode; skip XTS test cases.
        if (parameters && parameters.socket) {
            console.log('socket mode enabled, skip run testcase');
            return;
        }
        console.log('start run testcase!!!');
        Hypium.hypiumTest(abilityDelegator, abilityDelegatorArguments, testsuite);
    }

    onDestroy() {
        console.log('TestAbility onDestroy');
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        console.log('TestAbility onWindowStageCreate');
        windowStage.loadContent('testability/pages/Index', (err, data) => {
            if (err.code) {
                console.error('Failed to load the content. Cause: ' + (JSON.stringify(err) ?? ''));
                return;
            }
            console.log('Succeeded in loading the content. Data: ' +
                (JSON.stringify(data) ?? ''));
        });
    }

    onWindowStageDestroy() {
        console.log('TestAbility onWindowStageDestroy');
    }

    onForeground() {
        console.log('TestAbility onForeground');
    }

    onBackground() {
        console.log('TestAbility onBackground');
    }
}
