
/*--- autoexec.sas in HRS-FCMP folder ---*/

options nocenter mprint;

%let HRS_FCMP_path = .;                     /*  Path to HRS_FCMP folder */


/*--- No changes below ----*/

filename _macros "&HRS_FCMP_path/_macros";
%include _macros(create_fcmp_lib filenamesInFolder);  

filename _setup "&HRS_FCMP_path/_setup-prj.sas";
%include _setup;

