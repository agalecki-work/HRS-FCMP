
/* _setup.sas file is invoked by autoexec.sas */
/* This file contains information specific to a selected FCMP member */


%let member = DLFunction;   /*--- Select FCMP member name (Corresponds to -FCMP folder name ---*/


/* === NO changes needed below */

%let _fcmp_source_path = &HRS_FCMP_path\&member-FCMP\src; /* FCMP member source */

/** Subfolder in HRS-FCMP subfolder */
%let _cmplib_path = &_fcmp_source_path\&member-FCMP\cmplib;




