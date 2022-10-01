# Chipwhisper Nano Voltage Glitching 


### This is a small mod of the Newaetech tutorial Introduction to Voltage Glitchin for CW-Nano
The sole intent for this mod is to enable the students at [University of South-eastern Noway](www.usn.no) to be able to run the example on the lab \
Please check [https://github.com/newaetech](https://github.com/newaetech) for utdates :) \
[original src:](https://github.com/newaetech/achipwhisperer-jupyter/blob/c940073159c8032877e9f7b9ef852b3662c4ec02/courses/fault101/SOLN_Fault%202_2B%20-%20Voltage%20Glitching%20with%20CWNano%20to%20Bypass%20Password.ipynb)
The examle could be runned using jupyter but requres some python libraries like: chipwhisperer , matplotlib ...

### CW-Nano mod for sucessfully glitching the target
(My CW-Nano bought fall 2022 came width a FDN337N-Transistor and R12 = 20 Ohm ) - Adding a 5.6 Ohm resistor and opening Sj6 to grenerate aprox 600mV bias
![alt text](https://github.com/rlangoy/cw_nano_glitch_sim/raw/main/images/mod_glitch.png)

#### Mesured result:
![alt text](https://github.com/rlangoy/cw_nano_glitch_sim/raw/main/images/mod_glitch_scope.png)

### Glitching results from [Voltage Glitching CWNano Mod.ipynb](https://github.com/rlangoy/cwr_nano_vdd_glitching/blob/main/jupyter/Voltage%20Glitching%20CWNano%20Mod.ipynb)
![alt text](https://github.com/rlangoy/cwr_nano_vdd_glitching/blob/main/images/glitch_results.png):


## Running the example:
Open the file  jupiter\Voltage Glitching CWNano Mod.ipynb in jupiter 


## Re-Use in Teaching & Academic Environments

These notebooks are distributed under the open-source GPL license (as is the rest of ChipWhisperer). This means you can distribute and modify this material (even for commercial trainings), **provided you maintain references to this repository and the original authors, and also offer your derived material under the same conditions**.

If you would like to re-use this content commercially under different license conditions, please contact `sales -AT- newae.com`. Note that as a public project, we also have user-contributed content which we may not own the original copyright for.

This material is Copyright (C) NewAE Technology Inc., 2015-2020. ChipWhisperer is a trademark of NewAE Technology Inc., claimed in all jurisdictions, and registered in at least the United States of America, European Union, and Peoples Republic of China.
