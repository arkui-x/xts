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
import { common } from '@kit.AbilityKit';

import deviceInfo from '@ohos.deviceInfo';

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");

const ERR_CODE_PARAMETER_ERROR = 401;
const ERR_NET_BAD_FILE_DESCRIPTOR = 2301009;
const ERR_CODE_CERT_ERROR = -1;
const ERR_CODE_BIND_ERROR = 2303600;

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

export default function TLSSocketServerTest1() {
  describe('TLSSocketServerTest1', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetLocalAddress_0100
     * @tc.name ArKUIX_TLSSocketServer_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetLocalAddress_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
          console.info("Get success: " + JSON.stringify(localAddress));
          expect(localAddress != null).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetSocketFd_0100
     * @tc.name ArKUIX_TLSSocketServer_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetSocketFd_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: 14501
        };
        const tlsConnectOptions: socket.TLSConnectOptions = {
          address: netAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["spdy/1", "http/1.1"],
        };
        await tlsServer.listen(tlsConnectOptions);
        try {
          tlsServer.getSocketFd().then((data: number) => {
            console.info("Get success: " + JSON.stringify(data));
            expect(data >= 0).assertTrue();
            tlsServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            tlsServer.close();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          tlsServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0100
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0100
     * @tc.desc Get the communication protocol version,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getProtocol((err: BusinessError, data: string) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getProtocol result: ${data}`);
              expect(data == 'TLSv1.2').assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          ;
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0200
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0200
     * @tc.desc Get the communication protocol version,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getProtocol().then((protocol: string) => {
          console.info(`${caseName} getProtocol result: ${protocol}`);
          expect(protocol == 'TLSv1.2').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        })
      });


    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0300
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8081 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0400
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0500
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0500
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const getProtocol: string = await tlsServer.getProtocol();
          console.info(`${caseName} getProtocol result: ${getProtocol}`);
          expect(getProtocol == 'TLSv1.2').assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0600
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0600
     * @tc.desc Verify that other ip can obtain the protocol version successfully,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '127.1.1.1333', port: 8086 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };
        await tlsServer.listen(listenOptions).then(() => {
          console.info("listen callback success");
        }).catch((err: BusinessError) => {
          console.error("failed: " + JSON.stringify(err));
          (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              try {
                tlsServer?.getProtocol((err: BusinessError, data: string) => {
                  if (isiOS && err.code === 2303105) {
                    expect().assertTrue();
                    done();
                    return;
                  }
                  if (err) {
                    console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                    expect().assertFail();
                  } else {
                    console.info(`${caseName} getProtocol result: ${data}`);
                    expect(data == 'TLSv1.2').assertTrue();
                    done();
                  }
                })
              } catch (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
              }
            });
          })().then(async () => {
            console.info(`${caseName} success: got expected error code ${ERR_NET_BAD_FILE_DESCRIPTOR}`);
          }).catch((err: BusinessError) => {
            console.error(`${caseName} fail:` + JSON.stringify(err));
            expect().assertFail();
            done();
          });
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0700
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0700
     * @tc.desc Do not configure the protocol version,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutProtocol: socket.TLSSecureOptions = {
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          ca: tlsSecureConfig.ca,
          password: tlsSecureConfig.password,
          protocols: undefined,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8086 } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutProtocol,
          ALPNProtocols: ["http/1.1"],
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol((err: BusinessError, data: string) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getProtocol result: ${data}`);
              expect(data === 'TLSv1.3').assertTrue();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0100
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0100
     * @tc.desc Test to obtain a certificate,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getCertificate result: ${data}`);
              expect(data != null).assertTrue();
              done();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          }
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0200
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getCertificate(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0300
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getCertificate(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0400
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const getCertificate: socket.X509CertRawData = await tlsServer.getCertificate();
          expect(getCertificate != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0500
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0500
     * @tc.desc Test to obtain a certificate,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          console.info(`${caseName} getCertificate result: ${data}`);
          expect(data != null).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done()
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0600
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0600
     * @tc.desc The test returned an error code 401,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        let ca_common3: string[] = [];

        interface TLSSecureOptions {
          ca: string[];
          key: string;
          password: string;
          cert: string;
          protocols: socket.Protocol[];
          useRemoteCipherPrefer: boolean;
          signatureAlgorithms: string;
          cipherSuite: string;
        }

        let tlsConnectOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8083 } as socket.NetAddress,
          secureOptions: {
            ca: ca_common3,
            key: '',
            password: '12345',
            cert: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          } as TLSSecureOptions,
          ALPNProtocols: ["spdy/1", "http/1.1"]
        };
        await tlsServer.listen(tlsConnectOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          console.info('result' + JSON.stringify(err.code));
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_CERT_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0700
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0700
     * @tc.desc Other port interface testing,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 30000 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        await tlsServer.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(data !== null).assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0800
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0800
     * @tc.desc Open on and off before testing,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8080 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        let callback: Callback<socket.TLSSocketConnection> = (data: socket.TLSSocketConnection) => {
        }
        tlsServer.on('connect', callback);
        tlsServer.off('connect');
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          expect(data !== null).assertTrue();
          console.info('result' + JSON.stringify(data))
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0900
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0900
     * @tc.desc Do not monitor the service,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          expect(data != null).assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_BIND_ERROR).assertTrue();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_1000
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_1000
     * @tc.desc Set other configuration items,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_1000';
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
          OOBInline: true,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 30000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.info('fail to listen' + err.code.toString());
        });
        await tlsServer.setExtraOptions(tcpExtraOptions).catch((err: BusinessError) => {
          console.info('fail to setExtraOptions' + err.code.toString());
        });
        await tlsServer.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getCertificate result: ${data}`);
              expect(data !== null).assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0100
     * @tc.desc Set other properties of the TLSSocketServer connection,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0100';
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
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0200
     * @tc.desc Set other properties of the TLSSocketServer connection,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0200';
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
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0300
     * @tc.desc Test Options to null and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: 8082 } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(undefined, (err: BusinessError) => {
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
  })
}