SMS - Sinbane Medical System

Not really a fully fledged medical system, yet. More a bleeding module.

///////

To install:

Add these 2 lines to DESCRIPTION.EXT:

#include GUI\defines.hpp
#include GUI\blood.hpp

///////

Run the init on a unit via scripts:
[player] execVM SMS\SMS_init.sqf;

-OR- 

Run the init on a unit's init field in the editor:
[_this] execVM SMS\SMS_init.sqf;

//////

CONFIGURATION

You can change most of the config by editing the numbers in cfgSMS.sqf