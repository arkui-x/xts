import { deviceInfo } from '@kit.BasicServicesKit';

export class checkPlatformUtil {
  static checkPlatform(): string {
    let systemName: string | undefined = deviceInfo.osFullName;
    let platFromOrigin = '';
    if (systemName && systemName.toLowerCase().includes('openharmony')) {
      platFromOrigin = 'resource://rawfile/'
    } else if (systemName && systemName.toLowerCase().includes('android')) {
      platFromOrigin = 'file:///';
    } else {
      platFromOrigin = 'file:///';
    }
    return platFromOrigin;
  }
}
