%macro create_fcmp(cmplib, member);  
%* cmplib_name.  Ex. DLfunction;
%* fcmp_path  (global) Ex. .;
%let sas_prog = create_cmplib;

%put FCMP member: `%upcase(&member)` is created  ... OK;
%put Macro `create_fcmp_lib` is invoked by &sas_prog..sas script ... OK;
%put Log (i.e. this file) is stored in &_cmplib_path  folder;

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


filename _source  "&fcmp_src_path";     /* Ex.  filename _source  */
%let _source_info = _source(&fcmp_files);
%put  _source_info = &_source_info;

%filenamesInFolder(&_cmplib_path);  /* Dataset `_filenames` created */
title "Folder : &_cmplib_path";
**title2 "List of files in this folder";
**proc print data = _filenames;
run;

data html_files;
 set _filenames;
 length fpath $ 200;
 length fref $8;
 fref = "tmp_file";
 if upcase(scan(fname, 2, ".")) = "HTML";
 fpath = "&_cmplib_path" || "/" || strip(fname);
 rc=filename(fref, fpath);
 if rc = 0 and fexist(fref) then
        rc=fdelete(fref);
     rc=filename(fref);
run;

**Title "HTML files listed (they were deleted)";
**proc print data = html_files;
run;

proc datasets library = &cmplib kill;
run;
quit;

proc fcmp outlib = &cmplib..&member..all; /* 3 level name */
%include &_source_info;

run;
quit; /* FCMP */

%mend create_fcmp;
