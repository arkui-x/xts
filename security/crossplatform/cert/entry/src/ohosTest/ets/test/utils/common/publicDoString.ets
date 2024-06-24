//字节流转成可理解的字符串
function uInt8ArrayToString(fileData: number[]) {
  let dataString: string = "";
  for (let i: number = 0; i < fileData.length; i++) {
    dataString += String.fromCharCode(fileData[i]);
  }
  return dataString;
}

//可理解的字符串转成自字节流
function stringTouInt8Array(str: string) {
  if (str.length == 0) {
    console.error("stringTouInt8Array length is 0");
  }
  let arr: number[] = [];
  for (let i: number = 0, j: number = str.length; i < j; ++i) {
    arr.push(str.charCodeAt(i));
  }
  let tmpUint8Array: Uint8Array = new Uint8Array(arr);
  return tmpUint8Array;
}

export {
  uInt8ArrayToString,
  stringTouInt8Array,
};
