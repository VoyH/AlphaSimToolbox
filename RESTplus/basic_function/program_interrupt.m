function program_interrupt
% (Tested on R2011a, both Mac & Win).
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	http://www.restfmri.net/
% 	Mail: jxz.rest@gmail.com, jiaxize@foxmail.com

import java.awt.event.KeyEvent
import java.util.Calendar
import java.lang.reflection.*

cmdwin = handle(com.mathworks.mde.cmdwin.CmdWin.getInstance().getComponent(0).getComponent(0).getComponent(0),'CallbackProperties');

argSig = javaArray('java.lang.Class',1);
argSig(1) = java.lang.Class.forName('java.awt.event.KeyEvent');
method = cmdwin.getClass().getDeclaredMethod('processKeyEvent',argSig);
method.setAccessible(true);

cal = Calendar.getInstance();
args = javaArray('java.lang.Object',1);
args(1) = KeyEvent(cmdwin,KeyEvent.KEY_PRESSED,cal.getTime().getTime(),KeyEvent.CTRL_DOWN_MASK,KeyEvent.VK_C,KeyEvent.CHAR_UNDEFINED);
method.invoke(cmdwin,args);
end