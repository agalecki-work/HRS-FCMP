
/* _setup.sas file is invoked by autoexec.sas */
/* This file contains information specific to a selected FCMP member */


%let member = template;   /*--- Select FCMP member name (Corresponds to -FCMP folder name ---*/


/* === NO changes needed below */

%let _fcmp_source_path = &HRS_FCMP_path/&member.-FCMP/src; /* FCMP member source */

%let _cmplib_path = &HRS_FCMP_path/&member.-FCMP/cmplib;
%let _aux_path = &HRS_FCMP_path/&member.-FCMP/_aux;
%let _info_path = &HRS_FCMP_path/&member.-FCMP/info;

%let _html_path = &HRS_FCMP_fullpath/&member.-FCMP/html;

Title ">>===  setup.sas:"; 
data _null_;
 file print;
  member = symget("member");
 _fcmp_source_path = symget("_fcmp_source_path");
 _cmplib_path = symget("_cmplib_path");
 _aux_path = symget("_aux_path");
 _info_path = symget("_info_path");

 _html_path = symget("_html_path");
 put / "---  Info on FCMP library for `&member` member" /;
 put "FCMP member: "  member;
 put "`_fcmp_source_path` mvar: " _fcmp_source_path;
 put "`_cmplib_path` mvar: " _cmplib_path;
 put "`_aux_path` mvar: " _aux_path;
 put "`_info_path` mvar: " _info_path;

 put "`_html_path` mvar: " _html_path;

run;



