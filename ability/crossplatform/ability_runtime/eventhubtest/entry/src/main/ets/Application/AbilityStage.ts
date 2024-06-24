import AbilityStage from '@ohos.app.ability.AbilityStage';

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    console.log('testTag MyAbilityStage onCreate');
    AppStorage.setOrCreate('abilityStageContext', this.context);
  }
}
