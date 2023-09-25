%macro populate_nagi_array;

cout[1] = nagi_walks;
cout[2] = nagi_jog; 
cout[3] = nagi_walk1; 
cout[4] = nagi_sit;
cout[5] = nagi_chair; 
cout[6] = nagi_clims;
cout[7] = nagi_clim1;
cout[8] = nagi_stoop;
cout[9] = nagi_arms;
cout[10] = nagi_push;
cout[11] = nagi_lift;
cout[12] = nagi_dime;

%mend populate_nagi_array;

/* ====== nagi variables for all years =====*/

subroutine nagi_95_xx(studyyr, cout[*], cin[*]) group ="nagi";
 outargs cout;
    
   nagi_walks   = FQ_fun(studyyr, cin[1]);
   nagi_jog     = FQ_fun(studyyr, cin[2]);
   nagi_walk1   = FQ_fun(studyyr, cin[3]);
   nagi_sit     = FQ_fun(studyyr, cin[4]);
   nagi_chair   = FQ_fun(studyyr, cin[5]);
   nagi_clims   = FQ_fun(studyyr, cin[6]);
   nagi_clim1   = FQ_fun(studyyr, cin[7]);
   nagi_stoop   = FQ_fun(studyyr, cin[8]);
   nagi_arms    = FQ_fun(studyyr, cin[9]);
   nagi_push    = FQ_fun(studyyr, cin[10]);
   nagi_lift    = FQ_fun(studyyr, cin[11]);
   nagi_dime    = FQ_fun(studyyr, cin[12]);
   %populate_nagi_array; /* Populate cout array */
 
endsub; /* subroutine nagi_yrs */

subroutine nagi_sub(studyyr, cout[*], cin[*]) group ="nagi";
 outargs cout;

 call nagi_95_xx(studyyr, cout, cin);

endsub; /*subroutine nagi_sub */

function nagi_vin(studyyr) $ group ="nagi";

 length vin $500;
 length cx $1;
 clist = upcase("hjklmnopqrstuvwxyz");
 length _tmpc $200; 
 _tmpc = "@G001 @G002 @G003 @G004 @G005 @G006 @G007 @G008 @G009 @G010 @G011 @G012";

 select (studyyr);             
   when (1995) vin = "D1834 D1837 D1840 D1843 D1846 D1849 D1852 D1855 D1858 D1861 D1864 D1867";      
   when (1996) vin = "E1858 E1861 E1864 E1867 E1870 E1873 E1876 E1879 E1882 E1885 E1888 E1891";      
   when (1998) vin = "F2391 F2392 F2394 F2397 F2400 F2403 F2406 F2409 F2412 F2415 F2418 F2421"; 
   when (2000) vin = "G2689 G2690 G2692 G2695 G2698 G2701 G2704 G2707 G2710 G2713 G2716 G2719";
   otherwise 
     do; 
       wv = (studyyr - 2000)/2;
       cx = substr(clist,wv,1);
       vin = translate(_tmpc, cx, "@");
     end;
 end;
 put "FUN nagi_vin(): studyyr=" studyyr ", vin=" vin;

 return(vin);
endsub; /* function nagi_vin */
