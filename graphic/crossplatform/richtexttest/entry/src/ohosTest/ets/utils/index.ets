import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { BusinessError } from '@ohos.base'

export const waitUiReadyMs: number = 1000;

export const sleep: (delay?: number) => Promise<void> = (delay: number = 1000): Promise<void> => {
  return new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve()
    }, delay)
  })
}

interface want {
  bundleName: string,
  abilityName: string,
  moduleName: string
}

const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

export const startAbility: (bundleName: string, abilityName: string) => Promise<void> = async (bundleName: string, abilityName: string) => {
  let want: want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then((result: void) => {
    console.info(`WebViewTestCase, start abilityFinished: ${result}`)
  }).catch((err: BusinessError) => {
    console.error(`WebViewTestCase, start abilityFailed: ${err}`)
  })
}
