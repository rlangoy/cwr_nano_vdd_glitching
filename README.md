# Chipwhisperer Nano Voltage Glitching 


### This is a small mod of the NewAE Technology tutorial Introduction to Voltage Glitchin for CW-Nano [src](https://github.com/newaetech/chipwhisperer-jupyter/blob/c940073159c8032877e9f7b9ef852b3662c4ec02/courses/fault101/SOLN_Fault%202_1B%20-%20Introduction%20to%20Voltage%20Glitching%20with%20CWNano.ipynb)
The sole intent for this mod is to enable the students at [University of South-eastern Noway](https://www.usn.no) to be able to run the [Tutorial / Voltage glitching Example](https://github.com/newaetech/chipwhisperer-jupyter/blob/c940073159c8032877e9f7b9ef852b3662c4ec02/courses/fault101/SOLN_Fault%202_1B%20-%20Introduction%20to%20Voltage%20Glitching%20with%20CWNano.ipynb) by [NewAE Technology](https://www.newae.com/) for more information and tutorials see  [https://github.com/newaetech](https://github.com/newaetech) for utdates :) \
 \
The examle could be runned using jupyter but requres some python libraries like: chipwhisperer , matplotlib ...

### CW-Nano HW mod for sucessfully voltage glitching using [ChipWhisperer 5.6.1](https://github.com/newaetech/chipwhisperer/releases/tag/5.6.1)
(My CW-Nano bought fall 2022 came width a FDN337N-Transistor and R12 = 20 Ohm ) - Adding a 5.6 Ohm resistor between GLITCH - MEASURE and opening Sj6 to grenerate aprox 600mV bias
#### Physical CW-Nano Mod
![alt text](https://github.com/rlangoy/cwr_nano_vdd_glitching/raw/main/images/hw_mod_physical.png)
#### Simplifyed schematic Mod
![alt text](https://github.com/rlangoy/cw_nano_glitch_sim/raw/main/images/mod_glitch.png)

#### Mesured result:
![alt text](https://github.com/rlangoy/cw_nano_glitch_sim/raw/main/images/mod_glitch_scope.png)

### Glitching results from [Voltage Glitching CWNano Mod.ipynb](https://github.com/rlangoy/cwr_nano_vdd_glitching/blob/main/jupyter/Voltage%20Glitching%20CWNano%20Mod.ipynb)
![alt text](https://github.com/rlangoy/cwr_nano_vdd_glitching/blob/main/images/glitch_results.png):


## Running the example:
Open the file  jupiter\Voltage Glitching CWNano Mod.ipynb in jupiter 

## Running the example on a windows machine with Thonny installed:
Download and install [Thonny](https://thonny.org/) for all users <br>
Download an unzip [this github repo](https://github.com/rlangoy/cwr_nano_vdd_glitching/archive/refs/tags/Ver_1_0.zip) <br>
Install all nessesary packages by running ./jupyter/thonny_jupiter_and_packages_install.bat <br>
Start jupyter notebook by running ./jupyter/thonny_start_jupiter.bat <br>
Open and run the example from  "Voltage Glitching CWNano Mod Th.ipynb" or <br>
"SOLN_Fault 2_2B - Voltage Glitching with CWNano to Bypass Password.ipynb" :)


 
## Licence / Usage  
### Noitce from  NewAE Technolog,conditions on  Re-Use in Teaching & Academic Environments

These notebooks are distributed under the open-source GPL license (as is the rest of ChipWhisperer). This means you can distribute and modify this material (even for commercial trainings), **provided you maintain references to this repository and the original authors, and also offer your derived material under the same conditions**.

If you would like to re-use this content commercially under different license conditions, please contact `sales -AT- newae.com`. Note that as a public project, we also have user-contributed content which we may not own the original copyright for.

This material is Copyright (C) NewAE Technology Inc., 2015-2020. ChipWhisperer is a trademark of NewAE Technology Inc., claimed in all jurisdictions, and registered in at least the United States of America, European Union, and Peoples Republic of China.
