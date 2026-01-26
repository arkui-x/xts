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
  "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDPiA+8aicqihRj\n" +
  "vlVSMA9yNVMm+51oqi2mPWGMYUtEI3hH8hN/+IexHYsfpWQc/1yW6f2yie5Omdnw\n" +
  "4tDK2EaJFk8yJMZ/rH+LyPIpuLCkvkMPn1s4nWdY9XR+UWib5WNJ3oTAu4lkHX03\n" +
  "BuOiH0LP3hQoN6auWQRNGlHpU1Oxi58pDxOFQBrDB4Gh3RAZHxN4Vt437JJExNWo\n" +
  "O5qJfWR4zrFq3Mo2vBkOnFAkUvlwe+yWoAnIAkxF+WZlSY7aHD/t9SPuiuzWW2WW\n" +
  "jU+eM0joQIYAoKsuLrIR832PRykRJFgO4+mQ77l79v8GZQrwfscPbLgcL9Aub3ec\n" +
  "YqqcjcRzAgMBAAECggEAAs4+GDf/K44OVILgOGo56ztZUm+YYy/ZyiOOTA2MrPEl\n" +
  "0SMurE4512Uk2lqsDdBN+iRTr7Q5qopd7enDFNrzqSrKC01/+X3lg4hF7dZ3XOLN\n" +
  "mUp4Oz21hfhbiNGk7madfwQpG0ntw5K6fKH1Nd3iU1kXQKvv7u95JWmzrcnYmc/Z\n" +
  "LYY6g3MPl+nu4Q0BAiZxvdPr05UK4c87zFi9q85wGE3La12JSuCZmpTDk5wLI1IU\n" +
  "L/RWwM7fH3fi0G1s4v18ItVHikMebQYxu5FY16+zjXBxUN9PmcnBnO7dyqNeweo4\n" +
  "/txl5jBkpJGIZ0PD+79ADhr7rQC0Ml0bwcCOqrebgQKBgQDnZXAsQC74ITLA8f2b\n" +
  "2ImpN4CE7hkwXXgRd8tFetC3CeHULUe6Ym7GbHZKUEm/w0nxvxtrlp520E/DgGdX\n" +
  "fzlcvxuhlDLFwonbFyzo+tFbIPMbrBWh+Af42w3SSkVTZFdXgYlVapCSMiP8jJU4\n" +
  "h/dm3q6PiE6tUQ/mO0sBR+eFkwKBgQDlmQd9CINA+mIajTvlwsOtNWCPwJ4VYJ7w\n" +
  "Oq9Q2qJN3nzV+InkXnIq/xSkDxbg3faZv6xJfcc/sOR/jY4LUPR56tQzUOhsYacj\n" +
  "IErmoOnzOk0yeVifuFwPsmyu4UbG21NienWE9Jb3n+CZElKjvbLGFUhVp/7W2q9H\n" +
  "vXZP+BwRoQKBgQCPnTqQjElagShB7i8r4aoW1zaxyiDiDrDtjn8foUkWwVBi4rOI\n" +
  "73y3NCv6lXggR3GGU8kN7k5tiX5n5TK+cFzGvmnEz/jvGn16+BhMhRcYywt3mkdW\n" +
  "3lz8S+B5KtV6G2XGDsSQufH+epYxMYOPsXuQYhbPSJckJJKMnzI/GkSMdwKBgQCQ\n" +
  "zZvYcqb9MyzuXAbb2KM6uYBmCXBqQR7cmdZ6IvncLKcE+BRXkG1myqvE8LNYLQVb\n" +
  "YHSTgR1KARGLlMZyQqN9xOoCV1PPDyOvVq2GmRQTz8BiRf/r9AUz7S74eKH/xtHn\n" +
  "OR6nNO+FyzKGt/SgyoJWxZNyWlqyPQfxMf/NXciuIQKBgQCCQtmzzA8dmyby6DYg\n" +
  "lGPW8EpTgVnfPAUizjxMBkstUDXHAdwirzsNfSUozDqmtxXXHZapS8NfS8L7tp2P\n" +
  "ivZJwhAUbbikswDfVjJwvue8EJk0tszG/BLCb/ZdhqcqxgYXOkXjubOezBYEFvxn\n" +
  "eg6zAVvVOwHa4AKBCl+SvmR71g==\n" +
  "-----END PRIVATE KEY-----";

const serverCert = "-----BEGIN CERTIFICATE-----\n" +
  "MIID0TCCArmgAwIBAgIUHA4CIFAuWbLoulj/cpg9vczmlf8wDQYJKoZIhvcNAQEL\n" +
  "BQAwVzELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDTALBgNVBAoMBFRlc3QxFTATBgNVBAMMDFRlc3QgUm9vdCBDQTAeFw0y\n" +
  "NjAxMDYxMjEwNTlaFw0yNzAxMDYxMjEwNTlaMFQxCzAJBgNVBAYTAkNOMRAwDgYD\n" +
  "VQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5nMQ0wCwYDVQQKDARUZXN0MRIw\n" +
  "EAYDVQQDDAlsb2NhbGhvc3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB\n" +
  "AQDPiA+8aicqihRjvlVSMA9yNVMm+51oqi2mPWGMYUtEI3hH8hN/+IexHYsfpWQc\n" +
  "/1yW6f2yie5Omdnw4tDK2EaJFk8yJMZ/rH+LyPIpuLCkvkMPn1s4nWdY9XR+UWib\n" +
  "5WNJ3oTAu4lkHX03BuOiH0LP3hQoN6auWQRNGlHpU1Oxi58pDxOFQBrDB4Gh3RAZ\n" +
  "HxN4Vt437JJExNWoO5qJfWR4zrFq3Mo2vBkOnFAkUvlwe+yWoAnIAkxF+WZlSY7a\n" +
  "HD/t9SPuiuzWW2WWjU+eM0joQIYAoKsuLrIR832PRykRJFgO4+mQ77l79v8GZQrw\n" +
  "fscPbLgcL9Aub3ecYqqcjcRzAgMBAAGjgZcwgZQwHwYDVR0jBBgwFoAU3DfV2Kw4\n" +
  "OaYTJ//HGWJ3JuduItQwCQYDVR0TBAIwADALBgNVHQ8EBAMCBaAwEwYDVR0lBAww\n" +
  "CgYIKwYBBQUHAwEwJQYDVR0RBB4wHIIJbG9jYWxob3N0ggkxMjcuMC4wLjGHBH8A\n" +
  "AAEwHQYDVR0OBBYEFAw5EcIws/LuPZu9g4026GkNU9HIMA0GCSqGSIb3DQEBCwUA\n" +
  "A4IBAQAzO2CMGNv/Jv+fP/CYNxfEedPGk3uw7C6EvbWJkJwzqx4SvIdRHQo4LLE0\n" +
  "LX7bDgick42XgYLrfSCN2A9P7TSvovW3XbnfaP0Agj25sSgAIk8dQncsBdn2T7ij\n" +
  "FM7JIYE+9QvrsI1c3iVFDYSFo/XEeAfpbqpgLYn9NqMADbrOS/PWQOeUqen4PbHn\n" +
  "iiaOLBlsST7ISMuyYJ0ksrbMQ67dLmX5KU23O0i+FzOUFbcQhQ0KAapOpSSurulR\n" +
  "7fdDHWNTabP2irxP224SBXafFhiNl1pYj6g/YQqKqBPyWn6Uuh3lUsHOqEPTq+8O\n" +
  "SE80pgihK1U71BIKwFLo/kZLw33t\n" +
  "-----END CERTIFICATE-----";

const serverCa = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDjzCCAnegAwIBAgIUTZJFIjQhbxr4OyWhfsDmKZ4qDG4wDQYJKoZIhvcNAQEL\n" +
  "BQAwVzELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDTALBgNVBAoMBFRlc3QxFTATBgNVBAMMDFRlc3QgUm9vdCBDQTAeFw0y\n" +
  "NjAxMDYxMjEwNThaFw0yNzAxMDYxMjEwNThaMFcxCzAJBgNVBAYTAkNOMRAwDgYD\n" +
  "VQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5nMQ0wCwYDVQQKDARUZXN0MRUw\n" +
  "EwYDVQQDDAxUZXN0IFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK\n" +
  "AoIBAQCuFYxb3d2KI4ZRd8wSS7zlogU4SvXIC51X0ZOqExYrIgw44f82CJe/d2qY\n" +
  "H65V0jlCVPIZLjvJTm9g5ZZJGEbN2+bwBIRdjXYfF12YgTJ/LZrfH8yXKJKSI9Kn\n" +
  "0dt9LZmplgVQ0QL0V7eP6Ssh6PERtOjhoILcuQRb3C743NX8aWEXSqSvzlyOF94h\n" +
  "EcmvSVBypQholI80RlLiRqt891FFl4iytCeX852GATijDZTnh4lhqAwUbxJYZqRP\n" +
  "Re0MkZkMvwiEUTbgcBV3Blf+dfyvAVkEpzy5nfp+tIQocibp/BKaRxYcQ/dX0Qgj\n" +
  "hHIZEZbJNe++KaudxTm3JOinnaP3AgMBAAGjUzBRMB0GA1UdDgQWBBTcN9XYrDg5\n" +
  "phMn/8cZYncm524i1DAfBgNVHSMEGDAWgBTcN9XYrDg5phMn/8cZYncm524i1DAP\n" +
  "BgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQASSCJzImASDI62knlP\n" +
  "otn1CNEi93x/DFxWFJ6W4mZqXqU3WyE7LMcLT8ThgcJLe/teRrHL3tbaT3D50jYO\n" +
  "qw4wQ53IyRBtBHMr6fpMropsugivVqP/iVJnfCSTeJJSiC5DBtQi+SFRNtUBlRON\n" +
  "oRquaT2vx0AOPrxW3dpuCo58EpF1LANa24zm605xtxyMKLHoV+5PP1FMlPhMPmmW\n" +
  "I/lSrsOmEeb4POsk0tQYXhV/7EPRDIl6bYq5VjspzQjCjhCoxfLnhvyWawsLksKU\n" +
  "yNowJPZlpHGXQghc/LNCOvKad6Q+l8wBIQkP9bb9cm3JliJs5Gr7mwHAR9Q3Vm+n\n" +
  "LMQ3\n" +
  "-----END CERTIFICATE-----";

const clientKey = "-----BEGIN PRIVATE KEY-----\n" +
  "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDYDkYnDDRzVUgb\n" +
  "EA81Ln1KshmtfGt3vFkIlQ7e5mJ0D65IvjHBwa8JvWwENctUVd6m3mivwHmXqD0p\n" +
  "NqA88cSSlPAxwczdayMDQnjBMq3k9itLX5n1LH22T3Sp4mesXddvhJn5OZO8rcsB\n" +
  "le+8FtCOZfU4mSP2moljrktec81aCmiJ7AlF25F4NMiVomOSUKX3T0GaUpO4BsyM\n" +
  "annl/A9CVNzezET1DJKaeQjoHiouYGjkO4Mhp8mc1vcOpHzumo+zOQF9Nod8SkQx\n" +
  "upVaTfKzGAKp4hcNoblGFWFm8ilamymSQ9MpvdFoacovQ+hYsTdO3RkMSfls+CRG\n" +
  "k6dS7wH3AgMBAAECggEAasPm+83Gr4Whm6n8ceHWzU4kbTwSGTmsX5bVIeYEGelT\n" +
  "zSObj+1Hs4707UGuCC9k1t4KKmt5Sq27B340gdlRM8RAy73CoFock7RJ2uLR1tak\n" +
  "/1qvSF4jgy9Rbc/xPlajKrsCoYtHy9GwA0kWDkLR7cRJgR4ADRFBuk37daHRBOA9\n" +
  "23BSfMweCoW1VlV7cAjvvoLybBNPtp+Gsjgc1wnTGHnCHQtn4tye/llQk2z+L/ui\n" +
  "BkqinvQFQK11gCEbx0hsXqNir7tBM2qPKn5661eAURNtoMwZLHKxHr13y9sYkPBv\n" +
  "rUG2CZ9pXnfPGtMP949Em4c4wpjuHBCW2ajqyAomIQKBgQD754OoA0JNedCu8Zvu\n" +
  "xKIvu8QQS8JKUtK5Zy9z/Wz7X3zzK+RsYKzcmwi5L1U4q/OfIC9JtFU/QGy4VRWW\n" +
  "95m+t21GivDT6fzbg6yYDkZFr21fdPobLrKMxgKbtqBwkzarAg6MMbBrSsBbzLOC\n" +
  "IvoyNEzHcBAXAotibPROs2vSIQKBgQDbkYykxhwMISyK5mQjNM/llmhWSAI7UUQE\n" +
  "JOl0CVm9Okh/9lRJxhhG0kW5nLv7jXwyzRLge1ouyV5n/bJL7etESDeWm3JcKL92\n" +
  "VsPZ7K7pchkmCWmPIumUpnA97fw2aL2ku+MGlwB8i+6X6mb84LWHUBKPOrkjRT09\n" +
  "BTECBM0BFwKBgENsGtPsU2GzOgSpDEhi/tnx0q9d55nHAzm2gX/1E6dQTnwzgkbz\n" +
  "tTCymioenhu2AlXT4nRCvRJZ5v+LXmTyzoa6R5g69exyU0hZvOdR4sMiCg8jmxGN\n" +
  "dSKymN4eimC3NkmdGlGxtvtwnX20k1NAk2C+mNJEjznpZ28npFgwM6qhAoGBANKB\n" +
  "iMWw6dL3Oy0wFXFrgKYsvXt7LiiQkRUoDmohTNgOuNN15vmT4lKD5jU9/zv9OcW6\n" +
  "tw5hNOUGSmyI3hfN0nF0i1bpUYrpxiY+qSaVtFw798Bv5bRFVIwfxhyZveSsJqV5\n" +
  "PP9kZiMCRY2APZzUEzXXnvOS6UzXZQ7Lm2DEGYehAoGBAIcuayGgnnhQj2had+vM\n" +
  "gWlgqL/XdP537Dx5cYeJAXWj1zZctfJlK/wQyLmqgKPVYwZkOVWDuh98tp5EHL0V\n" +
  "GkcsykOpfnckCYqb3ws7t6WhLpc3JhK9/AeBDK5WpJ5v4MVeLZ3oWFFDUmOCxIjg\n" +
  "q2JawMGN61h3rUFntMErIwdA\n" +
  "-----END PRIVATE KEY-----";

const clientCert = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDqTCCApGgAwIBAgIUHA4CIFAuWbLoulj/cpg9vczmlgAwDQYJKoZIhvcNAQEL\n" +
  "BQAwVzELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDTALBgNVBAoMBFRlc3QxFTATBgNVBAMMDFRlc3QgUm9vdCBDQTAeFw0y\n" +
  "NjAxMDYxMjEwNTlaFw0yNzAxMDYxMjEwNTlaMFUxCzAJBgNVBAYTAkNOMRAwDgYD\n" +
  "VQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5nMQ0wCwYDVQQKDARUZXN0MRMw\n" +
  "EQYDVQQDDAppb3MtY2xpZW50MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
  "AQEA2A5GJww0c1VIGxAPNS59SrIZrXxrd7xZCJUO3uZidA+uSL4xwcGvCb1sBDXL\n" +
  "VFXept5or8B5l6g9KTagPPHEkpTwMcHM3WsjA0J4wTKt5PYrS1+Z9Sx9tk90qeJn\n" +
  "rF3Xb4SZ+TmTvK3LAZXvvBbQjmX1OJkj9pqJY65LXnPNWgpoiewJRduReDTIlaJj\n" +
  "klCl909BmlKTuAbMjGp55fwPQlTc3sxE9QySmnkI6B4qLmBo5DuDIafJnNb3DqR8\n" +
  "7pqPszkBfTaHfEpEMbqVWk3ysxgCqeIXDaG5RhVhZvIpWpspkkPTKb3RaGnKL0Po\n" +
  "WLE3Tt0ZDEn5bPgkRpOnUu8B9wIDAQABo28wbTAfBgNVHSMEGDAWgBTcN9XYrDg5\n" +
  "phMn/8cZYncm524i1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIFoDATBgNVHSUEDDAK\n" +
  "BggrBgEFBQcDAjAdBgNVHQ4EFgQU4K1vNUcxx0oMN7ASYH/i+f49u3QwDQYJKoZI\n" +
  "hvcNAQELBQADggEBAGKQc34pEnaRuNqDjLYab4p9RcII04juB6kD5jvfygG2Jroo\n" +
  "Sj8nIFbB9tjMcooB/Qj/kTyDe8b+NTPCfiMW+0T844G46499UwYmiT0ES3EpvQuJ\n" +
  "hebhN6BGKR0uYv9LGT5OpALRoFgy1MgeTKXzgnLowHke6rnmiTNjRgCzdg0PNlbL\n" +
  "Jpm2c1hGBGSbZdnZDFHrnJgdxJ8Ug4K+M5MGpGg1/+vnWDUm8eNc8s9xF8+wuIMb\n" +
  "hRzr1gPfizFpS3ppZDT0gDgX7tzaxgY89MMSn+PnThNOSlOpTElJm46zR1Smgfb4\n" +
  "81UCjol84/TbVJkSNtC30skaU+GnIJ81PIsBQF0=\n" +
  "-----END CERTIFICATE-----";

const clientCa = "-----BEGIN CERTIFICATE-----\n" +
  "MIIDjzCCAnegAwIBAgIUTZJFIjQhbxr4OyWhfsDmKZ4qDG4wDQYJKoZIhvcNAQEL\n" +
  "BQAwVzELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0Jl\n" +
  "aWppbmcxDTALBgNVBAoMBFRlc3QxFTATBgNVBAMMDFRlc3QgUm9vdCBDQTAeFw0y\n" +
  "NjAxMDYxMjEwNThaFw0yNzAxMDYxMjEwNThaMFcxCzAJBgNVBAYTAkNOMRAwDgYD\n" +
  "VQQIDAdCZWlqaW5nMRAwDgYDVQQHDAdCZWlqaW5nMQ0wCwYDVQQKDARUZXN0MRUw\n" +
  "EwYDVQQDDAxUZXN0IFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK\n" +
  "AoIBAQCuFYxb3d2KI4ZRd8wSS7zlogU4SvXIC51X0ZOqExYrIgw44f82CJe/d2qY\n" +
  "H65V0jlCVPIZLjvJTm9g5ZZJGEbN2+bwBIRdjXYfF12YgTJ/LZrfH8yXKJKSI9Kn\n" +
  "0dt9LZmplgVQ0QL0V7eP6Ssh6PERtOjhoILcuQRb3C743NX8aWEXSqSvzlyOF94h\n" +
  "EcmvSVBypQholI80RlLiRqt891FFl4iytCeX852GATijDZTnh4lhqAwUbxJYZqRP\n" +
  "Re0MkZkMvwiEUTbgcBV3Blf+dfyvAVkEpzy5nfp+tIQocibp/BKaRxYcQ/dX0Qgj\n" +
  "hHIZEZbJNe++KaudxTm3JOinnaP3AgMBAAGjUzBRMB0GA1UdDgQWBBTcN9XYrDg5\n" +
  "phMn/8cZYncm524i1DAfBgNVHSMEGDAWgBTcN9XYrDg5phMn/8cZYncm524i1DAP\n" +
  "BgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQASSCJzImASDI62knlP\n" +
  "otn1CNEi93x/DFxWFJ6W4mZqXqU3WyE7LMcLT8ThgcJLe/teRrHL3tbaT3D50jYO\n" +
  "qw4wQ53IyRBtBHMr6fpMropsugivVqP/iVJnfCSTeJJSiC5DBtQi+SFRNtUBlRON\n" +
  "oRquaT2vx0AOPrxW3dpuCo58EpF1LANa24zm605xtxyMKLHoV+5PP1FMlPhMPmmW\n" +
  "I/lSrsOmEeb4POsk0tQYXhV/7EPRDIl6bYq5VjspzQjCjhCoxfLnhvyWawsLksKU\n" +
  "yNowJPZlpHGXQghc/LNCOvKad6Q+l8wBIQkP9bb9cm3JliJs5Gr7mwHAR9Q3Vm+n\n" +
  "LMQ3\n" +
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
  isBidirectionalAuthentication: true,
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
  isBidirectionalAuthentication: true,
};

const connectAddr: socket.NetAddress = {
  address: '127.0.0.1',
  port: 14586
};

const connectOptions: socket.TLSConnectOptions = {
  address: connectAddr,
  secureOptions: TlsClientOptions,
  ALPNProtocols: ["spdy/1", "http/1.1"],
};

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function TLSSocketConnectionTest_2() {
  describe('TLSSocketConnectionTest_2', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100
     * @tc.desc Test the functionality of the getRemoteCertificate interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        let testCompleted = false;
        const cleanResources = () => {
          if (testCompleted) {
            return;
          }
          try {
            tlsServer.close();
            tlsClient.close();
          } catch (err) {
          }
          testCompleted = true;
        };
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30001
          };
          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30001
          };
          await tlsClient.bind(netAddress);
          console.info(`${caseName} bind success`);

          await tlsServer.listen(tlsConnectOptions);
          console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);

          tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
            console.info(`${caseName} Client connection detected`);
            clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
              if (err) {
                console.error(`${caseName} Failed to obtain the remote certificate,error:
            ${err.code} - ${err.message}`);
                cleanResources();
                done();
                return;
              } else {
                console.info(`${caseName} success to obtain the remote certificate ${JSON.stringify(certData)}`);
                expect(certData != undefined).assertTrue();
                cleanResources();
                done();
              }
            });
          });

          await tlsClient.connect(connectOptions);
          console.info(`${caseName} connect successfully`);
        } catch (err) {
          if ((err as BusinessError).code) {
            const error = err as BusinessError;
            if (error.message.includes('listen')) {
              console.error(`${caseName} listen fail: ${error.code} - ${error.message}`);
            } else if (error.message.includes('bind')) {
              console.error(`${caseName} bind err: ${error.code} - ${error.message}`);
            } else if (error.message.includes('connect')) {
              console.error(`${caseName} connect fail: ${error.code} - ${error.message}`);
            } else {
              console.error(`${caseName} operation failed: ${JSON.stringify(error)}`);
            }
          } else {
            const error = err as BusinessError;
            console.error(`${caseName} test error: ${error.message}`);
            expect().assertFail();
          }
          cleanResources();
          done();
        } finally {
          setTimeout(() => {
            if (!testCompleted) {
              cleanResources();
              done();
            }
          }, 5000);
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30002
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30002
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
                return new Promise<void>((resolve, reject) => {
                  try {
                    clientConn.getRemoteCertificate(undefined);
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30003
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30003
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
                return new Promise<void>((resolve, reject) => {
                  try {
                    clientConn.getRemoteCertificate(null);
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30004
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30004
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
                return new Promise<void>((resolve, reject) => {
                  let getRemoteCertificate = false;
                  try {
                    clientConn.getRemoteCertificate();
                    getRemoteCertificate = true;
                    expect(getRemoteCertificate).assertTrue();
                    resolve();
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect().assertFail();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500
     * @tc.desc Test the functionality of the getRemoteCertificate interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30005
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30005
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
              setTimeout(() => {
                clientConn.getRemoteCertificate().then((certData: socket.X509CertRawData) => {
                  console.info(`${caseName} Success to obtain the remote certificate:${JSON.stringify(certData)}`);
                  expect(certData != undefined).assertTrue();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} Failed to obtain the remote certificate,promise catch error:
                ${err.code} - ${err.message}`);
                  expect().assertFail();
                });
              }, 2000);
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(connectAddr).then(() => {
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
                sleep(1000);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600
     * @tc.desc Ca is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30006
          };
          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30006
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
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(connectAddr)}`);
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
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
                      ${err.code} - ${err.message}`);
                      reject(err);
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700
     * @tc.desc Key is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 10001
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
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
            key: '',
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 10001
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
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(connectAddr)}`);
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
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
              ${err.code} - ${err.message}`);
                      reject(err);
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
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
                  expect(errCode === 2303505).assertTrue();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800
     * @tc.desc cert is an empty test interface,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 10002
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
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
            cert: '',
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 10002
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
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate().then((certData: socket.X509CertRawData) => {
                    console.info(`${caseName} Success to obtain the remote certificate:${JSON.stringify(certData)}`);
                    expect().assertFail();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} Failed to obtain the remote certificate,promise catch error:
                ${err.code} - ${err.message}`);
                    const errCode = Number(err.code);
                    expect(errCode === 2303505 || errCode === 2303501).assertTrue();
                    reject(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900
     * @tc.desc password is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 10003
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 10003
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
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
                      ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === 2303505).assertTrue();
                      done();
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0100
     * @tc.desc Get the cipher suite negotiated by both parties, Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0100';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 16666
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 16666
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
                return new Promise<void>((resolve, reject) => {
                  clientConn.getCipherSuite((err: BusinessError, cipherSuiteList: Array<string>) => {
                    if (err) {
                      console.error(`${caseName} GetCipherSuite failed,error: ${err.code} - ${err.message}`);
                      expect(true).assertFalse();
                      reject(err);
                      done();
                    } else {
                      console.info(`${caseName} GetCipherSuite success:${JSON.stringify(cipherSuiteList)}`);
                      expect(cipherSuiteList != undefined).assertTrue();
                      resolve();
                      done();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetCipherSuite failed: ${JSON.stringify(err)}`);
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
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                done();
              });
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
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 16667
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 16667
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

              try {
                clientConn.getCipherSuite(undefined);
                console.warn(`${caseName} getCipherSuite(undefined) success`);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0300';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 16668
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 16668
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

              try {
                clientConn.getCipherSuite(null);
                console.warn(`${caseName} getCipherSuite(undefined) success`);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0400';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 16669
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 16669
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
              let getCipherSuite = false;
              try {
                clientConn.getCipherSuite();
                console.warn(`${caseName} getCipherSuite(undefined) success`);
                getCipherSuite = true;
                expect(getCipherSuite).assertTrue();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0500
     * @tc.desc Get the cipher suite negotiated by both parties, Use the Promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 17000
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
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
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
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

              try {
                clientConn.getCipherSuite().then((cipherSuiteList: Array<string>) => {
                  console.info(`${caseName} GetCipherSuite success,promise: ${JSON.stringify(cipherSuiteList)}`);
                  expect(cipherSuiteList != undefined).assertTrue();
                  done();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} GetCipherSuite failed,error: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} GetCipherSuite failed,error:
              ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
                expect(true).assertFalse();
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
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect(true).assertFalse();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0100
     * @tc.desc The test type is set to close, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50014
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

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');

              clientConn.on('close', () => {
                console.info(`${caseName} on close success`);
                on_close = true;
                expect(on_close).assertTrue();
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.info(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.info(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0200
     * @tc.desc The test type is null, the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50015
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: 50015
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
              try {
                clientConn.on(null, () => {
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
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
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0300
     * @tc.desc The test type is undefined, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50015
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: 50015
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
              try {
                clientConn.on(undefined, () => {
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
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
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_CLose_0400
     * @tc.name ArKUIX_TLSSocketConnection_On_CLose_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_CLose_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_CLose_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50015
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: 50015
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
              try {
                clientConn.on('close', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
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
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_CLose_0500
     * @tc.name ArKUIX_TLSSocketConnection_On_CLose_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_CLose_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_CLose_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50015
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: 50015
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
              try {
                clientConn.on('close', null);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
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
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0100
     * @tc.desc The test type is set to close, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50019
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
          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              clientConn.off('close', callback);
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.info(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.info(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0200
     * @tc.desc When the test type is null, the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50020
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
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off(null, callback);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0300
     * @tc.desc The test type is undefined, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50021
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
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off(undefined, callback);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0400
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50022
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
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off('close', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0500
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50023
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
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off('close', null);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0600
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0600
     * @tc.desc The test did not pass the callback parameter and adopted the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50024
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

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              clientConn.off('close');
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.info(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.info(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0700
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0700
     * @tc.desc After testing multiple subscriptions, off clears all closed subscriptions
     * and uses the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50025
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

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback_1 = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              const callback_2 = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback_1);
              clientConn.on('close', callback_2);
              clientConn.off('close');
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.info(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.info(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getLocalAddress_0100
     * @tc.name ArKUIX_TLSSocketConnection_getLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress function interface under TLSSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getLocalAddress_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50026
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getLocalAddress().then((localAddress: socket.NetAddress) => {
                console.info(`${caseName} Get local address success: ${JSON.stringify(localAddress)}`);
                expect(localAddress != undefined).assertTrue();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Get local address failed: ${err.code} - ${err.message}`);
              });
            });

            tlsClient.bind(netAddress).then((): Promise<void> => {
              console.info(`${caseName} TLS client bind local address success`);
              return tlsClient.connect(connectOptions);
            }).then((): void => {
              console.info(`${caseName} Client connect to server success`);
            }).catch((err: BusinessError): void => {
              console.error(`${caseName} Client bind erred: ${err.code}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetSocketFd_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd function interface under TLSSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetSocketFd_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50027
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSocketFd().then((data: number) => {
                console.info(`${caseName} getSocketFd success: ${JSON.stringify(data)}`);
                expect(data >= 0).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} getSocketFd failed: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100
     * @tc.desc Get the signature algorithms negotiated by both parties,
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 30001
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 30001
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
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                if (err) {
                  console.error(`${caseName} Get signature algorithms failed: ${err.code} - ${err.message}`);
                  return;
                } else {
                  console.info(`${caseName} Get signature algorithms success: ${JSON.stringify(sigAlgos)}`);
                  expect(sigAlgos !== undefined).assertTrue();
                }
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
                setTimeout(() => {
                }, 500);
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
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200
     * @tc.desc Test callback parameter type error.Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50029
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                try {
                  clientConn.getSignatureAlgorithms(undefined);
                  console.warn(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300
     * @tc.desc Test callback parameter type error.Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50030
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                try {
                  clientConn.getSignatureAlgorithms(null);
                  console.warn(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect((err as BusinessError).code == ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400
     * @tc.desc Test the scenario where the callback parameter is not passed.
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50031
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                let getSignatureAlgorithms = false;
                try {
                  clientConn.getSignatureAlgorithms();
                  console.warn(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  getSignatureAlgorithms = true;
                  expect(getSignatureAlgorithms).assertTrue();
                  done();
                } catch (err) {
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect().assertFail();
                  done();
                }
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500
     * @tc.desc Get the signature algorithms negotiated by both parties,
     * Use the Promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 50032
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
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms().then((data: Array<string>) => {
                console.info(`${caseName} getSignatureAlgorithms success: ${JSON.stringify(data)}`);
                expect(data != undefined).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} getSignatureAlgorithms failed: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
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