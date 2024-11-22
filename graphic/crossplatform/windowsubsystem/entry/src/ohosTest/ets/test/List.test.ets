import ColorSpaceTest from '../test/ColorSpace.test';
import ColorSpaceManagerCreateStandard from './ColorSpaceManagerCreateStandard.test';
import ColorSpaceManagerCreateCustom from '../test/ColorSpaceManagerCreateCustom.test';
import Display from '../test/Display.test';
import Window from './Window.test';

export default function testsuite() {
  ColorSpaceTest();
  ColorSpaceManagerCreateStandard();
  ColorSpaceManagerCreateCustom();
  Display();
  Window();
}
