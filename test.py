import pyarrow
import numpy as np
import scipy
import scipy.optimize
from pyarrow.hdfs import HadoopFileSystem

try:
    # Activate JNI load `$HADOOP_HOME/lib/native/libhdfs.so` in runtime
    HadoopFileSystem('foo')
except:
    pass

evs = np.array([ 0.01855396,  0.02888079,  0.01484719,  0.01187566,  0.01350127,
        0.0152477 ,  0.02978069,  0.01184938,  0.0152477 ,  0.01967369,
        0.02334463, -0.00964757, -0.0084154 ,  0.0093229 ,  0.00074653])

A_eq = np.array([[-0.17128674,  0.17588126, -0.21854693,  0.35221215,  0.32877443,
         0.35090059, -0.28819657, -0.17272982,  0.35090059,  0.32671732,
        -0.13842946,  0.23981023,  0.1866889 ,  0.15406733,  0.24219247],
       [ 0.27321495, -0.28669058,  0.355471  ,  0.24540659,  0.16261506,
         0.24417405, -0.20448798,  0.27555701,  0.24417405,  0.16159759,
        -0.19235484, -0.38261073, -0.30371767, -0.25482233, -0.16266994]])
b_eq = [0,0]



scipy.optimize.linprog(-evs, A_eq=A_eq, b_eq=b_eq, bounds=[(0, 1)] * len(evs))
