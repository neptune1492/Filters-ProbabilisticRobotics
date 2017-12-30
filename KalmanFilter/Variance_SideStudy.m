IR_Results = [];
AC_Results = [];
true_measure1 = [];
true_measure2 = [];
IRvar = [];
ACvar= [];
resultsAC = [];
resultsIR = [];

for i=1:25
    
    for j = 1:10
        m = IR_detect(i);
        if (isempty(m) ~= 1)
            IR_Results = [IR_Results IR_detect(i)];
            IRvar = [IRvar var(IR_Results)];
        end
    
        n = AC_detect(i);
        if(isempty(n) ~= 1)
            AC_Results = [AC_Results AC_detect(i)];
            ACvar = [ACvar var(AC_Results)];
        end
    end
    
    
end

        resultsIR = [resultsIR; mean(IRvar)];
        resultsSection = [1];


        resultsAC = [resultsAC; mean(ACvar)];
        
    
   IR_Results = [];
   AC_Results = [];
   IRvar = [];
   ACvar = [];
for i = 26:50
     for j = 1:10
        m = IR_detect(i);
        if (isempty(m) ~= 1)
            IR_Results = [IR_Results IR_detect(i)];
            IRvar = [IRvar var(IR_Results)];
        end
    
        n = AC_detect(i);
        if(isempty(n) ~= 1)
            AC_Results = [AC_Results AC_detect(i)];
            ACvar = [ACvar var(AC_Results)];
        end
    end
    
    
end
resultsIR = [resultsIR; mean(IRvar)];
        resultsSection = [resultsSection;2];


        resultsAC = [resultsAC; mean(ACvar)];
        
         IR_Results = [];
   AC_Results = [];
   IRvar = [];
   ACvar = [];
for i=51:75
    for j = 1:10
        m = IR_detect(i);
        if (isempty(m) ~= 1)
            IR_Results = [IR_Results IR_detect(i)];
            IRvar = [IRvar var(IR_Results)];
        end
    
        n = AC_detect(i);
        if(isempty(n) ~= 1)
            AC_Results = [AC_Results AC_detect(i)];
            ACvar = [ACvar var(AC_Results)];
        end
    end
end
resultsIR = [resultsIR; mean(IRvar)];
        resultsSection = [resultsSection;3];


        resultsAC = [resultsAC; mean(ACvar)];
        
         IR_Results = [];
   AC_Results = [];
   IRvar = [];
   ACvar = [];
for i=76:100
    for j = 1:10
        m = IR_detect(i);
        if (isempty(m) ~= 1)
            IR_Results = [IR_Results IR_detect(i)];
            IRvar = [IRvar var(IR_Results)];
        end
    
        n = AC_detect(i);
        if(isempty(n) ~= 1)
            AC_Results = [AC_Results AC_detect(i)];
            ACvar = [ACvar var(AC_Results)];
        end
        
    end
end
resultsIR = [resultsIR; mean(IRvar)];
        resultsSection = [resultsSection;4];

        resultsAC = [resultsAC; mean(ACvar)];
        
        figure
        plot(resultsSection, resultsIR);
        title('Variance of IR sensor as distance increases');
        xlabel('Distance section (0-25, 25-50,...75-100)');
        ylabel('variance');
        
      figure
      plot(resultsSection, resultsAC);
        title('Variance of AC sensor as distance increases');
        xlabel('Distance section (0-25, 25-50,...75-100)');
        ylabel('variance');