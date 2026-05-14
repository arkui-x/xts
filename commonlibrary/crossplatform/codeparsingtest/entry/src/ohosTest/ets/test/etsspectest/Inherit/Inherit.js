/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

export function getLiteralObject(obj){
    return obj;
}

export function InheritTest006(){
    const parent = { value: 2, method() { return this.value + 1; } };
    const child = { __proto__: parent };
    return child.method();
}

export function InheritTest007(){
    const parent = { value: 2, method() { return this.value + 1; } };
    const child = { __proto__: parent, value: 4 };
    return child.method();
}

export function InheritTest008(){
    function Box(value) { this.value = value; }
    Box.prototype.getValue = function() { return this.value; };
    const box = new Box(1);
    return box.getValue();
}

export function InheritTest009(){
    function Box(value) { this.value = value; }
    Box.prototype.getValue = function() { return this.value; };
    const box = new Box(1);
    Box.prototype.getValue = function() { return this.value + 1; };
    return box.getValue();
}

export function InheritTest010(){
    class Box { constructor(value) { this.value = value; } getValue() { return this.value; } }
    const box = new Box(3);
    return box.getValue();
}
