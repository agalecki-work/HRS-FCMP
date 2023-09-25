
/*--- autoexec.sas in HRS-FCMP folder ---*/

options nocenter mprint nodate;

%let HRS_FCMP_path = .;                     /* !!!  Provide path to HRS_FCMP folder */


%let _setup_path = &HRS_FCMP_path/_setup.sas;


/*--- No changes needed below ----*/

options formdlim=" ";
filename HRS_FCMP "&HRS_FCMP_path"; 
%let HRS_FCMP_fullpath = ;
title ">> ==== autoexec. sas:   ===="; 
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
  put "  `HRS_FCMP_path`:" HRS_FCMP_path;
  put "  FULL path:      " HRS_FCMP_fullpath;
  put "  Exists:         " text;
run;

%let macros_path = &HRS_FCMP_path/_macros;
filename _macros "&macros_path";
%include _macros(create_fcmp_lib);
%include _macros(filenamesInFolder);
%include _macros(cmplib_info);
%include _macros(nobs);  

filename _setup "&_setup_path";


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

%include _setup;





