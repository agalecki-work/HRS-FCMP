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

libname _cmplib    "&_cmplib_path";  /*-- Output library --*/

%create_fcmp(_cmplib, &member);
%cmplib_info(_cmplib, &member);


/*--- Save _FCMP info  datasets  ---*/

libname _infolib "&_info_path"; 

data _infolib.&member._funs;
 set _FCMP_funs;
run;

data _infolib.&member._datain;
 set _datain_allinfo;
run;

data _infolib.&member._vgrps;
 set _vgrps_allinfo;
run;

data _infolib.&member._vout;
 set _vout_allinfo;
run;

data _infolib.&member._vin_grps;
 set xprod_yr_by_vgrps;
run;



/*--- Create html files ---*/
ods listing close;

ods html path ="&_html_path" 
         body = "&member._info-body.html"
         contents= "&member._info-contents.html"
         frame = "&member._info-frame.html"
         ;
         


proc sort data= _FCMP_funs out = FCMP_grps nodupkey;
by fcmp_grp;
run;

%let mydata = FCMP_grps;
ods proclabel "FCMP groups (%nobs)";
Title "FCMP Groups of funs/subs in &member FCMP library member (%nobs)";
proc print data = FCMP_grps  contents = "- list";
var fcmp_grp;
run;

%let mydata = _FCMP_funs;
ods proclabel "FCMP Funs/subs (%nobs)";
Title "FCMP funs/subs in &member library member (by fcmp_grp, n = %nobs)";
proc print data =_FCMP_funs  contents = "- by group";
* by fcmp_grp;
run;
quit;

%let mydata = _datain_allinfo;
ods proclabel "Datain (%nobs)";
Title "Datain (%nobs)";
Title2 "Using calls `dispatch_datain(year)`";
proc print data= _datain_allinfo  contents = "- list";
run;

%let mydata = _vgrps_allinfo;
Title "Var groups (%nobs)";
Title2 ' vgrps_list =bind_vgrps("?"), vout_nms = dispatch_vout(vgrp)';
ods proclabel "Var groups (%nobs)";
proc print data= _vgrps_allinfo contents = "- list";
run;

%let mydata = _vout_allinfo;
Title "Output vars (%nobs)";
Title2 "Syntax: len = vout_length(vout_nm), vout_lbl = vout_label(vout_nm)";
ods proclabel "Output vars (%nobs)";
proc print data= _vout_allinfo contents = "- list";
var vout_nm vgrp ctype len vout_lbl;
run;

%let mydata = xprod_yr_by_vgrps;
Title "Input vars  (%nobs)";
ods proclabel "Input vars (%nobs)";
proc print data= xprod_yr_by_vgrps contents = "- by year var_grp";
run;

ods html close;


