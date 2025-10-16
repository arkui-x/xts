/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { reg } from './commonParam';
import { buffer } from '@kit.ArkTS';

function convertToUint8Array(str: string) {
  const match = str.match(reg);
  let temp: number[] = [];
  if (match) {
    temp = match.map((h) => {
      return Number("0x" + h);
    });
  }
  return new Uint8Array(
    temp
  );
}
function compareString(a: string, b: string): boolean {
  let buf1 = buffer.from(a);
  let buf2 = buffer.from(b);
  if (buf1.compare(buf2, 0, b.length, 0, a.length) == 0) {
    return true;
  } else {
    return false;
  }
}

function compareUint8Array(a: Uint8Array, b: Uint8Array): boolean {
  let buf1 = buffer.from(a);
  let buf2 = buffer.from(b);
  if (buf1.compare(buf2, 0, b.length, 0, a.length) == 0) {
    return true;
  } else {
    return false;
  }
}
//input stream convert to string
function uInt8ArrayToString(fileData: Uint8Array) {
  let dataString = "";
  for (let i = 0; i < fileData.length; i++) {
    dataString += String.fromCharCode(fileData[i]);
  }
  return dataString;
}


//string convert to input stream
function stringTouInt8Array(str: string): Uint8Array {
  if (str.length == 0) {
    console.error("stringTouInt8Array length is 0");
  }
  let arr: number[] = [];
  for (let i = 0, j = str.length; i < j; ++i) {
    arr.push(str.charCodeAt(i));
  }
  let tmpUint8Array = new Uint8Array(arr);
  return tmpUint8Array;
}

export {
  compareString,
  compareUint8Array,
  convertToUint8Array,
  stringTouInt8Array,
  uInt8ArrayToString
}