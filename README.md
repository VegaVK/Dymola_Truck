# Dymola_Truck
This provides the Modelica and Simulink supporting files for my MS thesis on model identification.

The project involved modelling the longitudinal dynamics (engine, transmission,drive train) of a Class 8 truck (2013 International Prostar+) with an unloaded semi trailer, using SAE J1939 signals. While the Dymola model does have the ability to steer, the lateral dynamics have not been tuned as well as the powertrain components.

For details/citation, please see : https://oaktrust.library.tamu.edu/handle/1969.1/174613
(PDF will be available for free to public after December 2019)

The Modelica file (.mo) was created with Dymola 2017, with Vehicle Dynamics Library v2.4 and Modelon Library v2.5. Newer versions of these should work but some links maybe be broken and will need to be fixed manually. Older versions will almost definitely not work.

Simulink model can be opened with R2016b or newer. (You will need to configure the Dymola-MATLAB interface first. See Dymola User Manual Vol 2). Run the .m script file, which will load the required data and create input variables for simulation.

This repo only has the latest version of the files. If you are a member of Texas A&M University, you can see the full commit history on TAMU's enterprise Github :https://github.tamu.edu/AutonomyLab01/Dymola_Model_Identification.





