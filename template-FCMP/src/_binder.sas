function fcmp_member_info(item $) $ group = "binder";
/*-- Povides info on FCMP member */
 length tx  $20;
 length res $200; 
 tx = lowcase(item);
 select(tx);
    when ("label")        res= "Template FCMP member";
    when ("fcmp_member")  res= "Template";
    when ("version_date") res= "22SEP2023";
    when ("datestamp")    res= put("&sysdate9"d, DATE9.);
  otherwise res= "hrs_project_info items: label fcmp_member version_date datestamp"; 
  end;
return (res);
endsub;


function bind_vgrps(select_vgrps $) $ group = "binder";
  /* Returns list of variable groups */ 
  length grplist select_vgrps $ 5000;
  /* Include all variable groups in `grplist` below.*/
  /* $ sign indicates _character_ variable group */
  grplist = select_vgrps;
  if select_vgrps = "?" then grplist = "subhh$ skip need"; 
  return(grplist);
endsub; 


function dispatch_datain(studyyr) $ group ="binder";
 /* Returns input dataset name for a given study year */
 length dt $32;
 length yr2 $2;
 length yearc $4;
 yearc = put(studyyr, 4.);  /* From numeric to character */
 yr2  = substr(yearc,3,2);

 select(studyyr);
   when(1992, 1993, 1994) dt ="";
   when(1995) dt ="a95e_r";
   when(1996) dt ="h96e_r";
   when(1998) dt ="h98e_r";
   when(2000) dt ="h00e_r";
   otherwise  dt ="h"||yr2||"g_r";
 end;  
 if studyyr_ok(studyyr) = 0 then dt = "";
return(dt);
endsub; /* function dispatch_datain */

function dispatch_vout(vgrp $) $ group ="binder";
/* Based on `vgrp` returns list of output (vout) variables */
 length vout $500;
 length _vgrp $500;
 _vgrp = lowcase(vgrp);
 select(_vgrp);
  when("subhh$")     vout = "subhh";
  when("skip")       vout = "skip_dress skip_other";
  when("need")       vout = "need_meds";
  otherwise;
 end;
return(vout);
endsub;      /* function dispatch_vout */

function vout_label(vout $) $ group="binder";  /* added Dec. 2022 */
/* Returns label for vout  variable */
length v $32;
length tmpc lbl $255;
v = lowcase(vout);
tmpc = "--Variable " || strip(v); 
select(v);
  when("subhh")          lbl = "SUB-HOUSEHOLD IDENTIFIER";
  when("skip_dress")     lbl = "SKIP DRESS ADL FLAG";
  when("skip_other")     lbl = "SKIP OTHER ADL FLAG";
  when("need_meds")      lbl = "IADL IF NEEDED DIFFICULTY - TAKE MEDICATIONS";
  otherwise lbl =tmpc;
end;
return(lbl);
endsub;


function vout_length(vout $)  group = "binder";
/* Returns length for vout  variable */
/* It is mandatory to provide length for character variables */
length v $32;
length tmpc len $10;
v = lowcase(vout); 
select(v);
  when("subhh") len = 1;
  otherwise;
end;
return(len);
endsub;


function dispatch_vin(studyyr, vgrp $) $ group ="binder";

/* Based on `studyyr` and `vgrp` returns character string with a list of input variables */
 length vin $500;
 length _vgrp $500;
 _vgrp = lowcase(vgrp);
 
  select(_vgrp);
   when("subhh$")     vin = subhh_vin(studyyr);
   when("skip")       vin = skip_vin(studyyr);
   when("need")       vin = need_vin(studyyr);
   otherwise;
  end;
return(vin);
endsub;  


subroutine exec_vgrpx(studyyr, vgrp $, cout[*], cin[*]) group ="binder";
/* Used for _numeric_  variable groups only */ 
 
 /* Check studyyr, vgrp arguments */
 outargs cout;
 length _vgrpx $50;
 _vgrpx = lowcase(vgrp);
 select(_vgrpx);
  when("skip")      call skip_sub(studyyr, cout, cin);
  when("skip")      call need_sub(studyyr, cout, cin);
  otherwise;
 end;
endsub; /* subroutine exec_vgrpx */;

function exec_vgrpc(studyyr, vgrp $, cin[*] $) $ group ="binder";
/* Function used for _character_  variable groups only */ 
 
 length _vgrpc $50;
 _vgrpc = lowcase(vgrp);
 select(_vgrpc);
  when("subhh$")  cout = subhh_cfun(cin);      /* Character value */;
  otherwise;
 end;
 return(cout);
endsub; /* function exec_vgrpc */

