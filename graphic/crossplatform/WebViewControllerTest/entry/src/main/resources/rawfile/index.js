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

const decoder = new TextDecoder('utf-8');

window.addEventListener('message', (event) => {
    if (event.data === 'init_web_messageport') {
        if (event.ports[0] !== null) {
            const [h5Port] = event.ports;
            h5Port.onmessage = (event) => {
                let result = event.data;
                if (typeof(result) === 'string') {
                    document.getElementById('msg').innerHTML = `String:${result}`;
                    h5Port.postMessage(`String:${result}`);
                } else if (typeof(result) === 'number') {
                    document.getElementById('msg').innerHTML = `Number:${result}`;
                    h5Port.postMessage(`Number:${result}`);
                } else if (typeof(result) === 'boolean') {
                    document.getElementById('msg').innerHTML = `Boolean:${result}`;
                    h5Port.postMessage(`Boolean:${result}`);
                } else if (typeof(result) === 'object') {
                    if (result instanceof Error) {
                        document.getElementById('msg2').innerHTML = `Error:${result.name}, msg:${result.message}`;
                        h5Port.postMessage(`Error:${result.name}`);
                    } else if (result instanceof Array) {
                        document.getElementById('msg2').innerHTML = `Array len:${result.length}, value:${result}`;
                        h5Port.postMessage(`Array:${result}`);
                    } else {
                        document.getElementById('msg').innerHTML = 'not any instance of support type';
                        h5Port.postMessage('not support type');
                    }
                } else {
                    document.getElementById('msg').innerHTML = 'not support type';
                    h5Port.postMessage('not support type');
                }
            };
        }
    }
});
