//index_on.js
var h5Port;
const encoder = new TextEncoder();

// 使用h5Port往ets侧发送消息.
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
                    // 根据收到的信息，发送相应类型的数据
                    document.getElementById("msg").innerHTML = "String:" + result;
                    if (result == "string") {
                        postStringToEts("helloFromH5");
                    } else if (result == "number") {
                        postStringToEts(54321);
                    } else if (result == "boolean") {
                        postStringToEts(false);
                    } else if (result == "array") {
                        postStringToEts([3, 2, 1]);
                    } else if (result == "error") {
                        try {
                            throw new Error("This is Error from H5");
                        } catch (error) {
                            postStringToEts(error);
                        }
                    }

                } else {
                    document.getElementById("msg").innerHTML = "incorrect type";
                    postStringToEts("incorrect type");
                }
            }
            h5Port.onmessageerror = (event) => {
                postStringToEts(`html Error:${event}`);
            };
        }
    }
})
