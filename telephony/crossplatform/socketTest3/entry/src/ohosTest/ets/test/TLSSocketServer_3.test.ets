/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
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
//import { describe, it, } from './Timeout.test';
import { describe, it, expect, Level, TestType, Size, beforeEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

import deviceInfo from '@ohos.deviceInfo';

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");


const ERR_CODE_PARAMETER_ERROR = 401;
const ERR_REQUEST_ADDRESS_ERROR = 2303199;
const ERR_EIO = 2303105;


const serverKey = "-----BEGIN PRIVATE KEY-----\n" +
  "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCgu+M+ROW0Mm34\n" +
  "gkuMfiI/zz9mHOA8uRSj1ck/Wd9Fx6wY77ftxATq+XN8SHxd0u3ZHc2b4sXEtJml\n" +
  "byrhJPXCMmPq702Sy3XWQp3/AB6Bzwy/pM7Rgx90yuEEF+HT2dxS8VI+kYzdm/ji\n" +
  "bBRzGUGD722+k4M6b4Rsayl1/VELENoPT8iNHovOzuZHMI2jcFcVIm+AA9Z9YEXo\n" +
  "FjSHb1FzB/JT5bmNRakY6jXCfTuZVIij91ELBe2X982h5BEHIAp2vziRFuyHmCdJ\n" +
  "Wzevtb6WNmf32ZzyhG7k3PpGU6G5wA5wN66ELFQ/Y9S6mqlVgyw1ZfwYbOEc53bz\n" +
  "QhfokVEnAgMBAAECggEAcWJ5OFjzzTzx1KddUfs8f9Tb/VWLXWqWQ8iw0Y69cQUc\n" +
  "wu5/yitH6NYVgGvFx43fGRTsEPZU2qEn7crQ7cfb0aUoVPeAunfqZT3TJKpZ2upL\n" +
  "LPm+p48e5o2jU/bg6Eg8Iwp3IQod28qGNHtXpaYAUGja+uAmZ1d5i93Afqo2vF2F\n" +
  "sAjVsRTSV7S9PCsVGp1xgMihAA3J+IIU3La0mAiDBuxq6uWLUMIVBwx6t8w9vO0V\n" +
  "cViq4uRuxQT2Z+UODiCqioZ9ek1zr7M7sRVeTY0WQPtgFWvicgz/IU+wlZ1b9h95\n" +
  "ktdWe2MNH1r1Q3KjvZjMyfFy38sZfqBpyOA0QYmW4QKBgQDNK4VfjqLiTrg3IPe5\n" +
  "6F413lzj9rjqDgZZvBCQrmvgO6BB6SGZulC4TIjF7l9EN1v27rnwPBWLMgwvvOdK\n" +
  "B9P+PHDyhXTIxt4ey+/R499A5Z2NdYxT/qmXBnTgshIMmRCCqZHqr9sYkp4nsk+n\n" +
  "0Rsw5z/y1DrHxISlHTyW0VX+MQKBgQDIjhoVerTbDTyazMIA+oVePZC5k3olfw+D\n" +
  "qmHxAHvH6cpM2kl4MaOGd+HpXLP6M0fQIPmZVjA/ytdWH/mSSop6db0VLGSf6AEF\n" +
  "RVvDbcK5N3OhdrZXaT1uJwI05LtO57V6blk1XrSPcrevWxmWyxxBZMjBBiTE1EwR\n" +
  "2M0kzkK21wKBgQCs7/c/AZLIYQQj69UDzhrDG0h/GrLpDqNJthzcZzkky/2cMO8S\n" +
  "jhqGDnTnKbMBZAxPixANsAeUyb2962OlYg3N6ZJmyhkTN5V4rfvallHTePghiaic\n" +
  "EDdQxq9zyoUuO0LQcDA/erWZ89P9r+42jSp3QSUFAOD/C+Wm64rrsU3jsQKBgQCc\n" +
  "LSSc02hhKMaoGYl+L5iKEdFQ4kp9RpvzQUxx25mIzUOPY3FRGv6nqVWQX3N8BFEI\n" +
  "/5S/VsHN+4yC8fVseYWq5WLwSRi2+XlJ/IAACMpZZ5gxBXvrR/XhgJkUTYabZI8L\n" +
  "H0Fy8SQUjRYDhSLBLbv8JJq8zab2bAgs4bKm1cRYEwKBgAHAhpv0aFZbulveNyQ1\n" +
  "Qam0KNxLWQjZscX4kQNOMl301se343+8EVzIM5kCcR1WGgKLAgutoEc+8URPakGm\n" +
  "KAuxhqRmAUfpDfFGkuX25eWLBMOTiKmlxvvLFV1vfwS28dsaH6pMOIQGGpEISY/I\n" +
  "vUUev502w5PXY+keOeHn1+60\n" +
  "-----END PRIVATE KEY-----";

const serverCert = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDZTCCAk0CFDTT79/rmba0ndVnsXuRu2eHwHApMA0GCSqGSIb3DQEBCwUAMFYx\n" +
  "CzAJBgNVBAYTAkNOMRAwDgYDVQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5n\n" +
  "MQ4wDAYDVQQKDAVNeSBDQTETMBEGA1UEAwwKTXkgUm9vdCBDQTAeFw0yNTEyMDQw\n" +
  "ODAyMDhaFw0yNjEyMDQwODAyMDhaMIGHMQswCQYDVQQGEwJDTjERMA8GA1UECAwI\n" +
  "c2hhbmdoYWkxETAPBgNVBAcMCHNoYW5naGFpMRQwEgYDVQQKDAtIVUFXRUlfVEVT\n" +
  "VDEWMBQGA1UECwwNY29tbXVuaWNhdGlvbjESMBAGA1UEAwwJMTI3LjAuMC4xMRAw\n" +
  "DgYJKoZIhvcNAQkBFgEwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA\n" +
  "oLvjPkTltDJt+IJLjH4iP88/ZhzgPLkUo9XJP1nfRcesGO+37cQE6vlzfEh8XdLt\n" +
  "2R3Nm+LFxLSZpW8q4ST1wjJj6u9Nkst11kKd/wAegc8Mv6TO0YMfdMrhBBfh09nc\n" +
  "UvFSPpGM3Zv44mwUcxlBg+9tvpODOm+EbGspdf1RCxDaD0/IjR6Lzs7mRzCNo3BX\n" +
  "FSJvgAPWfWBF6BY0h29RcwfyU+W5jUWpGOo1wn07mVSIo/dRCwXtl/fNoeQRByAK\n" +
  "dr84kRbsh5gnSVs3r7W+ljZn99mc8oRu5Nz6RlOhucAOcDeuhCxUP2PUupqpVYMs\n" +
  "NWX8GGzhHOd280IX6JFRJwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAxNEKhpVu2\n" +
  "uT5xK1GkbICJ9/84/D8IyZ1mLFZtq4GwOu9/PbzIzrN3mKaWXWcFUuZr19WQ2kRg\n" +
  "P0TmI3IjVEcE7MnCxwf5p65Bdg2g7as8wbuTRldUHd8mwAHUxQkXleBu5tVPiOPt\n" +
  "JW7Nok6V2HJbRXPrkWKpssV9qtxVV8Ju7ELbAi1CujgFDOVZBOMWbgOQtbeGLpNt\n" +
  "uxUVHIAYJenoTomd0MeZJOpv4uS7eZNWJK1K2qX823qx5OuqdCM+BJmVzvdwRS9S\n" +
  "iV+Yoz1FKbfxyQOiZ3gGEY0kwAtKaTjL7FVjwvUImc3wH1pIgsVHrr8aOXVzMulk\n" +
  "wJ9SjDRIyOez\n" +
  "-----END CERTIFICATE-----";

const serverCa = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDjTCCAnWgAwIBAgIUOs5K47mhbnfCywd9U9lzPTvOzGMwDQYJKoZIhvcNAQEL\n" +
  "BQAwVjELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDjAMBgNVBAoMBU15IENBMRMwEQYDVQQDDApNeSBSb290IENBMB4XDTI1\n" +
  "MTIwNDA3MzI0MVoXDTM1MTIwMjA3MzI0MVowVjELMAkGA1UEBhMCQ04xEDAOBgNV\n" +
  "BAgMB0JlaWppbmcxEDAOBgNVBAcMB0JlaWppbmcxDjAMBgNVBAoMBU15IENBMRMw\n" +
  "EQYDVQQDDApNeSBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
  "AQEAqDLENI4F1aqUV1Jqh16yWkgO5fpco5m3m4oT4RSxcAKVc4AfOZIR4EGDk7Lx\n" +
  "mjMsRyYnOrvnEm0olacykajI4sh0K6N6yEIYlAljrZ6wzUsifgWcMnu34iZhlWkq\n" +
  "NQt8jew1T8ThwBc5Q7OT/X3zKcETFmIFqL2iXeKiB4YkFIv2p701ghqJG2q4hToq\n" +
  "uTcSfNW1RmRU6VKXR7iPvAquXRuJG/LQLJIZyYt4lJ/B1ab3iDl+QqeTunmFwc3s\n" +
  "ZzOgUtP3ZEWxm+6kvSlBkQC24kqgd/ALllUWBNxj0ZBncY0UvreQxrmO1CrSs1f3\n" +
  "bvYG75DxCux721pY7/xV5aAJywIDAQABo1MwUTAdBgNVHQ4EFgQUJGV56hcSKnl/\n" +
  "KUKEqN0PD6tMItUwHwYDVR0jBBgwFoAUJGV56hcSKnl/KUKEqN0PD6tMItUwDwYD\n" +
  "VR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAbZ7gzy2xnJX8KXnQabZV\n" +
  "qLh5846x7TrluB1djbxPVzsafez2lmNpSq+JHKAYc2cq9Y5a3waCYrCYs+0VFiyU\n" +
  "+jrCy2LqXrDjMxeGk8Gk3YHj+5lcGi3X8i6ec69KTsqIsY032+y2ihVrDUWvq+iQ\n" +
  "NXi7onaUiyQKo/eN9A83vZbTKLxrtM+Ko3crsG+R9l3nf2J+KnG7l18ZAxWiwS+7\n" +
  "Y/+dzrKNAC+TCwYr8ys+wMgEEKt/BjjgpxgrzLLfi4e7rHS7/3zSDFf5gtYSbcR/\n" +
  "d6J4Xvh/+tfPFqTaVPtGAabvsSIrTWMH7gVOP0GTDwwi3hVhDw5iUGuEiGAboYeq\n" +
  "qA==\n" +
  "-----END CERTIFICATE-----";

const clientKey = "-----BEGIN PRIVATE KEY-----\n" +
  "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDgm2c4+EvB7fUj\n" +
  "OTMFpZ8nD4bAIjWNKaEklFMQxoQOgcz+674hAbCIM7gfkdcUrV8TFSbGdC7l6m5e\n" +
  "L/8cqbnGozXdfYLi3EoZ4uGtzQnYcu5e8C3NMX6FP1VsBpwHvqsgSOs9CqejFMIA\n" +
  "rzXhfoGBs5d1uF5GXbrfDnI4aD1InxX6rkwdFQbcd6pxe+9jqjUDsaaycI+tIxV+\n" +
  "jwOGIauGbmePpY+peEy1z+rY9MAubrXpgtzH6afd0N7SZX6YKo1focRN9dBPfFAc\n" +
  "Zc2uE0bFLOR/LrV0yCrGJ+ZHRRGr2UK8kMtJw9vUpBajSJTFMEOO6XwreMNwdyOU\n" +
  "ofgjiOnHAgMBAAECggEBAKxDhC+Vf8UFFHYncJJsLFxw9BB4LEpQG19Kw0qidrYJ\n" +
  "p4f8lp4KBbLwt86+tA8PyVOBbXPXuABuhKeIeEkrg2ht1OpDURddjRe9gwkhsONp\n" +
  "gpkd7ILr6vWXVZS8nP7zpZvlUUZH3bqeOQz9VH3V4M3xR8Dp3qRpTuG02rWYfSgs\n" +
  "Kuv/D7dunGSRyrIeeAfCNOYOhUYqyahJ3YiA9VwwLqsDngKaU8vJhkTr6KJTJHoD\n" +
  "AoIoXTMYsARSDWJ3GcTg3rhExCJjNTUX4CaGmwEKyAj0ESLgyFDD12hSA2wos3//\n" +
  "uf0N6gQbEAl8JDZNQxt8MiKGjoRS7iuwuGc+yykG9EECgYEA/dauysFczqC/AzJO\n" +
  "0mbjx+VXUHdOVaXKfkkkXFkLkxiBnZYaXWHAxMHaVMlADfSHeTQwtrjGC18rJDOH\n" +
  "xG0PpZpV9MR2sIgl0qY+LiVpnt2tRb0M/iHf/ZLM+aCQ5QtW6tIDHWeVYkeOpjSx\n" +
  "c/zniSd+AjEtoKmnscng1I4Z2o0CgYEA4oUAYf4OQNrhR5lB12d5eek+seIQqqHA\n" +
  "TCUBDZ+NGL0z7J3ykwSfr1IHM04GuMKF/zKtn8mEUuJMfTHup9Abvh+mhu8eHNfv\n" +
  "lSR3uESMb7K2iJk2zkFdj8gwXiKMFUbQMl2ofnypA6cuD5GqBsiIOIQPWNZj0IUN\n" +
  "w2d2mrj+SqMCgYEAhSwvkeI2XZWKARRQtCQU1tfkoiulpluPzAd1kxmIcAjIX7PT\n" +
  "azCQ4OlPMXJQL8IdnSIbeJGiHW81hA2g6hXJwrkg5YR5PI6BQW3Ea5NnQVjNwiu3\n" +
  "+FAvYqq07TYnLnNvi0zZI4Enp2MhXOOCQfbqRlO40U+Zv5Oijiz6zqkquTUCgYEA\n" +
  "lFVMHt9jLg0nIN+3Qfs8jRy0NYA4McSiTDqfKfClUOH1Mqlrw+JvPzuUA4DA3hRj\n" +
  "8u2YzN4FjNEsDX+5LKMWx7WqMwo6yeCNvziWPVCGNk7tQR4zyXT8c79ADSTKXtR0\n" +
  "WccDI3E2rHG5s/BLSw3eRkQUWLRrwIygqqkB/efOfckCgYBhDy1x1bNX2ZmGhWOJ\n" +
  "3ztWyfskt5kZPMZLLEeRZKeNiaxcgRJ2WcKBVacpbBK9t8c+6TJtEUwj7x1CAnP+\n" +
  "YMrMG7Bq4ZXYF7RalHs8eg0W6x1HDR0cpH/K7NKSYEA76xjxlc3YQj1/DM8TcB8e\n" +
  "iK2OekLYOfPRF3n9zRtb4Nonbw==\n" +
  "-----END PRIVATE KEY-----";

const clientCert = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDWzCCAkMCFAd4hTk+2V0twNIleg+RMdJiDf3rMA0GCSqGSIb3DQEBCwUAMFYx\n" +
  "CzAJBgNVBAYTAkNOMRAwDgYDVQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5n\n" +
  "MQ4wDAYDVQQKDAVNeSBDQTETMBEGA1UEAwwKTXkgUm9vdCBDQTAeFw0yNTEyMDQw\n" +
  "ODI3NDdaFw0yNjEyMDQwODI3NDdaMH4xCzAJBgNVBAYTAkNOMRAwDgYDVQQIDAdi\n" +
  "ZWlqaW5nMRAwDgYDVQQHDAdiZWlqaW5nMQ8wDQYDVQQKDAZIVUFXRUkxFjAUBgNV\n" +
  "BAsMDWNvbW11bmljYXRpb24xEDAOBgNVBAMMBzAuMC4wLjAxEDAOBgkqhkiG9w0B\n" +
  "CQEWATEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDgm2c4+EvB7fUj\n" +
  "OTMFpZ8nD4bAIjWNKaEklFMQxoQOgcz+674hAbCIM7gfkdcUrV8TFSbGdC7l6m5e\n" +
  "L/8cqbnGozXdfYLi3EoZ4uGtzQnYcu5e8C3NMX6FP1VsBpwHvqsgSOs9CqejFMIA\n" +
  "rzXhfoGBs5d1uF5GXbrfDnI4aD1InxX6rkwdFQbcd6pxe+9jqjUDsaaycI+tIxV+\n" +
  "jwOGIauGbmePpY+peEy1z+rY9MAubrXpgtzH6afd0N7SZX6YKo1focRN9dBPfFAc\n" +
  "Zc2uE0bFLOR/LrV0yCrGJ+ZHRRGr2UK8kMtJw9vUpBajSJTFMEOO6XwreMNwdyOU\n" +
  "ofgjiOnHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAC+irqFOM+/HQY9K9J2RmxSe\n" +
  "siiIc2Rqh71BFT2OHOmTko8I0D3siSs1kH7x77b2IPWyLUbnDs2IRrt06hHdZt4r\n" +
  "BYNh95U8H25/CMNXgCm5wWC7a23wN6fsmwXk8UK2fm1ZtoLYqLPaXLMUyU/JfdNU\n" +
  "Ziv2RiK4iT+g8p59o6/q/wB7yTY6wdpbUMg0nfus2aqCtVVUsVhvHnQJ1O0lS8cu\n" +
  "fKneyr2zRZf8Irx7yiWeY2+CzHFWIfJ1RHrlvPkGA3UdD0UAssZkyhNuP1HSUCKW\n" +
  "OsdZPnJNON1wyId1KzmGbSsFh6yqMwerYCZkN5McglU6KSxpctGATKC0y1q4/wE=\n" +
  "-----END CERTIFICATE-----";

const clientCa = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDjTCCAnWgAwIBAgIUOs5K47mhbnfCywd9U9lzPTvOzGMwDQYJKoZIhvcNAQEL\n" +
  "BQAwVjELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDjAMBgNVBAoMBU15IENBMRMwEQYDVQQDDApNeSBSb290IENBMB4XDTI1\n" +
  "MTIwNDA3MzI0MVoXDTM1MTIwMjA3MzI0MVowVjELMAkGA1UEBhMCQ04xEDAOBgNV\n" +
  "BAgMB0JlaWppbmcxEDAOBgNVBAcMB0JlaWppbmcxDjAMBgNVBAoMBU15IENBMRMw\n" +
  "EQYDVQQDDApNeSBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
  "AQEAqDLENI4F1aqUV1Jqh16yWkgO5fpco5m3m4oT4RSxcAKVc4AfOZIR4EGDk7Lx\n" +
  "mjMsRyYnOrvnEm0olacykajI4sh0K6N6yEIYlAljrZ6wzUsifgWcMnu34iZhlWkq\n" +
  "NQt8jew1T8ThwBc5Q7OT/X3zKcETFmIFqL2iXeKiB4YkFIv2p701ghqJG2q4hToq\n" +
  "uTcSfNW1RmRU6VKXR7iPvAquXRuJG/LQLJIZyYt4lJ/B1ab3iDl+QqeTunmFwc3s\n" +
  "ZzOgUtP3ZEWxm+6kvSlBkQC24kqgd/ALllUWBNxj0ZBncY0UvreQxrmO1CrSs1f3\n" +
  "bvYG75DxCux721pY7/xV5aAJywIDAQABo1MwUTAdBgNVHQ4EFgQUJGV56hcSKnl/\n" +
  "KUKEqN0PD6tMItUwHwYDVR0jBBgwFoAUJGV56hcSKnl/KUKEqN0PD6tMItUwDwYD\n" +
  "VR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAbZ7gzy2xnJX8KXnQabZV\n" +
  "qLh5846x7TrluB1djbxPVzsafez2lmNpSq+JHKAYc2cq9Y5a3waCYrCYs+0VFiyU\n" +
  "+jrCy2LqXrDjMxeGk8Gk3YHj+5lcGi3X8i6ec69KTsqIsY032+y2ihVrDUWvq+iQ\n" +
  "NXi7onaUiyQKo/eN9A83vZbTKLxrtM+Ko3crsG+R9l3nf2J+KnG7l18ZAxWiwS+7\n" +
  "Y/+dzrKNAC+TCwYr8ys+wMgEEKt/BjjgpxgrzLLfi4e7rHS7/3zSDFf5gtYSbcR/\n" +
  "d6J4Xvh/+tfPFqTaVPtGAabvsSIrTWMH7gVOP0GTDwwi3hVhDw5iUGuEiGAboYeq\n" +
  "qA==\n" +
  "-----END CERTIFICATE-----";

const tlsSecureConfig: socket.TLSSecureOptions = {
  key: serverKey,
  cert: serverCert,
  ca: [serverCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
};

const netAddress: socket.NetAddress = {
  address: '0.0.0.0',
  port: 8080
};

const tlsConnectOptions: socket.TLSConnectOptions = {
  address: netAddress,
  secureOptions: tlsSecureConfig,
  ALPNProtocols: ["spdy/1", "http/1.1"],
};

const TlsClientOptions: socket.TLSSecureOptions = {
  key: clientKey,
  cert: clientCert,
  ca: [clientCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
};

const connectAddr: socket.NetAddress = {
  address: '127.0.0.1',
  port: 8080
};

const connectOptions: socket.TLSConnectOptions = {
  address: connectAddr,
  secureOptions: TlsClientOptions,
  ALPNProtocols: ["spdy/1", "http/1.1"],
  skipRemoteValidation: true
};

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function TLSSocketServerTest3() {
  describe('TLSSocketServerTest3', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5800
     * @tc.name ArKUIX_TLSSocketServer_Listen_5800
     * @tc.desc The test timeout is 4294967296(exceeding the upper limit), and the callback asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: 4294967296
        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5900
     * @tc.name ArKUIX_TLSSocketServer_Listen_5900
     * @tc.desc Test that timeout is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: undefined

        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6000
     * @tc.name ArKUIX_TLSSocketServer_Listen_6000
     * @tc.desc Test the timeout to be 1000(a valid value) and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: 1000
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6100
     * @tc.name ArKUIX_TLSSocketServer_Listen_6100
     * @tc.desc Test timeout to -1(illegal value) and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: -1
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6200
     * @tc.name ArKUIX_TLSSocketServer_Listen_6200
     * @tc.desc The test timeout is 4294967296(exceeding the upper limit), and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: 4294967296
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6300
     * @tc.name ArKUIX_TLSSocketServer_Listen_6300
     * @tc.desc Test that timeout is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: undefined
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6600
     * @tc.name ArKUIX_TLSSocketServer_Listen_6600
     * @tc.desc The test cannot allocate an address. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();

        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '192.168.255.255', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_REQUEST_ADDRESS_ERROR || errCode === ERR_EIO).assertTrue();
            } else {
              expect().assertFail();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6700
     * @tc.name ArKUIX_TLSSocketServer_Listen_6700
     * @tc.desc The test cannot allocate an address. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '192.168.255.255', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        tlsServer.listen(listenOptions).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_REQUEST_ADDRESS_ERROR || errCode === ERR_EIO).assertTrue();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6800
     * @tc.name ArKUIX_TLSSocketServer_Listen_6800
     * @tc.desc Test whether listen can be run within the on method,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
            expect(data.clientId != undefined).assertTrue();
          });
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          });
          tlsServer.off('connect');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_6900
     * @tc.name ArKUIX_TLSSocketServer_Listen_6900
     * @tc.desc Test whether the listen method can run before the on method,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_6900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_6900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            tlsServer?.on('connect', (data: socket.TLSSocketConnection) => {
            });
            listen = true;
            expect(listen).assertTrue();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7000
     * @tc.name ArKUIX_TLSSocketServer_Listen_7000
     * @tc.desc Test the maximum legal port,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 65535 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions).then(() => {
            listen = true;
            expect(listen).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7100
     * @tc.name ArKUIX_TLSSocketServer_Listen_7100
     * @tc.desc Test the smallest legal port,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 0 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions).then(() => {
            listen = true;
            expect(listen).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7200
     * @tc.name ArKUIX_TLSSocketServer_Listen_7200
     * @tc.desc The test exceeds the legitimate port,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 30000000 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions).then(() => {
            listen = true;
            expect(listen).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7300
     * @tc.name ArKUIX_TLSSocketServer_Listen_7300
     * @tc.desc The test address is IPv6, and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '::', port: 8080, family: 2 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions).then(() => {
            listen = true;
            expect(listen).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7400
     * @tc.name ArKUIX_TLSSocketServer_Listen_7400
     * @tc.desc When the test ca is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: '',
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7500
     * @tc.name ArKUIX_TLSSocketServer_Listen_7500
     * @tc.desc When the test cert is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: '',
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7600
     * @tc.name ArKUIX_TLSSocketServer_Listen_7600
     * @tc.desc When the test key is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: '',
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7700
     * @tc.name ArKUIX_TLSSocketServer_Listen_7700
     * @tc.desc When the test password is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: '',
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7800
     * @tc.name ArKUIX_TLSSocketServer_Listen_7800
     * @tc.desc When the test protocols is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: [],
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_7900
     * @tc.name ArKUIX_TLSSocketServer_Listen_7900
     * @tc.desc When the test signatureAlgorithms is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_7900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_7900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_8000
     * @tc.name ArKUIX_TLSSocketServer_Listen_8000
     * @tc.desc When the test cipherSuite is '', use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_8000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_8000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0100
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0100
     * @tc.desc Test the listen function, set the proxy to SOCKS5, and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0200
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0200
     * @tc.desc Test the listen function, set the proxy to NONE, and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.NONE,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0300
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0300
     * @tc.desc Test the listen function with the address.address "", using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0400
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0400
     * @tc.desc Test the listen function with address.address "11111", using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '11111', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0500
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0500
     * @tc.desc Test the listen function. The address.port is undefined. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0600
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0600
     * @tc.desc Test the listen function. The address.family is undefined. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080, family: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0700
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0700
     * @tc.desc Test the listen function. The username is undefined. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: undefined,
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0800
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0800
     * @tc.desc Test the listen function. The username is "". Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: '',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_0900
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_0900
     * @tc.desc Test the listen function. The username is "11111". Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: '11111',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1000
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1000
     * @tc.desc Test the listen function. The password is undefined. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080, family: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: undefined,
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1100
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1100
     * @tc.desc Test the listen function. The password is “”. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080, family: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: '',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1200
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1200
     * @tc.desc Test the listen function. The password is “11111”. Use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080, family: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: '11111',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (!err) {
              listen = true;
              expect(listen).assertTrue();
              done();
            }
          })
        } catch (err) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1300
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1300
     * @tc.desc Test the listen function, set the proxy to SOCKS5, and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1400
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1400
     * @tc.desc Test the listen function, set the proxy to NONE, and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.NONE,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1500
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1500
     * @tc.desc Test the listen function with the address.address "", using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1600
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1600
     * @tc.desc Test the listen function with address.address "11111", using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '11111', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1700
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1700
     * @tc.desc Test the listen function. The address.port is undefined. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1800
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1800
     * @tc.desc Test the listen function. The address.family is undefined. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080, family: undefined } as socket.NetAddress,
          username: 'proxyUser',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_1900
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_1900
     * @tc.desc Test the listen function. The username is undefined. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_1900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: undefined,
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_2000
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_2000
     * @tc.desc Test the listen function. The username is "". Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_2000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: '',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
          expect(listen).assertTrue();
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_2100
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_2100
     * @tc.desc Test the listen function. The username is "11111". Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_2100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: '11111',
          password: 'proxyPass',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_2200
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_2200
     * @tc.desc Test the listen function. The password is undefined. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_2200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: undefined,
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_2300
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_2300
     * @tc.desc Test the listen function. The password is “”. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_2300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: '',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
          expect(listen).assertTrue();
        } catch (error) {
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_Proxy_2400
     * @tc.name ArKUIX_TLSSocketServer_Listen_Proxy_2400
     * @tc.desc Test the listen function. The password is “11111”. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_Proxy_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_Proxy_2400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const proxyOptions: socket.ProxyOptions = {
          type: socket.ProxyTypes.SOCKS5,
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          username: 'proxyUser',
          password: '11111',
        }
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
          proxy: proxyOptions,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions)
            .then(() => {
              listen = true;
              expect(listen).assertTrue();
              done();
            })
            .catch((err: BusinessError) => {
              expect().assertFail();
              done();
            })
        } catch (error) {
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0100
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0100
     * @tc.desc Test the On Error event,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '192.168.2.108',
            port: 17421,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          let on_error = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                resolve();
              });
              tlsServer.on('error', (err: BusinessError) => {
                console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                on_error = true;
                expect(on_error).assertTrue();
                done();
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0200
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '192.168.2.108',
            port: 8080,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                resolve();
              });
              try {
                tlsServer.on(null, (err: BusinessError) => {
                  console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.info(`${caseName} on error fail: ${err.code} - ${err.message}`)
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0300
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '192.168.2.108',
            port: 8080,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                resolve();
              });
              try {
                tlsServer.on(undefined, (err: BusinessError) => {
                  console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.info(`${caseName} on error fail: ${err.code} - ${err.message}`)
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }

            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0400
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '192.168.2.108',
            port: 8080,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                resolve();
              });
              try {
                tlsServer.on('error', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }

            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0500
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '192.168.2.108',
            port: 8080,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                resolve();
              });
              try {
                tlsServer.on('error', null);
                expect().assertFail();
                done();
              } catch (err) {
                console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0600
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0600
     * @tc.desc Client binds to other ip,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.20',
            port: 8080,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                if (isiOS && err.code === ERR_EIO) {
                  expect(true).assertTrue();
                  done();
                  return;
                }
                reject(err);
              });
              tlsServer.on('error', (err: BusinessError) => {
                console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              expect(true).assertTrue();
              done();
            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });
          });
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsClient.bind(netAddress).then(() => {
                console.info(`${caseName} bind success`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsClient.connect(connectOptions).then(() => {
              console.info(`${caseName} connect successfully`);
            }).catch((err: BusinessError) => {
              console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Error_0700
     * @tc.name ArKUIX_TLSSocketServer_On_Error_0700
     * @tc.desc Client binds to other port,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Error_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Error_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.on('error', (err: BusinessError) => {
                console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                expect().assertFail();
                reject(err);
              });

              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === 2303113).assertTrue();
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
              console.info(JSON.stringify(data));
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(connectOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0100
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0100
     * @tc.desc Unsubscribe to error events for TLSSocketServer connections,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35001,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };
          const tlsClientOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              protocols: socket.Protocol.TLSv12,
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });

            (async (): Promise<void> => {
              try {
                tlsServer.off('error', (err: BusinessError) => {
                  console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                });
                expect(true).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                expect().assertFail();
                done();
              }
            })();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(addr).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(tlsClientOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0200
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35002,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });
            (async (): Promise<void> => {
              try {
                tlsServer.off(null, (err: BusinessError) => {
                  console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0300
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35003,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });

            (async (): Promise<void> => {
              try {
                tlsServer.off(undefined, (err: BusinessError) => {
                  console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0400
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35004,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });

            (async (): Promise<void> => {
              try {
                tlsServer.off('error', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0500
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35005,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });

            (async (): Promise<void> => {
              try {
                tlsServer.off('error', null);
                expect().assertFail();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0600
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0600
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35006,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };
          const tlsClientOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              protocols: socket.Protocol.TLSv12,
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('error', (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });

            (async (): Promise<void> => {
              try {
                tlsServer.off('error');
                expect(true).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                expect().assertFail();
                done();
              }
            })();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(addr).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(tlsClientOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0700
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0700
     * @tc.desc Test without specifying the callback parameter and clear multiple calls
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35007,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };
          const tlsClientOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              protocols: socket.Protocol.TLSv12,
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            const callback_1 = (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            };
            const callback_2 = (err: BusinessError) => {
              console.info(`${caseName} TLS server error event was detected: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            }
            tlsServer.on('error', callback_1);
            tlsServer.on('error', callback_2);
            (async (): Promise<void> => {
              try {
                tlsServer.off('error');
                expect(true).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                expect().assertFail();
                done();
              }
            })();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(addr).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(tlsClientOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Error_0800
     * @tc.name ArKUIX_TLSSocketServer_Off_Error_0800
     * @tc.desc Test whether the subscription event can be cancelled if it is not enabled,
     * Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Error_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Error_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 35008,
            family: 1
          };
          const tlsServerOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              key: tlsSecureConfig.key,
              cert: tlsSecureConfig.cert,
              password: tlsSecureConfig.password,
              protocols: socket.Protocol.TLSv12,
              useRemoteCipherPrefer: true,
              signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
              cipherSuite: "AES256-SHA256",
              isBidirectionalAuthentication: false
            } as socket.TLSSecureOptions
          };
          const tlsClientOptions: socket.TLSConnectOptions = {
            address: addr,
            secureOptions: {
              ca: tlsSecureConfig.ca,
              protocols: socket.Protocol.TLSv12,
            } as socket.TLSSecureOptions
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsServerOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(addr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            (async (): Promise<void> => {
              try {
                tlsServer.off('error');
                expect(true).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} The call to "off" to unsubscribe failed: ${error.code} - ${error.message}`);
                expect().assertFail();
                done();
              }
            })();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(addr).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(tlsClientOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0100
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0100
     * @tc.desc Test the functionality of the on interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 17421,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(connectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (conn: socket.TLSSocketConnection) => {
              console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
              expect(conn != null).assertTrue();
              done();
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} fail:` + JSON.stringify(err));
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0200
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            try {
              tlsServer.on(null, (conn: socket.TLSSocketConnection) => {
                console.info(`${caseName} on connect success`);
                expect().assertFail();
                done();
              });
            } catch (err) {
              console.error(`${caseName} v: ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0300
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 50003
          };
          await (async (): Promise<void> => {
          })().then(async () => {
            try {
              tlsServer.on(undefined, (conn: socket.TLSSocketConnection) => {
                console.info(`${caseName} on connect success`);
                expect().assertFail();
                done();
              });
            } catch (err) {
              console.error(`${caseName} v: ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0400
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            try {
              tlsServer.on('connect', undefined);
              console.warn(`${caseName} on connect success`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} on connect fail:
      ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0500
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await (async (): Promise<void> => {
          })().then(async () => {
            try {
              tlsServer.on('connect', null);
              console.warn(`${caseName} on connect success`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} on connect fail:
      ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0600
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0600
     * @tc.desc Do not set whether the client can trigger the subscription,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50006
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          await tlsClient.bind(netAddress).then(() => {
            console.info(`${caseName} bind success`);
          }).catch((err: BusinessError) => {
            console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
            expect().assertFail();
            done();
          });
          await tlsClient.connect(connectOptions).then(() => {
            console.info(`${caseName} connect successfully`);
          }).catch((err: BusinessError) => {
            console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === 2303501).assertTrue();
            done();
          });

          await tlsServer.listen(tlsConnectOptions).then(() => {
            console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
            try {
              tlsServer.on('connect', (conn: socket.TLSSocketConnection) => {
                console.info(`${caseName} on connect success: ${!!conn}`);
                expect().assertFail();
                done();
              });
            } catch (err) {
              console.error(`${caseName} on connect fail:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect().assertFail();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} server listen error: ${err.code} - ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} test error: ${(err as BusinessError).message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_On_Connect_0700
     * @tc.name ArKUIX_TLSSocketServer_On_Connect_0700
     * @tc.desc Client binds to other ports,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_On_Connect_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_On_Connect_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 300000,
            family: 1
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          let on_connect = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(connectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (conn: socket.TLSSocketConnection) => {
              console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
              on_connect = true;
              expect(on_connect).assertTrue();
              done();
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              setTimeout(() => {
                tlsClient.connect(connectOptions).then(() => {
                  console.info(`${caseName} connect successfully`);
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                });
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} fail:` + JSON.stringify(err));
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0100
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0100
     * @tc.desc Unsubscribe to the specified connection,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50007
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            try {
              tlsServer.off('connect', connectCallback);
              console.info(`${caseName} off connect success`);
            } catch (err) {
              console.error(`${caseName} off connect fail:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect().assertFail();
              done();
              return;
            }
            expect(true).assertTrue();
            done();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(connectOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0200
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50008
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            console.info(`${caseName} success to subscribe connect event`);

            try {
              tlsServer.off(null, connectCallback);
              console.warn(`${caseName} pass null parameter`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} off to cancel connect event:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0300
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50009
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            console.info(`${caseName} success to subscribe connect event`);
            try {
              tlsServer.off(undefined, connectCallback);
              console.warn(`${caseName} pass null parameter`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} off to cancel connect event:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0400
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50010
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            console.info(`${caseName} success to subscribe connect event`);

            try {
              tlsServer.off('connect', null);
              console.warn(`${caseName} pass null callback parameter`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} off to cancel connect event:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0500
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50011
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            console.info(`${caseName} success to subscribe connect event`);
            try {
              tlsServer.off('connect', undefined);
              console.warn(`${caseName} pass null callback parameter`);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} off to cancel connect event:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });
    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0600
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0600
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50012
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback);
            try {
              tlsServer.off('connect');
              console.info(`${caseName} off connect success`);
            } catch (err) {
              console.error(`${caseName} off connect fail:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect().assertFail();
              done();
              return;
            }
            expect(true).assertTrue();
            done();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              await (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  tlsClient.connect(connectOptions).then(() => {
                    console.info(`${caseName} connect successfully`);
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                    reject(err);
                  });
                });
              })();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0700
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0700
     * @tc.desc Unsubscribe to all,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50013
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          const connectCallback1 = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} off connect fail: ${!!conn}`);
            expect().assertFail();
            done();
          };
          const connectCallback2 = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} off connect fail: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', connectCallback1);
            tlsServer.on('connect', connectCallback2);
            try {
              tlsServer.off('connect');
              console.info(`${caseName} off connect success`);
            } catch (err) {
              console.error(`${caseName} off connect fail:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect().assertFail();
              done();
              return;
            }
            // expect(true).assertTrue();
            // done();

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
          expect(true).assertTrue();
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_Off_Connect_0800
     * @tc.name ArKUIX_TLSSocketServer_Off_Connect_0800
     * @tc.desc Set up another ip or port,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Off_Connect_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Off_Connect_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.122222',
            port: 800000
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: 800000
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddressServer,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectCallback = (conn: socket.TLSSocketConnection) => {
            console.info(`${caseName} The server connect event has been detected: ${!!conn}`);
            expect().assertFail();
            done();
          };
          await tlsServer.listen(tlsConnectOptions).then(() => {
            console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);

            tlsServer.on('connect', connectCallback);
            console.info(`${caseName} success to subscribe connect event`);
            try {
              tlsServer.off('connect', connectCallback);
            } catch (err) {
              console.error(`${caseName} The call to "off" to unsubscribe failed:
            ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
              expect().assertFail();
              done();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
            expect().assertFail();
            done();
          });
          await tlsClient.bind(netAddress).then(() => {
            console.info(`${caseName} bind success`);
            tlsClient.connect(connectOptions).then(() => {
              console.info(`${caseName} connect successfully`);
            }).catch((err: BusinessError) => {
              console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
            expect(err.code === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tlsServer.close();
            tlsClient.close();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        }
      });
  })
}