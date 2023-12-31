%macro cmplib_info(cmplib, member);

options cmplib = &cmplib..&member;


title ">>--- Macro `cmplib_info`  ---";
title2 "Data `_FCMP_funs`";

/* Creates auxiliary dataset with info on fcmp member */
/* Requires that `options cmplib=` is defined */
data _fcmp_info;
 length _label  $256;
 length _member $32;
 length _version $30;
 length _datestamp $30;
_label     = fcmp_member_info("label");
_member    = fcmp_member_info("fcmp_member");
_version   = fcmp_member_info("version_date");
_datestamp = fcmp_member_info("datestamp");
run;




title ">>--- Macro `cmplib_info`  ---";
title2 "Data `_FCMP_funs`";

/* Dataset contains list of FCMP functions/subroutines */
data _FCMP_funs;
 label fcmp_name ="Function/subroutine name";
 label fcmp_grp  = "Group :"; /* Function/subroutine group */;
 set &cmplib..&member(keep=name value);
 if name in ("FUNCTION", "SUBROUTI");
 length scan1 scan2 fcmp_grp fcmp_name $200;
 scan1 = scan(strip(value),2,')');
 scan2 = scan(strip(scan1), 2,"=");
 scan2 = translate(strip(scan2),"",";");
 scan2 = translate(scan2,'','"');
 fcmp_grp = translate(scan2,'',"'");
 fcmp_name =scan(strip(value),2," (");
 drop scan1 scan2;
run;

proc sort data=_FCMP_funs;
by fcmp_grp;
run;

/* List of input datasets */

/* Dataset `_study_yrs_init` with one variable `year` created */

data _datain_allinfo;
 set _study_yrs_init;  /* Data created by a local macro */
 length datain $20;
 datain = dispatch_datain(year);
 datain_blank = "No ";
 if datain  = "" then datain_blank = "Yes";
run;

/* List of variable groups  */

data _vgrps_allinfo; /* One row per var group */
 *file print;
 length vgrp $32;
 length ctype $ 1;
 list_allvgrps = bind_vgrps("?"); 
 put / list_allvgrps =;
 cnt_vgrps  = countw(list_allvgrps);
 
 do i =1 to cnt_vgrps;
   vgrp = scan(list_allvgrps, i, " ");
   if findc(vgrp,'$') then ctype ="$"; else ctype ="";
   vout_nms =  dispatch_vout(vgrp);
   cnt_vout = countw(vout_nms);
   output;
 end; 
 drop i list_allvgrps cnt_vgrps;
run; 


/* Output variables info */

data _vout_allinfo(keep = vgrp vout_nm ctype len vout_lbl);
  set _vgrps_allinfo;
  
  do i = 1 to cnt_vout;
   vout_nm = scan(vout_nms, i, " ");
   len = vout_length(vout_nm); /* Variable length */
   vout_lbl = vout_label(vout_nm);
   output;
  end;
run;

/* Input variables info */

/*---  Cartesian product of _vgrps_allinfo and _datain_allinfo ---*/

data _datain_1;
  set _datain_allinfo;
  if datain_blank = "No ";
  *** if defined = "Yes";  /* Keep rows with non-blank name */
run;

data xprod_yr_by_vgrps; /* Cartesian product of years by vgrp */
 set _datain_1;
 * label fcmp_member = "FCMP library member name";
 label vgrp  =  "Group variable name ";
 label ctype =  "Group variable type";
 label cnt_vin = "Number of input variables in a given var grp";
 ;
 length  vin_nms $ 2000;
 do i =1 to n;
  set _vgrps_allinfo point=i nobs =n;
  vin_nms = dispatch_vin(year, vgrp);
  cnt_vout = countw(vout_nms);
  cnt_vin = countw(vin_nms);
 output;
 end;
 drop vout_nms;
run;

title ">>--- Macro `cmplib_info` ends ---";

%mend cmplib_info;
