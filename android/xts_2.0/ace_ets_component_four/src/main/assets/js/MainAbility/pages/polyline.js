/******/ (() => { // webpackBootstrap
var __webpack_exports__ = {};
/*!*******************************************************************************************************!*\
  !*** C:\Users\jwzhang\Desktop\ActsAceEtsTest\entry\src\main\ets\MainAbility\pages\polyline.ets?entry ***!
  \*******************************************************************************************************/
class PolylineExample extends View {
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
        Column.create({ space: 5 });
        Column.margin({ top: 5 });
        Flex.create({ justifyContent: FlexAlign.SpaceAround });
        Flex.width('100%');
        Polyline.create({ width: 100, height: 100 });
        Polyline.points([[0, 0], [20, 60], [100, 100]]);
        Polyline.key('polyline');
        Polyline.create();
        Polyline.width(100);
        Polyline.height(100);
        Polyline.points([[0, 0], [0, 100], [100, 100]]);
        Flex.pop();
        Column.pop();
    }
}
loadDocument(new PolylineExample("1", undefined, {}));

/******/ })()
;
//# sourceMappingURL=polyline.js.map