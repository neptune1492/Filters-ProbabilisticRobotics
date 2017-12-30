IR_Results = [];
AC_Results = [];
for i=0:25
    IR_Results = [IR_Results IR_detect(i)];
    AC_Results = [AC_Results AC_detect(i)];
end