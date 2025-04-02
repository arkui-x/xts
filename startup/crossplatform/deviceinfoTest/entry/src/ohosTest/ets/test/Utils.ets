export default class Utils {
  static sleep(time: number) {
    return new Promise<void>((resolve, reject) => {
      setTimeout(() => {
        resolve()
      }, time)
    }).then(() => {
      console.info(`sleep ${time} over...`)
    })
  }
}