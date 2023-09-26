
function data_exist(ref $) group = "aux";
 rc = exist(ref);
 if (ref = "") then rc=0;
 return(rc);
endsub;

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