import commonEventMgrCreateSubscriberTest from './CEMCreateSubscriber.test'
import commonEventMgrSubscribeTest from './CEMSubscribe.test'
import commonEventMgrUnsubscribeTest from './CEMUnsubscribe.test'

export default function testsuite() {
  commonEventMgrCreateSubscriberTest()
  commonEventMgrSubscribeTest()
  commonEventMgrUnsubscribeTest()
}