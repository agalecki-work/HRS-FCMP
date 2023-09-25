data _valid_study_yrs;
/* List of acceptable study years (it s fine to be inclusive) */
 do year = 1992 to 1996, 1998 to 2030 by 2;
  output;
 end;
run;
