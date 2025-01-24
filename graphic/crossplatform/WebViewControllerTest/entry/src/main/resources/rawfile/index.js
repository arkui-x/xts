//index.js
var h5Port;
const decoder = new TextDecoder('utf-8');

// 使用h5Port往ets侧发送String类型的消息.
function postStringToEts(message) {
    if (h5Port) {
        h5Port.postMessage(message);
    } else {
        console.error("In html h5port is null, please init first");
    }
}

window.addEventListener('message', function(event) {
    if (event.data == 'init_web_messageport') {
        if(event.ports[0] != null) {
            h5Port = event.ports[0]; // 1. 保存从ets侧发送过来的端口
            h5Port.onmessage = function(event) {
                console.log("hwd In html got message");
                // 2. 接收ets侧发送过来的消息.
                var result = event.data;
                console.log("In html got message, typeof: ", typeof(result));
                console.log("In html got message, result: ", (result));
                if (typeof(result) == "string") {
                    document.getElementById("msg").innerHTML = "String:" + result;
                    postStringToEts("String:" + result);
                } else if (typeof(result) == "number") {
                    document.getElementById("msg").innerHTML = "Number:" + result;
                    postStringToEts("Number:" + result);
                } else if (typeof(result) == "boolean") {
                    document.getElementById("msg").innerHTML = "Boolean:" + result;
                    postStringToEts("Boolean:" + result);
                } else if (typeof(result) == "object") {
                    if (result instanceof Error) {
                        document.getElementById("msg2").innerHTML = "Error:" + result.name + ", msg:" + result.message;
                        postStringToEts("Error:" + result.name);
                    } else if (result instanceof Array) {
                        document.getElementById("msg2").innerHTML = "Array len:" + result.length + ", value:" + result;
                        postStringToEts("Array:" + result);
                    } else {
                        document.getElementById("msg").innerHTML = "not any instance of support type";
                        postStringToEts("not support type");
                    }
                } else {
                    document.getElementById("msg").innerHTML = "not support type";
                    postStringToEts("not support type");
                }
            }
            h5Port.onmessageerror = (event) => {
                postStringToEts(`html Error:${event}`);
            };
        }
    }
})
