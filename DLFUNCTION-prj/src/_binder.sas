function fcmp_member_info(item $) $ group = "binder";
/*-- Povides info on FCMP member */
 length tx  $20;
 length res $200; 
 tx = lowcase(item);
 select(tx);
    when ("label")        res= "Functional Limitations and Helpers";
    when ("fcmp_member")  res= "DLFunction";
    when ("version_date") res= "08MAR2023";
    when ("datestamp")    res= put("&sysdate9"d, DATE9.);
  otherwise res= "hrs_project_info items: label fcmp_member version_date datestamp"; 
  end;
return (res);
endsub;


function bind_vgrps(select_vgrps $) $ group = "binder";
  /* Changed Dec. 25, 2022 */
  /* Returns list of variable groups */ 
  length grplist select_vgrps $ 5000;
  /* Include all variable groups in `grplist` below.*/
  /* $ sign indicates _character_ variable group */
  grplist = select_vgrps;
  if select_vgrps = "?" then grplist = "subhh$ nagi skip adldiff adlhlp equip iadldiff iadlhlp why need"; 
  return(grplist);
endsub; 


function dispatch_datain(studyyr) $ group ="binder";
 length dt $32;
 length yr2 $2;
 length yearc $4;
 yearc = put(studyyr, 4.);  /* From numeric to character */
 yr2  = substr(yearc,3,2);

 select(studyyr);
   when(1992,1993,1994) dt ="";
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
/* Based on `vgrp` returns list of output variables */
 length vout $500;
 length _vgrp $500;
 _vgrp = lowcase(vgrp);
 select(_vgrp);
  when("subhh$")     vout = "subhh";
  when("nagi")       vout = "nagi_walks nagi_jog nagi_walk1 nagi_sit nagi_chair nagi_clims nagi_clim1 nagi_stoop nagi_arms nagi_push nagi_lift nagi_dime";
  when("skip")       vout = "skip_dress skip_other";
  when("adldiff")    vout = "adldiff_dress adldiff_walkr adldiff_bath adldiff_eat adldiff_bed adldiff_toilt";
  when("adlhlp")     vout = "adlhlp_dress adlhlp_walkr adlhlp_bath adlhlp_eat adlhlp_bed adlhlp_toilt";
  when("equip")      vout = "equip_walkr equip_bed";
  when("iadldiff")   vout = "iadldiff_meals iadldiff_shop iadldiff_phone iadldiff_meds iadldiff_money";
  when("iadlhlp")    vout = "iadlhlp_meals iadlhlp_shop iadlhlp_phone iadlhlp_meds iadlhlp_money";
  when("why")        vout = "why_meals why_shop why_phone why_meds why_money";
  when("need")       vout = "need_meds";
  otherwise;
 end;
return(vout);
endsub;      /* function dispatch_vout */

function vout_label(vout $) $ group="binder";  /* added Dec. 2022 */
/* Returns label for vout  variables */
length v $32;
length tmpc lbl $255;
v = lowcase(vout);
tmpc = "--Variable " || strip(v); 
select(v);
  when("subhh")          lbl = "SUB-HOUSEHOLD IDENTIFIER";
  when("nagi_walks")     lbl = "NAGI DIFFICULTY - WALKING SEVERAL BLOCKS";
  when("nagi_jog")       lbl = "NAGI DIFFICULTY - JOGGING 1 MILE"; 
  when("nagi_walk1")     lbl = "NAGI DIFFICULTY - WALKING 1 BLOCK"; 
  when("nagi_sit")       lbl = "NAGI DIFFICULTY - SITTING 2 HOURS"; 
  when("nagi_chair")     lbl = "NAGI DIFFICULTY - GETTING UP FROM CHAIR"; 
  when("nagi_clims")     lbl = "NAGI DIFFICULTY - CLIMBING STAIRS"; 
  when("nagi_clim1")     lbl = "NAGI DIFFICULTY - CLIMBING 1 FLIGHT OF STAIRS"; 
  when("nagi_stoop")     lbl = "NAGI DIFFICULTY - STOOPING"; 
  when("nagi_arms")      lbl = "NAGI DIFFICULTY - REACHING ARMS"; 
  when("nagi_push")      lbl = "NAGI DIFFICULTY -  PULL/PUSH LARGE OBJECTS"; 
  when("nagi_lift")      lbl = "NAGI DIFFICULTY - LIFTING WEIGHTS"; 
  when("nagi_dime")      lbl = "NAGI DIFFICULTY -  PICKING UP DIME";
  when("skip_dress")     lbl = "SKIP DRESS ADL FLAG";
  when("skip_other")     lbl = "SKIP OTHER ADL FLAG";
  when("adldiff_dress")  lbl = "ADL DIFFICULTY - DRESSING";
  when("adldiff_walkr")  lbl = "ADL DIFFICULTY - WALKING ACROSS ROOM";
  when("adldiff_bath")   lbl = "ADL DIFFICULTY - BATHING OR SHOWERING";
  when("adldiff_eat")    lbl = "ADL DIFFICULTY - EATING";
  when("adldiff_bed")    lbl = "ADL DIFFICULTY - GET IN/OUT OF BED";
  when("adldiff_toilt")  lbl = "ADL DIFFICULTY - USING THE TOILET";
  when("adlhlp_dress")   lbl = "ADL HELP - DRESSING";
  when("adlhlp_walkr")   lbl = "ADL HELP - WALKING ACROSS ROOM";
  when("adlhlp_bath")    lbl = "ADL HELP - BATHING OR SHOWERING";
  when("adlhlp_eat")     lbl = "ADL HELP - EATING";
  when("adlhlp_bed")     lbl = "ADL HELP - GET IN/OUT OF BED";
  when("adlhlp_toilt")   lbl = "ADL HELP - USING THE TOILET";
  when("equip_walkr")    lbl = "ADL EQUIPMENT - WALKING ACROSS ROOM";
  when("equip_bed")      lbl = "ADL EQUIPMENT - GET IN/OUT OF BED";
  when("iadldiff_meals") lbl = "IADL DIFFICULTY - PREPARING HOT MEALS"; 
  when("iadldiff_shop")  lbl = "IADL DIFFICULTY - SHOP FOR GROCERIES";
  when("iadldiff_phone") lbl = "IADL DIFFICULTY - USE TELEPHONE";
  when("iadldiff_meds")  lbl = "IADL DIFFICULTY - TAKE MEDICATIONS";
  when("iadldiff_money") lbl = "IADL DIFFICULTY - MANAGING MONEY";
  when("iadlhlp_meals")  lbl = "IADL HELP - PREPARING HOT MEALS"; 
  when("iadlhlp_shop")   lbl = "IADL HELP - SHOP FOR GROCERIES";
  when("iadlhlp_phone")  lbl = "IADL HELP - USE TELEPHONE";
  when("iadlhlp_meds")   lbl = "IADL HELP - TAKE MEDICATIONS";
  when("iadlhlp_money")  lbl = "IADL HELP - MANAGING MONEY";
  when("why_meals")      lbl = "IADL REASON - PREPARING HOT MEALS"; 
  when("why_shop")       lbl = "IADL REASON - SHOP FOR GROCERIES";
  when("why_phone")      lbl = "IADL REASON - USE TELEPHONE";
  when("why_meds")       lbl = "IADL REASON - TAKE MEDICATIONS";
  when("why_money")      lbl = "IADL REASON - MANAGING MONEY";
  when("need_meds")      lbl = "IADL IF NEEDED DIFFICULTY - TAKE MEDICATIONS";
  otherwise lbl =tmpc;
end;
return(lbl);
endsub;


function vout_length(vout $)  group = "binder";  /* added Dec. 2022 */
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

/* Based on `studyyr` and `vgrp` returns list of input variables */
 length vin $500;
 length _vgrp $500;
 _vgrp = lowcase(vgrp);
 
   select(_vgrp);
   when("subhh$")     vin = subhh_vin(studyyr);
   when("nagi")       vin = nagi_vin(studyyr);
   when("skip")       vin = skip_vin(studyyr);
   when("adldiff")    vin = adldiff_vin(studyyr);
   when("adlhlp")     vin = adlhlp_vin(studyyr);
   when("equip")      vin = equip_vin(studyyr);
   when("iadldiff")   vin = iadldiff_vin(studyyr);
   when("iadlhlp")    vin = iadlhlp_vin(studyyr);
   when("why")        vin = why_vin(studyyr);
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
  when("skip")        call skip_sub(studyyr, cout, cin);
  when("nagi")        call nagi_sub(studyyr, cout, cin);
  when("adldiff")     call adldiff_sub(studyyr, cout, cin);
  when("adlhlp")      call adlhlp_sub(studyyr, cout, cin);
  when("equip")       call equip_sub(studyyr, cout, cin);
  when("iadldiff")    call iadldiff_sub(studyyr, cout, cin);
  when("iadlhlp")     call iadlhlp_sub(studyyr, cout, cin);
  when("why")         call why_sub(studyyr, cout, cin);
  when("need")        call need_sub(studyyr, cout, cin);
  otherwise;
 end;
endsub; /* subroutine exec_vgrpx */;

function exec_vgrpc(studyyr, vgrp $, cin[*] $) $ group ="binder";
/* Used for _character_  variable groups only */ 
 
 length _vgrpc $50;
 _vgrpc = lowcase(vgrp);
 select(_vgrpc);
  when("subhh$")  cout = subhh_cfun(cin);      /* Character value */;
  otherwise;
 end;
 return(cout);
endsub; /* function exec_vgrpc */

