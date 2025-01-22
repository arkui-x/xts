export class URLUtils {
  static validateURL(url: string): boolean {
    const regex = /^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([/\w.-]*)*\/?$/;
    return regex.test(url);
  }
}