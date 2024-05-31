import cryptoFramework from "@ohos.security.cryptoFramework";

export let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('3DES192');
export let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("ECC256");
export let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();

export let pubKeyArray: Uint8Array = new Uint8Array([48, 89, 48, 19, 6, 7, 42, 134, 72, 206, 61, 2, 1, 6, 8, 42, 134, 72, 206, 61, 3, 1, 7, 3, 66, 0, 4, 83, 96, 142, 9, 86, 214, 126, 106, 247, 233, 92, 125, 4, 128, 138, 105, 246, 162, 215, 71, 81, 58, 202, 121, 26, 105, 211, 55, 130, 45, 236, 143, 55, 16, 248, 75, 167, 160, 167, 106, 2, 152, 243, 44, 68, 66, 0, 167, 99, 92, 235, 215, 159, 239, 28, 106, 124, 171, 34, 145, 124, 174, 57, 92]);
export let priKeyArray: Uint8Array = new Uint8Array([48, 49, 2, 1, 1, 4, 32, 115, 56, 137, 35, 207, 0, 60, 191, 90, 61, 136, 105, 210, 16, 27, 4, 171, 57, 10, 61, 123, 40, 189, 28, 34, 207, 236, 22, 45, 223, 10, 189, 160, 10, 6, 8, 42, 134, 72, 206, 61, 3, 1, 7]);
export let pubKeyBlob: cryptoFramework.DataBlob = { data: pubKeyArray }; // Data of the public key.
export let priKeyBlob: cryptoFramework.DataBlob = { data: priKeyArray }; // Data of the private key.
export let convertKeyGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.convertKey(pubKeyBlob, priKeyBlob);

export let plan1: string = "This is Sign test plan1"; // The first segment of the data.
export let plan2: string = "This is Sign test plan2"; // The second segment of the data.
export let arr1: Uint8Array = new Uint8Array(plan1.length);
export let arr2: Uint8Array = new Uint8Array(plan2.length);
for (let i: number = 0, j: number = plan1.length; i < j; ++i) {
  arr1[i] = plan1.charCodeAt(i);
}

for (let i: number = 0, j: number = plan2.length; i < j; ++i) {
  arr2[i] = plan2.charCodeAt(i);
}
export let input1: cryptoFramework.DataBlob = { data: arr1 };
export let input2: cryptoFramework.DataBlob = { data: arr2 };

export let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");

export let dsaCommonSpec: cryptoFramework.DSACommonParamsSpec = {
  algName: "DSA",
  specType: cryptoFramework.AsyKeySpecType.COMMON_PARAMS_SPEC,
  p: BigInt("0xed1501551b8ab3547f6355ffdc2913856ddeca198833dbd04f020e5f25e47c50e0b3894f7690a0d2ea5ed3a7be25c54292a698e1f086eb3a97deb4dbf04fcad2dafd94a9f35c3ae338ab35477e16981ded6a5b13d5ff20bf55f1b262303ad3a80af71aa6aa2354d20e9c82647664bdb6b333b7bea0a5f49d55ca40bc312a1729"),
  q: BigInt("0xd23304044019d5d382cfeabf351636c7ab219694ac845051f60b047b"),
  g: BigInt("0x2cc266d8bd33c3009bd67f285a257ba74f0c3a7e12b722864632a0ac3f2c17c91c2f3f67eb2d57071ef47aaa8f8e17a21ad2c1072ee1ce281362aad01dcbcd3876455cd17e1dd55d4ed36fa011db40f0bbb8cba01d066f392b5eaa9404bfcb775f2196a6bc20eeec3db32d54e94d87ecdb7a0310a5a017c5cdb8ac78597778bd"),
};

export let dsaKeyPairSpec: cryptoFramework.DSAKeyPairSpec = {
  algName: "DSA",
  specType: cryptoFramework.AsyKeySpecType.KEY_PAIR_SPEC,
  params: dsaCommonSpec,
  sk: BigInt("0xa2dd2adb2d11392c2541930f61f1165c370aabd2d78d00342e0a2fd9"),
  pk: BigInt("0xae6b5d5042e758f3fc9a02d009d896df115811a75b5f7b382d8526270dbb3c029403fafb8573ba4ef0314ea86f09d01e82a14d1ebb67b0c331f41049bd6b1842658b0592e706a5e4d20c14b67977e17df7bdd464cce14b5f13bae6607760fcdf394e0b73ac70aaf141fa4dafd736bd0364b1d6e6c0d7683a5de6b9221e7f2d6b"),
};

export let asyKeyPairSpec: cryptoFramework.DSAKeyPairSpec = dsaKeyPairSpec;
export let asyKeyGeneratorBySpec: cryptoFramework.AsyKeyGeneratorBySpec = cryptoFramework.createAsyKeyGeneratorBySpec(asyKeyPairSpec);
export let priKeyGenPromise: Promise<cryptoFramework.PriKey> = asyKeyGeneratorBySpec.generatePriKey();
export let pubKeyGenPromise: Promise<cryptoFramework.PubKey> = asyKeyGeneratorBySpec.generatePubKey();

export let cipherAlgName: string = 'RSA2048|PKCS1_OAEP|SHA256|MGF1_SHA256';
export let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher(cipherAlgName);

export let signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA2048|PSS|SHA256|MGF1_SHA256");
export let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");