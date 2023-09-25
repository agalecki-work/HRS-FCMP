function FQ_fun(studyyr, var_old) group ="aux"; 
/* Auxiliary function */
  var_new = var_old;

  select (var_old);
    when (1) var_new = 1;       
    when (5) var_new = 0;
    when (97) var_new =.O; 
	when (.,-8) var_new =.M;      
    when (8,98) var_new =.D;    
    when (9,99) var_new =.R;    
    otherwise;
  end;

  return(var_new);
 endsub; /* end function FQ_fun */
 
 function studyyr_ok(yr) group ="aux";
  ok  = 1;
  select;
    when(yr = .)    ok =0;
    when(yr < 1992) ok =0;
    when(yr > 1996 and mod(yr,2)=1) ok =0;
    when(yr > 2030) ok = 0;
    otherwise;
  end;
  return(ok); /* function studyyr_ok */
 endsub; 

function data_exist(ref $) group = "aux";
 rc = exist(ref);
 if (ref = "") then rc=0;
 return(rc);
endsub;

