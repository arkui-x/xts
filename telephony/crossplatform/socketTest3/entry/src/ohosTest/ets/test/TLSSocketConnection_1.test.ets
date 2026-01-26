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

const ERR_CODE_PARAMETER_ERROR = 401;

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

export default function TLSSocketConnection_1Test() {
  describe('TLSSocketConnection_1Test', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Send_0100
     * @tc.name ArKUIX_TLSSocketConnection_Send_0100
     * @tc.desc Sending data through TLSSocketServer connection .Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('Hello, TLSSocket Client!', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"Hello, TLSSocket Client!"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0200
     * @tc.name ArKUIX_TLSSocketConnection_Send_0200
     * @tc.desc Sending data through TLSSocketServer connection. Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        const sendArray = new Uint8Array([72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121]);
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  const dataToSend = sendArray.buffer;
                  clientConn.send(dataToSend, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:
                      "72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0300
     * @tc.name ArKUIX_TLSSocketConnection_Send_0300
     * @tc.desc When the test data is null, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = null;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send null fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send null success`);
                      expect().assertFail();
                      rejectInner(new Error('Should have failed'));
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0400
     * @tc.name ArKUIX_TLSSocketConnection_Send_0400
     * @tc.desc When the test data is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = undefined;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send null fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send null success`);
                      expect().assertFail();
                      rejectInner(new Error('Should have failed'));
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0500
     * @tc.name ArKUIX_TLSSocketConnection_Send_0500
     * @tc.desc Sending data through TLSSocketServer connection(data is '')
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = '';
                  let send = false;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send empty data fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send empty data success`);
                      expect().assertFail();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send empty data failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0600
     * @tc.name ArKUIX_TLSSocketConnection_Send_0600
     * @tc.desc Sending data through TLSSocketServer connection(send long message)
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('11111', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"11111"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0700
     * @tc.name ArKUIX_TLSSocketConnection_Send_0700
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!', null);
                    console.error(`${caseName} ERROR: Should have thrown exception when second param is null`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.info(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0800
     * @tc.name ArKUIX_TLSSocketConnection_Send_0800
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!', undefined);
                    console.error(`${caseName} ERROR: Should have thrown exception when second param is undefined`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.info(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0900
     * @tc.name ArKUIX_TLSSocketConnection_Send_0900
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!');
                    console.error(`${caseName} Should have thrown exception when second param is empty`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.info(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1000
     * @tc.name ArKUIX_TLSSocketConnection_Send_1000
     * @tc.desc Sending data through TLSSocketServer connection. Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let send = false;
              clientConn.send('Hello, TLSSocket Client!').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:"Hello, TLSSocket Client!"`);
                send = true;
                expect(send).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1100
     * @tc.name ArKUIX_TLSSocketConnection_Send_1100
     * @tc.desc Sending data through TLSSocketServer connection.Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        const sendArray = new Uint8Array([72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121]);
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  const dataToSend = sendArray.buffer;
                  clientConn.send(dataToSend).then(() => {
                    console.info(`${caseName} send Array，Promise then trigger: Array data:${Array.from(sendArray)}`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} send Array fail，Promise catch error: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1200
     * @tc.name ArKUIX_TLSSocketConnection_Send_1200
     * @tc.desc When the test data is null, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              try {
                clientConn.send(null).then(() => {
                  console.info(`${caseName} send null data success，Promise then promise`);
                  expect().assertFail();
                  done();
                })
              } catch (err) {
                console.error(`${caseName} send call exception:${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1300
     * @tc.name ArKUIX_TLSSocketConnection_Send_1300
     * @tc.desc When the test data is undefined, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              try {
                clientConn.send(undefined).then(() => {
                  console.info(`${caseName} send null data success，Promise then promise`);
                  expect().assertFail();
                  done();
                })
              } catch (err) {
                console.error(`${caseName} send call exception:${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1400
     * @tc.name ArKUIX_TLSSocketConnection_Send_1400
     * @tc.desc Sending data through TLSSocketServer connection(data is '')
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              clientConn.send('').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:" "`);
                expect().assertFail();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1500
     * @tc.name ArKUIX_TLSSocketConnection_Send_1500
     * @tc.desc Sending data through TLSSocketServer connection(send long message)
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let send = false;
              clientConn.send('11111').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:"11111"`);
                send = true;
                expect(send).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1600
     * @tc.name ArKUIX_TLSSocketConnection_Send_1600
     * @tc.desc Sending data through TLSSocketServer connection(Send the normal data again after
     * the send content is empty) Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const emptyData = '';
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} first send empty data fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                    } else {
                      console.info(`${caseName} first send empty data success,data is empty`);
                      expect().assertFail();
                    }
                    resolveInner();
                  });
                });
              })().then(() => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const normalData = 'Hello, TLSSocket Client!';
                  clientConn.send(normalData, (err: BusinessError) => {
                    let send = false;
                    if (err) {
                      console.error(`${caseName} second send empty data fail,error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} second send empty data success,data is empty"${normalData}"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              }).then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1700
     * @tc.name ArKUIX_TLSSocketConnection_Send_1700
     * @tc.desc Sending data through TLSSocketServer connection(repetition send long message)
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const firstData = 'Hello, TLSSocket Client!';
              (async (): Promise<void> => {
                clientConn.send(firstData, (err: BusinessError) => {
                  if (err) {
                    console.error(`${caseName} first send empty data fail,error: ${err.code} - ${err.message}`);
                  } else {
                    console.info(`${caseName} first send empty data success,data is empty`);
                  }
                });
              })().then(() => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const secondData = 'again:Hello, TLSSocket Client!';
                  clientConn.send(secondData, (err: BusinessError) => {
                    let send = false;
                    if (err) {
                      console.error(`${caseName} second send empty data fail,error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} second send empty data success,data is empty"${secondData}"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              }).then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1800
     * @tc.name ArKUIX_TLSSocketConnection_Send_1800
     * @tc.desc Sending data through TLSSocketServer connection(Send the normal data again after the send
     * content is empty) Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const emptyData = '';
              const normalData = 'Hello,TLSSocketClient!';
              (async (): Promise<void> => {
                await clientConn.send(emptyData);
                console.info(`${caseName} first send empty data success,Promise then trigger:data is empty`);

                await clientConn.send(normalData);
                console.info(`${caseName} second send normal data success,Promise then,data：${normalData}`);
              })().catch((err: BusinessError) => {
                console.error(`${caseName} send data fail,Promise catch error: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1900
     * @tc.name ArKUIX_TLSSocketConnection_Send_1900
     * @tc.desc Sending data through TLSSocketServer connection(twice Send)
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const firstData = 'Hello, TLSSocket Client!';
              const secondData = 'again:Hello, TLSSocket Client!';
              let send = false;
              (async (): Promise<void> => {
                await clientConn.send(firstData);
                console.info(`${caseName} first send empty data success,Promise then trigger:data is empty`);

                await clientConn.send(secondData);
                console.info(`${caseName} second send normal data success,Promise then,data：${secondData}`);
                send = true;
                expect(send).assertTrue();
                done();
              })().catch((err: BusinessError) => {
                console.error(`${caseName} send data fail,Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_2000
     * @tc.name ArKUIX_TLSSocketConnection_Send_2000
     * @tc.desc Do not monitor the service for testing,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_2000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            port: 11011
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
            port: 11011
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
            console.info(`${caseName} Client connection detected (this should not happen)`);
            const testData = 'Hello, TLSSocket Client!';
            clientConn.send(testData).then(() => {
              console.info(`${caseName} send data success (unexpected)`);
              expect().assertFail();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} send data fail: ${err.code} - ${err.message}`);
              expect().assertFail();
              done();
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
            try {
              await tlsClient.connect(connectOptions);
              console.info(`${caseName} connect successfully (unexpected)`);
            } catch (err) {
              const error = err as BusinessError;
              console.error(`${caseName} connect fail: ${error.code} - ${error.message}`);
              const errCode = Number(err.code);
              expect(errCode === 2303501).assertTrue;
              done();
            }
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
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Send_2100
     * @tc.name ArKUIX_TLSSocketConnection_Send_2100
     * @tc.desc Send an empty ip,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_2100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            address: '',
            port: 12012
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
            port: 12012
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
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
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('Hello, TLSSocket Client!', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"Hello, TLSSocket Client!"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
                done();
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  const errCode = Number(err.code);
                  expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_Close_0100
     * @tc.desc Test the functionality of the close interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let close = false;
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.close((err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} connect close fail,error: ${err.code} - ${err.message}`);
                      expect().assertFalse();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} connect close success,callback trigger`);
                      close = true;
                      expect(close).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Connect close failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_Close_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              try {
                clientConn.close(null);
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_Close_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              try {
                clientConn.close(undefined);
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
                const errCode = Number(err.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0400
     * @tc.name ArKUIX_TLSSocketConnection_Close_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              let close = false;
              try {
                clientConn.close();
                close = true;
                expect(close).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
                expect().assertFail();
                done();
              }
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0500
     * @tc.name ArKUIX_TLSSocketConnection_Close_0500
     * @tc.desc Test the functionality of the close interface function using the prommise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let close = false;
                  clientConn.close().then(() => {
                    console.info(`${caseName} connect close success,callback trigger`);
                    close = true;
                    expect(close).assertTrue();
                    resolveInner();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect close fail,error: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    rejectInner(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Connect close failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0100
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteAddress((err: BusinessError, remoteAddr: socket.NetAddress) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote address,error:
                      ${err.code} - ${err.message}`);
                      expect().assertFail();
                      reject(err);
                    } else {
                      console.info(`${caseName} remote address was successfully obtained，address:
                      ${JSON.stringify(remoteAddr)}`);
                      expect(remoteAddr != undefined).assertTrue();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                try {
                  clientConn.getRemoteAddress(undefined);
                  console.info(`${caseName} no error`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  const errCode = Number(error.code);
                  expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                try {
                  clientConn.getRemoteAddress(null);
                  console.info(`${caseName} no error`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  const errCode = Number(error.code);
                  expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                let getRemoteAddress = false;
                try {
                  clientConn.getRemoteAddress();
                  console.info(`${caseName} no error`);
                  getRemoteAddress = true;
                  expect(getRemoteAddress).assertTrue();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  expect().assertFail();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0500
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                    console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                    ${JSON.stringify(remoteAddr)}`);
                    expect(remoteAddr != undefined).assertTrue();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} fail to obtain remote address,promise catch error:
                    ${err.code} - ${err.message}`);
                    expect(true).assertFalse();
                    reject(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
                done();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0600
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0600
     * @tc.desc Test the interface before listen,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
                console.info(`${caseName} Client connection detected`);
                (async (): Promise<void> => {
                  return new Promise<void>((resolve, reject) => {
                    clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                      console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                       ${JSON.stringify(remoteAddr)}`);
                      expect().assertFail();
                      resolve();
                    }).catch((err: BusinessError) => {
                      console.error(`${caseName} fail to obtain remote address,promise catch error:
                       ${err.code} - ${err.message}`);
                      expect().assertFail();
                      reject(err);
                    });
                  });
                })().then(() => {
                  done();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
                  done();
                });
              });

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
              const errCode = Number(err.code);
              expect(errCode === 2303501).assertTrue();
              done();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0700
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0700
     * @tc.desc Ca is empty,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 20000
          };
          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 20000
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: '',
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: '',
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
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
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                    console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                     ${JSON.stringify(remoteAddr)}`);
                    expect().assertFail();
                    resolveInner();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} fail to obtain remote address,promise catch error:
                    ${err.code} - ${err.message}`);
                    expect().assertFail();
                    rejectInner(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
                done();
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
                const errCode = Number(err.code);
                expect(errCode === 2303501).assertTrue();
                done();
              });
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
  })
}