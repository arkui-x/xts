/******/ (() => { // webpackBootstrap
var __webpack_exports__ = {};
/*!************************************************************************************************************!*\
  !*** C:\Users\jwzhang\Desktop\ActsAceEtsTest\entry\src\main\ets\MainAbility\pages\systemRouterB.ets?entry ***!
  \************************************************************************************************************/
// @ts-nocheck
/**
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
var router = globalThis.requireNativeModule('system.router');
class SystemRouterB extends View {
    constructor(compilerAssignedUniqueChildId, parent, params) {
        super(compilerAssignedUniqueChildId, parent);
        this.updateWithValueParams(params);
    }
    updateWithValueParams(params) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id());
    }
    render() {
        Flex.create({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center });
        Flex.width('100%');
        Flex.height('100%');
        Text.create('B Page');
        Text.fontSize(50);
        Text.fontWeight(FontWeight.Bold);
        Text.pop();
        Flex.pop();
    }
    onPageShow() {
        let params = router.getParams();
        if (params && params.data) {
            console.info("[SystemRouterB] getParams result: " + params.data);
            this.getRouterParams(params.data);
        }
    }
    getRouterParams(data) {
        try {
            let paramsData = {
                data: {
                    "params": data,
                }
            };
            let paramsEvent = {
                eventId: 211,
            };
            console.info("[SystemRouterB] start to emit params");
        }
        catch (err) {
            console.info("[SystemRouterB] emit params err: " + JSON.stringify(err.message));
        }
    }
}
loadDocument(new SystemRouterB("1", undefined, {}));

/******/ })()
;
//# sourceMappingURL=systemRouterB.js.map