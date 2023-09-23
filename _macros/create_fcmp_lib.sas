%macro create_fcmp(cmplib, member);  
%* cmplib_name.  Ex. DLfunction;
%* fcmp_path  (global) Ex. .;
%let sas_prog = create_cmplib;

%put FCMP member: `%upcase(&member)` is created  ... OK;
%put Macro `create_fcmp_lib` is invoked by &sas_prog..sas script ... OK;
%put Log (i.e. this file) is stored in &_cmplib_info_path/&member folder;

/*--- Create dataset `filenames`with the list of source files */ 

%let fcmp_src_path = &_fcmp_source_path;       /* Ex.  ./fcmp_src */
%put fcmp_src_path = &fcmp_src_path;
%filenamesInFolder(&fcmp_src_path);  /* Dataset `_filenames` created */
%let fcmp_files =;      /* Ex. _binder _auxiliary ... */
data _filenames;
  length filenames $5000;
  set _filenames end = last;
  retain filenames;
  if upcase(scan(fname, 2, ".")) = "SAS" then do;
  filenames = strip(filenames) || " " || strip(fname);
  end;
  if last then call symput("fcmp_files", strip(filenames));
run;
%put fcmp_files := &fcmp_files;


filename _source  "&fcmp_src_path";     /* Ex.  filename _source './src/DLfunction' */
%let _source_info = _source(&fcmp_files);
%put  _source_info = &_source_info;

proc datasets library = &cmplib kill;
run;
quit;

proc fcmp outlib = &cmplib..&member..all; /* 3 level name */
%include &_source_info;

run;
quit; /* FCMP */

options cmplib = &cmplib..&member;


data _FCMP_info;
 label fcmp_name ="Function/subroutine name";
 label fcmp_grp  ="Function/subroutine group";
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

proc sort data=_FCMP_info;
by fcmp_grp;
run;
%mend create_fcmp;
