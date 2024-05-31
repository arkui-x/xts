package com.example.wifimanagertest;

import android.Manifest;
import android.os.Bundle;
import android.util.Log;

import java.util.List;

import ohos.stage.ability.adapter.StageActivity;
import pub.devrel.easypermissions.EasyPermissions;


/**
 * Example ace activity class, which will load ArkUI-X ability instance.
 * StageActivity is provided by ArkUI-X
 *
 * @see <a href=
 * "https://gitee.com/arkui-crossplatform/doc/blob/master/contribute/tutorial/how-to-build-Android-app.md">
 * to build android library</a>
 */
public class EntryEntryAbilityActivity extends StageActivity implements EasyPermissions.PermissionCallbacks {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.e("HiHelloWorld", "EntryEntryAbilityActivity");
        setInstanceName("com.example.helloworld:entry:EntryAbility:");
//        applyPermission();
        super.onCreate(savedInstanceState);
    }

    public void applyPermission() {
        String[] perms = {Manifest.permission.ACCESS_FINE_LOCATION};
        if (EasyPermissions.hasPermissions(this, perms)) {
            //拥有权限进行操作
            Log.e("zhangDM", "zhangDM applyPermission true");
        } else {
            //没有权限进行提示且申请权限
            EasyPermissions.requestPermissions(this, "应用需要权限,请允许", 0, perms);
        }
    }

    @Override
    public synchronized void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        //把申请权限的回调交由EasyPermissions处理
        EasyPermissions.onRequestPermissionsResult(requestCode, permissions, grantResults, this);
    }

    @Override
    public void onPermissionsGranted(int requestCode, List<String> perms) {
        Log.e("zhangDM", "zhangDM EasyPermissions.requestPermissions onPermissionsGranted");
    }

    @Override
    public void onPermissionsDenied(int requestCode, List<String> perms) {
        Log.e("zhangDM", "zhangDM EasyPermissions.requestPermissions onPermissionsDenied");
    }
}
