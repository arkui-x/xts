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

// Function declaration - square of a number
export function calcSquare(num: number): number {
  if (typeof num !== 'number' || !Number.isFinite(num)) {
    throw new Error('Input must be a finite number');
  }
  return num * num;
}

// Anonymous function expression - add two numbers
export const addTwoNum = function (a: number, b: number): number {
  if (typeof a !== 'number' || typeof b !== 'number') {
    throw new Error('Both inputs must be numbers');
  }
  return a + b;
};

// Named function expression - multiply two numbers
export const mulTwoNum = function mul(a: number, b: number): number {
  if (typeof a !== 'number' || typeof b !== 'number') {
    throw new Error('Both inputs must be numbers');
  }
  return a * b;
};

// Object method - modify object property
export function updateObjProp<T extends object, K extends keyof T>(
  obj: T,
  key: K,
  value: T[K]
): T {
  if (typeof obj !== 'object' || obj === null) {
    throw new Error('First input must be a non-null object');
  }
  obj[key] = value;
  return obj;
}

// Array parameter - add element
export function pushArrElem(arr: number[], val: number): number[] {
  if (!Array.isArray(arr) || typeof val !== 'number') {
    throw new Error('First input must be number array, second must be number');
  }
  arr.push(val);
  return arr;
}

// Function declaration - return fixed number without parameters
export function getFixedNum(): number {
  return 99;
}

// Anonymous function expression - string concatenation
export const strConcat = function (str1: string, str2: string): string {
  if (typeof str1 !== 'string' || typeof str2 !== 'string') {
    throw new Error('Both inputs must be strings');
  }
  return str1 + str2;
};

// Named function expression - factorial calculation
export const numFactorial = function fact(n: number): number {
  if (typeof n !== 'number' || n < 0 || !Number.isInteger(n)) {
    throw new Error('Input must be a non-negative integer');
  }
  return n === 0 || n === 1 ? 1 : n * fact(n - 1);
};


// Function declaration hoisting - call before declaration (factorial)
export function factorialHoisted(n: number): number {
  // Call first (declaration is below, no nested functions)
  const result = hoistedFact(n);

  // Function declaration (independent, not nested)
  function hoistedFact(x: number): number {
    return x === 0 || x === 1 ? 1 : x * hoistedFact(x - 1);
  }

  return result;
}

// Function expression - no hoisting (calling first causes error)
export function checkExprNoHoist(): boolean {
  try {
    // @ts-ignore: Intentionally call undefined expression function
    exprFunc(5);
    return false;
  } catch {
    // Define expression function later (independent, not nested)
    const exprFunc = (x: number): number => x * 2;
    return true;
  }
}

// call method - bind this to object
export function bindThisWithCall(obj: { value: number; getValue: () => number }): number {
  if (typeof obj.getValue !== 'function') {
    throw new Error('Object must have a "getValue" function');
  }
  return obj.getValue.call(obj);
}

// apply method - pass array parameters for summation
export function sumWithApply(arr: number[]): number {
  if (!Array.isArray(arr) || arr.length !== 3) {
    throw new Error('Input must be a 3-element number array');
  }

  // Independent summation function, not nested
  function sum(a: number, b: number, c: number): number {
    return a + b + c;
  }

  return sum.apply(null, arr);
}
