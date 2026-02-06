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

package com.example.xtsbridge;

import android.util.Log;

import ohos.ace.adapter.capability.bridge.BridgePlugin;
import ohos.ace.adapter.capability.bridge.IMessageListener;
import ohos.ace.adapter.capability.bridge.IMethodResult;

/**
 * Platform-side Bridge object, calling native methods.
 *
 * @since 2026-01-16
 */
public class BridgeImpl extends BridgePlugin implements IMethodResult, IMessageListener {
    private static final String TAG = "LOG";

    private static final String LOG_TAG = "[BridgeImpl] ";

    /**
     * 构造函数：初始化桥接插件并设置消息监听器和结果监听器
     *
     * @param bridgeName Bridge实例的名称标识
     * @param bridgeType Bridge实例类型
     */
    public BridgeImpl(String bridgeName, BridgeType bridgeType) {
        super(bridgeName, bridgeType);
        setMessageListener(this);
        setMethodResultListener(this);
    }

    /**
     * 调用无参数测试方法0010
     *
     * @return 固定字符串"callMethodT0010 call success"
     */
    public String callMethodT0010() {
        return "callMethodT0010 call success";
    }

    /**
     * 调用带字符串参数的测试方法0020
     *
     * @param param 输入的字符串参数
     * @return 原样返回输入的字符串参数
     */
    public String callMethodT0020(String param) {
        return param;
    }

    /**
     * 调用带布尔参数的测试方法0030
     *
     * @param param 输入的布尔参数
     * @return 原样返回输入的布尔参数
     */
    public boolean callMethodT0030(boolean param) {
        return param;
    }

    /**
     * 调用带整型参数的测试方法0040
     *
     * @param param 输入的整型参数
     * @return 原样返回输入的整型参数
     */
    public int callMethodT0040(int param) {
        return param;
    }

    /**
     * 调用带字符串数组参数的测试方法0050
     *
     * @param param 输入的字符串数组
     * @return 原样返回输入的字符串数组
     */
    public String[] callMethodT0050(String[] param) {
        return param;
    }

    /**
     * 调用带布尔数组参数的测试方法0060
     *
     * @param param 输入的布尔数组
     * @return 原样返回输入的布尔数组
     */
    public boolean[] callMethodT0060(boolean[] param) {
        return param;
    }

    /**
     * 调用带整型数组参数的测试方法0070
     *
     * @param param 输入的整型数组
     * @return 原样返回输入的整型数组
     */
    public int[] callMethodT0070(int[] param) {
        return param;
    }

    /**
     * 同步调用无参数测试方法0010
     *
     * @return 固定字符串"callMethodSyncT0010 call success"
     */
    public String callMethodSyncT0010() {
        return "callMethodSyncT0010 call success";
    }

    /**
     * 同步调用带字符串参数的测试方法0020
     *
     * @param param 输入的字符串参数
     * @return 原样返回输入的字符串参数
     */
    public String callMethodSyncT0020(String param) {
        return param;
    }

    /**
     * 同步调用带布尔参数的测试方法0030
     *
     * @param param 输入的布尔参数
     * @return 原样返回输入的布尔参数
     */
    public boolean callMethodSyncT0030(boolean param) {
        return param;
    }

    /**
     * 同步调用带整型参数的测试方法0040
     *
     * @param param 输入的整型参数
     * @return 原样返回输入的整型参数
     */
    public int callMethodSyncT0040(int param) {
        return param;
    }

    /**
     * 同步调用带字符串数组参数的测试方法0050
     *
     * @param param 输入的字符串数组
     * @return 原样返回输入的字符串数组
     */
    public String[] callMethodSyncT0050(String[] param) {
        return param;
    }

    /**
     * 同步调用带布尔数组参数的测试方法0060
     *
     * @param param 输入的布尔数组
     * @return 原样返回输入的布尔数组
     */
    public boolean[] callMethodSyncT0060(boolean[] param) {
        return param;
    }

    /**
     * 同步调用带整型数组参数的测试方法0070
     *
     * @param param 输入的整型数组
     * @return 原样返回输入的整型数组
     */
    public int[] callMethodSyncT0070(int[] param) {
        return param;
    }

    /**
     * 调用带回调的无参数测试方法0010
     *
     * @return 固定字符串"callMethodWithCallbackT0010 call success"
     */
    public String callMethodWithCallbackT0010() {
        callMethod("callMethodWithCallbackT0010", "arkTsMethodWithCallback call success");
        return "callMethodWithCallbackT0010 call success";
    }

    /**
     * 调用带回调的字符串参数测试方法0020
     *
     * @param param 输入的字符串参数
     * @return 原样返回输入的字符串参数
     */
    public String callMethodWithCallbackT0020(String param) {
        callMethod("callMethodWithCallbackT0020", param);
        return param;
    }

    /**
     * 调用带回调的布尔参数测试方法0030
     *
     * @param param 输入的布尔参数
     * @return 原样返回输入的布尔参数
     */
    public boolean callMethodWithCallbackT0030(boolean param) {
        callMethod("callMethodWithCallbackT0030", param);
        return param;
    }

    /**
     * 调用带回调的整型参数测试方法0040
     *
     * @param param 输入的整型参数
     * @return 原样返回输入的整型参数
     */
    public int callMethodWithCallbackT0040(int param) {
        callMethod("callMethodWithCallbackT0040", param);
        return param;
    }

    /**
     * 调用带回调的字符串数组参数测试方法0050
     *
     * @param param 输入的字符串数组
     * @return 原样返回输入的字符串数组
     */
    public String[] callMethodWithCallbackT0050(String[] param) {
        callMethod("callMethodWithCallbackT0050", (Object) param);
        return param;
    }

    /**
     * 调用带回调的布尔数组参数测试方法0060
     *
     * @param param 输入的布尔数组
     * @return 原样返回输入的布尔数组
     */
    public boolean[] callMethodWithCallbackT0060(boolean[] param) {
        callMethod("callMethodWithCallbackT0060", (Object) param);
        return param;
    }

    /**
     * 调用带回调的整型数组参数测试方法0070
     *
     * @param param 输入的整型数组
     * @return 原样返回输入的整型数组
     */
    public int[] callMethodWithCallbackT0070(int[] param) {
        callMethod("callMethodWithCallbackT0070", (Object) param);
        return param;
    }

    /**
     * 处理接收到的消息数据
     *
     * @param data 接收到的消息字符串
     */
    public void onMessageHelper(String data) {
        if (data == null) {
            return;
        }
        if (data.equals("test setMessageListener")) {
            sendMessage("setMessageListener success");
        }
        if (data.equals("test registerMethod")) {
            callMethod("arkTsMethod", "arkTsMethod call success");
        }
        if (data.equals("testRegisterMethod0020")) {
            callMethod("testRegisterMethod0020", "testRegisterMethod0020 call success");
        }
        if (data.equals("testRegisterMethod0030")) {
            callMethod("testRegisterMethod0030", true);
        }
        if (data.equals("testRegisterMethod0040")) {
            callMethod("testRegisterMethod0040", 123);
        }
        if (data.equals("testRegisterMethod0050")) {
            String[] param = {"hello", "world"};
            callMethod("testRegisterMethod0050", (Object) param);
        }
        if (data.equals("testRegisterMethod0060")) {
            boolean[] param = {false, true};
            callMethod("testRegisterMethod0060", (Object) param);
        }
        if (data.equals("testRegisterMethod0070")) {
            int[] param = {100, 200};
            callMethod("testRegisterMethod0070", (Object) param);
        }
    }

    /**
     * 方法调用成功回调
     *
     * @param o 成功返回的对象数据
     */
    @Override
    public void onSuccess(Object o) {
        Log.i(TAG, LOG_TAG + "IMethodResult onSuccess");
    }

    /**
     * 方法调用失败回调
     *
     * @param s  错误信息
     * @param i  错误代码
     * @param s1 详细错误描述
     */
    @Override
    public void onError(String s, int i, String s1) {
        Log.i(TAG, LOG_TAG + "IMethodResult onError");
    }

    /**
     * 方法调用取消回调
     *
     * @param s 取消原因描述
     */
    @Override
    public void onMethodCancel(String s) {
        Log.i(TAG, LOG_TAG + "IMethodResult onMethodCancel");
    }

    /**
     * 处理接收到的消息对象
     *
     * @param object 接收到的消息对象（支持多种数据类型）
     * @return 处理后的响应对象
     */
    @Override
    public Object onMessage(Object object) {
        if (object == null) {
            return "arkTS sendMessage null";
        }
        if (object instanceof String) {
            String data = object.toString();
            onMessageHelper(data);
        }
        if (object instanceof String[]) {
            return (String[]) object;
        }
        if (object instanceof boolean[]) {
            return (boolean[]) object;
        }
        if (object instanceof int[]) {
            return (int[]) object;
        }
        return object;
    }

    /**
     * 消息响应回调
     *
     * @param o 响应对象数据
     */
    @Override
    public void onMessageResponse(Object o) {
        Log.i(TAG, LOG_TAG + "IMessageListener onMessageResponse");
    }
}