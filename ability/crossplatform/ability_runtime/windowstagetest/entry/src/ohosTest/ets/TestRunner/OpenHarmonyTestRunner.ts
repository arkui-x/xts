

import TestRunner from '@ohos.application.testRunner';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

var abilityDelegator = undefined
var abilityDelegatorArguments = undefined

async function onAbilityCreateCallback() {
  console.log('onAbilityCreateCallback');
}

async function addAbilityMonitorCallback(err: any) {
  console.log('addAbilityMonitorCallback');
}

export default class OpenHarmonyTestRunner implements TestRunner {
  constructor() {
  }

  onPrepare() {
    console.log('onPrepare');
  }

  async onRun() {
    console.log('onRun');
    abilityDelegatorArguments = AbilityDelegatorRegistry.getArguments()
    abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator()
    var bundleName = abilityDelegatorArguments.bundleName
    var parameters = abilityDelegatorArguments.parameters
    let moduleName = parameters["moduleName"]
    let lMonitor = {
      abilityName: "TestAbility",
      onAbilityCreate: onAbilityCreateCallback,
    };
    abilityDelegator.addAbilityMonitor(lMonitor, addAbilityMonitorCallback)
    let want = {
      abilityName: "TestAbility",
      bundleName: bundleName,
      moduleName: moduleName
    };
    abilityDelegator.startAbility(want, (err: any, data: any) => {
      console.log('startAbility' + err + data);
    });
  }
}