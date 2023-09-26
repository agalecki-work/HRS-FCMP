

/* This file contains information specific to a selected FCMP member */
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*"
options formdlim=" ";
filename HRS_FCMP "&HRS_FCMP_path"; 
%let HRS_FCMP_fullpath = ;
title ">> _setup.sas:   ===="; 
data _null_;
  file print;
  HRS_FCMP_path = symget("HRS_FCMP_path");
  HRS_FCMP_fullpath = pathname("HRS_FCMP");
  call symput("HRS_FCMP_fullpath", strip(HRS_FCMP_fullpath));
  rc = fexist("HRS_FCMP");
  select(rc);
   when (1) text = "... Yes";
   when (0) text = "... No ";
   otherwise;
  end;
  put / " --- Info on HRS_FCMP project folder" /;
  put "  Fileref:          HRS_FCMP";
  put "  `HRS_FCMP_path` mvar: " HRS_FCMP_path;
  put "  FULL path:      " HRS_FCMP_fullpath;
  put "  Exists:         " text;
run;

%let macros_path = &HRS_FCMP_path/_macros;
filename _macros "&macros_path";
%include _macros(create_fcmp_lib);
%include _macros(filenamesInFolder);
%include _macros(cmplib_info);
%include _macros(nobs);  


data _null_;
  file print;
 
  macros_path = symget("macros_path");
  put  / "--- Info on `_macros` subfolder" /;
  put  "  Fileref:        _macros";
  put  "  `macros_path` mvar:   " macros_path;
  put;
  
  _setup_path = symget("_setup_path");
  rc = fexist("_setup");
  select(rc);
   when (1) text = "... Yes";
   when (0) text = "... No ";
   otherwise;
  end;

  put / "--- Info on FCMP member setup file" /;
  put / "  Fileref:        _setup";
  put / "  `_setup_path` mvar:         " _setup_path;
  put / "  Exists:       " text;
  put;
run;



%let _fcmp_source_path = &HRS_FCMP_path/&member.-FCMP/src; /* FCMP member source */

%let _cmplib_path = &HRS_FCMP_path/&member.-FCMP/cmplib;
%let _lclmac_path = &HRS_FCMP_path/&member.-FCMP/macros;
%let _info_path = &HRS_FCMP_path/&member.-FCMP/info;

%let _html_path = &HRS_FCMP_fullpath/&member.-FCMP/html;

Title ">>===  setup.sas:"; 
data _null_;
 file print;
  member = symget("member");
 _fcmp_source_path = symget("_fcmp_source_path");
 _cmplib_path = symget("_cmplib_path");
 _lclmac_path = symget("_lclmac_path");
 _info_path = symget("_info_path");

 _html_path = symget("_html_path");
 put / "---  Info on FCMP library for `&member` member" /;
 put "FCMP member: "  member;
 put "`_fcmp_source_path` mvar: " _fcmp_source_path;
 put "`_cmplib_path` mvar: " _cmplib_path;
 put "`_lclmac_path` mvar: " _lclmac_path;
 put "`_info_path` mvar: " _info_path;

 put "`_html_path` mvar: " _html_path;

run;

filename _lclmac "&_lclmac_path"; 
%include _lclmac(_study_yrs_init); 
%_study_yrs_init;


