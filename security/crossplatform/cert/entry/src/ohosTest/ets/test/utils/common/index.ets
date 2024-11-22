import certFramework from '@ohos.security.cert';
import {
  chainFirstCaCert,
  chainSecondCaCert,
  selfSignedCaCertPem,
  selfSignedCaCertDer,
  testErrorCert,
  testCert,
  testCrlPem,
  testRevokedCrlPem,
  testCrlDer,
} from "./publicParam";
import { stringTouInt8Array } from "./publicDoString";

function getEncodingBlob(certType: string) {
  let certFormat: certFramework.EncodingFormat;
  let encodingData: Uint8Array;
  if (certType == "der") {
    certFormat = certFramework.EncodingFormat.FORMAT_DER;
    encodingData = new Uint8Array(
      (selfSignedCaCertDer.match(new RegExp('[\\da-f]{2}', 'ig')) as string[]).map((h) => {
        return parseInt(h, 16);
      })
    );
  } else {
    certFormat = certFramework.EncodingFormat.FORMAT_PEM;
    encodingData = stringTouInt8Array(selfSignedCaCertPem);
  }
  let encodingBlob: certFramework.EncodingBlob = {
    data: encodingData,
    encodingFormat: certFormat,
  }
  return encodingBlob;
}

function getEncodingBlobCrl(certType: string, isRevoked: Boolean = false) {
  let certFormat: certFramework.EncodingFormat;
  let encodingData: Uint8Array;
  if (certType == "der") {
    certFormat = certFramework.EncodingFormat.FORMAT_DER;
    encodingData = new Uint8Array(
      (testCrlDer.match(new RegExp('[\\da-f]{2}', 'ig')) as string[]).map((h) => {
        return parseInt(h, 16);
      })
    );
  } else {
    certFormat = certFramework.EncodingFormat.FORMAT_PEM;
    encodingData = stringTouInt8Array(isRevoked ? testRevokedCrlPem : testCrlPem);
  }
  let encodingBlob: certFramework.EncodingBlob = {
    data: encodingData,
    encodingFormat: certFormat,
  }
  return encodingBlob;
}

function getEncodingBlobForCrlTest(flag: string) {
  let certFormat: certFramework.EncodingFormat
  let encodingData: Uint8Array
  if (flag == "normal") {
    certFormat = certFramework.EncodingFormat.FORMAT_PEM;
    encodingData = stringTouInt8Array(testCert);
  } else {
    certFormat = certFramework.EncodingFormat.FORMAT_PEM;
    encodingData = stringTouInt8Array(testErrorCert);
  }
  let encodingBlob: certFramework.EncodingBlob = {
    data: encodingData,
    encodingFormat: certFormat,
  }
  return encodingBlob;
}

let certArray1: Uint8Array = stringTouInt8Array(chainFirstCaCert);
let byteLength1: number = certArray1.byteLength;
let uInt16CertLength1: Uint16Array = new Uint16Array([byteLength1]);
let uInt8CertLength1: Uint8Array = new Uint8Array(uInt16CertLength1.buffer);
let certArray2: Uint8Array = stringTouInt8Array(chainSecondCaCert);
let byteLength2: number = certArray2.byteLength;
let uInt16CertLength2: Uint16Array = new Uint16Array([byteLength2]);
let uInt8CertLength2: Uint8Array = new Uint8Array(uInt16CertLength2.buffer);

let dataArray: Uint8Array = new Uint8Array(
  uInt8CertLength2.length +
  certArray2.length +
  uInt8CertLength1.length +
  certArray1.length
);
for (let i: number = 0; i < uInt8CertLength2.length; i++) {
  dataArray[i] = uInt8CertLength2[i];
}
for (let i: number = 0; i < certArray2.length; i++) {
  dataArray[i + uInt8CertLength2.length] = certArray2[i];
}
for (let i: number = 0; i < uInt8CertLength1.length; i++) {
  dataArray[i + uInt8CertLength2.length + certArray2.length] =
  uInt8CertLength1[i];
}
for (let i: number = 0; i < certArray1.length; i++) {
  dataArray[
  i +
  uInt8CertLength2.length +
  certArray2.length +
  uInt8CertLength1.length
  ] = certArray1[i];
}

function sleep(time: number = 10): Promise<void> {
  return new Promise((res) => setTimeout(res, time));
};

export {
  getEncodingBlob,
  getEncodingBlobCrl,
  getEncodingBlobForCrlTest,
  dataArray,
  sleep
}