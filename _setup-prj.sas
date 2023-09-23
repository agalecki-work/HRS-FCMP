
/* _setup-prj.sas file is invoked by autoexec.sas */
/* This file contains information specific to a selected FCMP member */

%put _fcmp_source_path := &_fcmp_source_path;

%let member = DLFunction;   /*--- Select FCMP member name (Needs to match project folder name ---*/

%let _fcmp_source_path = &HRS_FCMP_path\&member-prj\src; /* FCMP member source */


/*--  Path to output folder. Contents of the folder will be over-written  ---*/
/*--  For Windows the path defined below resolves to C:\Users\Public\temp ---*/
%let _cmplib_path= %sysget(Public)\temp;   /* path to output folder */  



