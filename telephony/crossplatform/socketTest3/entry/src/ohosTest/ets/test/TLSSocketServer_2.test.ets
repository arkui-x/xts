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

import { describe, it, expect, Level, TestType, Size, beforeEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

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

export default function TLSSocketServerTest2() {
  describe('TLSSocketServerTest2', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0400
     * @tc.desc Test Options to undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(null, (err: BusinessError) => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0700
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done()
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0800
     * @tc.desc Test Options to null and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(null).then(() => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0900
     * @tc.desc Test Options to undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(undefined).then(() => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1000
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1100
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1200
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: true,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1300
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1400
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1500
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1600
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 100
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1700
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        await tlsServer.listen(listenOptions);
        const tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: undefined,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: -100,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };

        try {
          tlsServer.setExtraOptions(tcpExtraOptions, async () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1800
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: undefined,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1900
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: false, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: undefined
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2000
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: undefined,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2100
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: -1
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2200
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 65536
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2300
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: undefined,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          });
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect().assertFail();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2400
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2500
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2600
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: true,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2700
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2800
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2900
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3000
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 100
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3100
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3100';

        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        await tlsServer.listen(listenOptions);
        const tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: undefined,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: -100,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3200
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: undefined,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3300
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: undefined,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3400
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: -1
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3500
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 65536
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3600
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: undefined,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          setExtraOptions = true;
          expect(setExtraOptions).assertTrue();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect().assertFail();
          done();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3700
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: false, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3800
     * @tc.desc Test and modify socketimeout,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 0
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3900
     * @tc.desc Test and modify reuseAddress,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 0
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0100
     * @tc.name ArKUIX_TLSSocketServer_GetState_0100
     * @tc.desc After the listen of TLSSocketServer is successful, get the TLSSocketServer status,
     * Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0200
     * @tc.name ArKUIX_TLSSocketServer_GetState_0200
     * @tc.desc Test the functionality of the GetState interface using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0300
     * @tc.name ArKUIX_TLSSocketServer_GetState_0300
     * @tc.desc The test callback parameter type is incorrect
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getState(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code},${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0400
     * @tc.name ArKUIX_TLSSocketServer_GetState_0400
     * @tc.desc The test callback parameter type is incorrect
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getState(null);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code},${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0500
     * @tc.name ArKUIX_TLSSocketServer_GetState_0500
     * @tc.desc The test did not pass in the callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const data: socket.SocketStateBase = await tlsServer.getState();
          console.info(`${caseName} state:`, JSON.stringify(data));
          expect(data != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error:${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0600
     * @tc.name ArKUIX_TLSSocketServer_GetState_0600
     * @tc.desc Get link status when key is empty,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutkey: socket.TLSSecureOptions = {
          key: '',
          cert: tlsSecureConfig.cert,
          ca: tlsSecureConfig.ca,
          password: tlsSecureConfig.password,
          protocols: tlsSecureConfig.protocols,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutkey,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0700
     * @tc.name ArKUIX_TLSSocketServer_GetState_0700
     * @tc.desc Get additional ip link status,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '127.0.0.1', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0800
     * @tc.name ArKUIX_TLSSocketServer_GetState_0800
     * @tc.desc Get TLSSocketServer link status (onconnect),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0900
     * @tc.name ArKUIX_TLSSocketServer_GetState_0900
     * @tc.desc Get TLSSocketServer link status (ca is empty),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutca: socket.TLSSecureOptions = {
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          ca: [],
          password: tlsSecureConfig.password,
          protocols: tlsSecureConfig.protocols,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutca,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_1000
     * @tc.name ArKUIX_TLSSocketServer_GetState_1000
     * @tc.desc Get TLSSocketServer link status (listen is not set),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_1000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Close_0100
     * @tc.name ArKUIX_TLSSocketServer_Close_0100
     * @tc.desc Test the functionality of the close interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Close_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let close = false;
        try {
          await tlsServer.close().then(() => {
            console.info(`close success`);
            close = true;
            expect(close).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.info(`close fail,code=${err.code}，message=${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketServer_Close_0300
     * @tc.name ArKUIX_TLSSocketServer_Close_0300
     * @tc.desc Call close after testing listen multiple times
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Close_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions_1: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        const listenOptions_2: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions_1).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        await tlsServer.listen(listenOptions_2).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        let close = false;
        try {
          await tlsServer.close().then(() => {
            console.info(`close success`);
            close = true;
            expect(close).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.info(`close fail,code=${err.code}，message=${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_0100
     * @tc.name ArKUIX_TLSSocketServer_Listen_0100
     * @tc.desc Test the normal scenario of the listen function and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0100';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_0200
     * @tc.name ArKUIX_TLSSocketServer_Listen_0200
     * @tc.desc Test the normal scenario of the listen function and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0200';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_0300
     * @tc.name ArKUIX_TLSSocketServer_Listen_0300
     * @tc.desc Test Options to null and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(null, (err: BusinessError) => {
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0400
     * @tc.name ArKUIX_TLSSocketServer_Listen_0400
     * @tc.desc Test Options to undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(undefined, (err: BusinessError) => {
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0500
     * @tc.name ArKUIX_TLSSocketServer_Listen_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, undefined);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0600
     * @tc.name ArKUIX_TLSSocketServer_Listen_0600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, null);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error:  ${err.code} ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0700
     * @tc.name ArKUIX_TLSSocketServer_Listen_0700
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_0800
     * @tc.name ArKUIX_TLSSocketServer_Listen_0800
     * @tc.desc Test Options to null and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(null).then(() => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0900
     * @tc.name ArKUIX_TLSSocketServer_Listen_0900
     * @tc.desc Test Options to undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(undefined).then(() => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1000
     * @tc.name ArKUIX_TLSSocketServer_Listen_1000
     * @tc.desc The test address is "", and the callback asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "",
          port: 8088,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };

        const isAndroid = true;
        let listen = false;
        try {
          await new Promise<void>((resolve, reject) => {
            tlsServer.listen(listenOptions, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                if (isiOS && err.code === 2303105) {
                  const errCode = Number(err.code);
                  expect(errCode === 2303105).assertTrue();
                  done();
                  return;
                }
                if (isAndroid) {
                  expect().assertFail();
                } else {
                  const errCode = Number(err.code);
                  expect(errCode === 2303197).assertTrue();
                }
                reject(err);
              } else {
                listen = true;
                expect(listen).assertTrue();
                resolve();
              }
            });
          });
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          if (isAndroid) {
            expect().assertFail();
          } else {
            const errCode = Number(error.code);
            expect(errCode === 2303197 || errCode === 2103105).assertTrue();
          }
          done();
        }
        setTimeout(() => {
          tlsServer.close();
        }, 100);
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1100
     * @tc.name ArKUIX_TLSSocketServer_Listen_1100
     * @tc.desc The test address is "11111", and the callback asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "111111",
          port: 8088,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        tlsServer.listen(listenOptions, (err: BusinessError) => {
          if (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_REQUEST_ADDRESS_ERROR || errCode === ERR_EIO).assertTrue();
            tlsServer?.close();
            done();
          } else {
            expect().assertFail();
            done();
          }
        })
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1200
     * @tc.name ArKUIX_TLSSocketServer_Listen_1200
     * @tc.desc When the test port is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "127.0.0.1",
          port: undefined,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_1300
     * @tc.name ArKUIX_TLSSocketServer_Listen_1300
     * @tc.desc To test that family is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "127.0.0.1",
          port: 8080,
          family: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_1400
     * @tc.name ArKUIX_TLSSocketServer_Listen_1400
     * @tc.desc The test address is "", and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "",
          port: 8080,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        const isAndroid = true;
        let listen = false;
        try {
          await new Promise<void>((resolve, reject) => {
            tlsServer.listen(listenOptions).then(() => {
              listen = true;
              expect(listen).assertTrue();
              resolve();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              if (isiOS && err.code === 2303105) {
                const errCode = Number(err.code);
                expect(errCode === 2303105).assertTrue();
                done();
                return;
              }
              if (isAndroid) {
                expect().assertFail();
              } else {
                const errCode = Number(err.code);
                expect(errCode === 2303197 || 2303105).assertTrue();
              }
              reject(err);
            });
          });
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          if (isAndroid) {
            expect().assertFail();
          } else {
            const errCode = Number(error.code);
            expect(errCode === 2303197 || 2303105).assertTrue();
          }
          done();
        }
        setTimeout(() => {
          tlsServer.close();
        }, 100);
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1500
     * @tc.name ArKUIX_TLSSocketServer_Listen_1500
     * @tc.desc The test address is "11111", and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "11111",
          port: 8088,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        tlsServer.listen(listenOptions).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_REQUEST_ADDRESS_ERROR || errCode === ERR_EIO).assertTrue();
          done();
        }).finally(() => {
          if (tlsServer) {
            tlsServer.close();
          }
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1600
     * @tc.name ArKUIX_TLSSocketServer_Listen_1600
     * @tc.desc Test port as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "0.0.0.0",
          port: undefined,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_1700
     * @tc.name ArKUIX_TLSSocketServer_Listen_1700
     * @tc.desc To test that family is undefined, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "0.0.0.0",
          port: 8080,
          family: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_1800
     * @tc.name ArKUIX_TLSSocketServer_Listen_1800
     * @tc.desc When the test ca is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_1900
     * @tc.name ArKUIX_TLSSocketServer_Listen_1900
     * @tc.desc Test ca as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2000
     * @tc.name ArKUIX_TLSSocketServer_Listen_2000
     * @tc.desc Test that cert is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.key,
          key: tlsSecureConfig.key,
          cert: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2100
     * @tc.name ArKUIX_TLSSocketServer_Listen_2100
     * @tc.desc Test that cert is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2200
     * @tc.name ArKUIX_TLSSocketServer_Listen_2200
     * @tc.desc Test that key is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2300
     * @tc.name ArKUIX_TLSSocketServer_Listen_2300
     * @tc.desc Test that key is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2400
     * @tc.name ArKUIX_TLSSocketServer_Listen_2400
     * @tc.desc Test that password is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2500
     * @tc.name ArKUIX_TLSSocketServer_Listen_2500
     * @tc.desc Test that password is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2600
     * @tc.name ArKUIX_TLSSocketServer_Listen_2600
     * @tc.desc Test protocols is TLSv12 using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2600';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2700
     * @tc.name ArKUIX_TLSSocketServer_Listen_2700
     * @tc.desc Test protocols is TLSv13 using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv13,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2800
     * @tc.name ArKUIX_TLSSocketServer_Listen_2800
     * @tc.desc Test protocol is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_2900
     * @tc.name ArKUIX_TLSSocketServer_Listen_2900
     * @tc.desc The test protocols are TLSv12, and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2900';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3000
     * @tc.name ArKUIX_TLSSocketServer_Listen_3000
     * @tc.desc The test protocols are TLSv13, and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv13,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3100
     * @tc.name ArKUIX_TLSSocketServer_Listen_3100
     * @tc.desc Test protocols as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: undefined,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3200
     * @tc.name ArKUIX_TLSSocketServer_Listen_3200
     * @tc.desc Test that useRemoteCipherPrefer is true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3200';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3300
     * @tc.name ArKUIX_TLSSocketServer_Listen_3300
     * @tc.desc Test that useRemoteCipherPrefer is false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: false,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3400
     * @tc.name ArKUIX_TLSSocketServer_Listen_3400
     * @tc.desc Test that useRemoteCipherPrefer is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: undefined,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3500
     * @tc.name ArKUIX_TLSSocketServer_Listen_3500
     * @tc.desc Test that useRemoteCipherPrefer is true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3500';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3600
     * @tc.name ArKUIX_TLSSocketServer_Listen_3600
     * @tc.desc Test that useRemoteCipherPrefer is false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: false,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3700
     * @tc.name ArKUIX_TLSSocketServer_Listen_3700
     * @tc.desc Test that useRemoteCipherPrefer is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: undefined,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3800
     * @tc.name ArKUIX_TLSSocketServer_Listen_3800
     * @tc.desc Test that signatureAlgorithms is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: undefined,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_3900
     * @tc.name ArKUIX_TLSSocketServer_Listen_3900
     * @tc.desc Test that signatureAlgorithms is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: undefined,
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4000
     * @tc.name ArKUIX_TLSSocketServer_Listen_4000
     * @tc.desc Test that cipherSuite is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4000';
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
          cipherSuite: undefined,
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
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4100
     * @tc.name ArKUIX_TLSSocketServer_Listen_4100
     * @tc.desc Test that cipherSuite is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4100';
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
          cipherSuite: undefined,
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4200
     * @tc.name ArKUIX_TLSSocketServer_Listen_4200
     * @tc.desc Test the two-way authentication as true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4200';
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
          isBidirectionalAuthentication: true
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4300
     * @tc.name ArKUIX_TLSSocketServer_Listen_4300
     * @tc.desc Test the two-way authentication as false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4300';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4400
     * @tc.name ArKUIX_TLSSocketServer_Listen_4400
     * @tc.desc Test the two-way authentication as undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4400';
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
          isBidirectionalAuthentication: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code == undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4500
     * @tc.name ArKUIX_TLSSocketServer_Listen_4500
     * @tc.desc Test the two-way authentication as true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4500';
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
          isBidirectionalAuthentication: true
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4600
     * @tc.name ArKUIX_TLSSocketServer_Listen_4600
     * @tc.desc Test the two-way authentication as false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4600';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_4700
     * @tc.name ArKUIX_TLSSocketServer_Listen_4700
     * @tc.desc Test the two-way authentication as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4700';
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
          isBidirectionalAuthentication: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code == undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4800
     * @tc.name ArKUIX_TLSSocketServer_Listen_4800
     * @tc.desc Test that ALPNProtocols is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: undefined,
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4900
     * @tc.name ArKUIX_TLSSocketServer_Listen_4900
     * @tc.desc Test that ALPNProtocols is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4900';
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
          ALPNProtocols: undefined,
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5000
     * @tc.name ArKUIX_TLSSocketServer_Listen_5000
     * @tc.desc Test that skipRemoteValidation is true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5000';
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
          skipRemoteValidation: true,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_5100
     * @tc.name ArKUIX_TLSSocketServer_Listen_5100
     * @tc.desc Test that skipRemoteValidation is false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5100';
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
          skipRemoteValidation: false,
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_5200
     * @tc.name ArKUIX_TLSSocketServer_Listen_5200
     * @tc.desc Test that skipRemoteValidation is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5200';
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
          skipRemoteValidation: undefined
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5300
     * @tc.name ArKUIX_TLSSocketServer_Listen_5300
     * @tc.desc Test that skipRemoteValidation is true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5300';
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
          skipRemoteValidation: true
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_5400
     * @tc.name ArKUIX_TLSSocketServer_Listen_5400
     * @tc.desc Test that skipRemoteValidation is false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5400';
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
          skipRemoteValidation: false
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_5500
     * @tc.name ArKUIX_TLSSocketServer_Listen_5500
     * @tc.desc Test that skipRemoteValidation is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5500';
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
          skipRemoteValidation: undefined
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5600
     * @tc.name ArKUIX_TLSSocketServer_Listen_5600
     * @tc.desc Test the timeout to be 1000(a valid value) and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5600';
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
     * @tc.number ArKUIX_TLSSocketServer_Listen_5700
     * @tc.name ArKUIX_TLSSocketServer_Listen_5700
     * @tc.desc Test timeout to -1(illegal value) and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5700';
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
  })
}