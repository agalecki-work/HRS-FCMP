/*---  autoexec.sas executed ---*/
/*---  _setup-prj.sas included */

options mprint nocenter;

/*--- Path to HRS_FCMP folder:  Defined in `autoexec.sas` ---*/
%put HRS_FCMP_path := &HRS_FCMP_path; 

/*--- FCMP member:  Defined in `setup-prj.sas`. Ex. DLFUNCTION */
%put FCMP member   :=  &member;         

/*--- Path to output folder: Defined in `_setup-prj.sas` ---*/
%put Path to output folder := &_cmplib_path; 

/* Create FCMP cmplib (using source in src folder)*/

libname _cmplib "&_cmplib_path";  /*-- Output library --*/
%create_fcmp(_cmplib, &member);

/* Save _FCMP_info  dataset */

data _cmplib.&member._info;
 set _FCMP_info;
run;
ods listing close;

%let html_path = &_cmplib_path/&member._info.html;

ods html file = "&html_path";

Title "List of FCMP GROUPS in &member library member";

proc sort data= _FCMP_info out = _grps nodupkey;
by fcmp_grp;
run;

proc print data = _grps;
var fcmp_grp;
run;

Title "List of funs/subs in &member library member (by fcmp_grp)";
proc print data =_FCMP_info;
by fcmp_grp;
run;
ods html close;


