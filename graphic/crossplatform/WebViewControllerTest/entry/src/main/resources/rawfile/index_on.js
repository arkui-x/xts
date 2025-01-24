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

const encoder = new TextEncoder();

window.addEventListener('message', (event) => {
    if (event.data === 'init_web_messageport') {
        if (event.ports[0] !== null) {
            const [h5Port] = event.ports;
            h5Port.onmessage = (event) => {
                let result = event.data;
                if (typeof(result) === 'string') {
                    document.getElementById('msg').innerHTML = `String:${result}`;
                    if (result === 'string') {
                        h5Port.postMessage('helloFromH5');
                    } else if (result === 'number') {
                        h5Port.postMessage(54321);
                    } else if (result === 'boolean') {
                        h5Port.postMessage(false);
                    } else if (result === 'array') {
                        h5Port.postMessage([3, 2, 1]);
                    } else if (result === 'error') {
                        try {
                            throw new Error('This is Error from H5');
                        } catch (error) {
                            h5Port.postMessage(error);
                        }
                    } else {
                        h5Port.postMessage('not support this type');
                    }
                } else {
                    document.getElementById('msg').innerHTML = 'incorrect type';
                    h5Port.postMessage('incorrect type');
                }
            }
            h5Port.onmessageerror = (event) => {
                h5Port.postMessage(`html Error:${event}`);
            };
        }
    }
});
