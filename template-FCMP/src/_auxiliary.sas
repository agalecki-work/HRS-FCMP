
function data_exist(ref $) group = "aux";
 rc = exist(ref);
 if (ref = "") then rc=0;
 return(rc);
endsub;

