%%%% In this file we introduce an external shock lasting for THREE year
%%%% and simulate the results.
clear;
clc;
parameter=[0.2672    0.1420    0.5837];
tech0=[0.0975 0.2601 0.1895];
n=0.0090;
g=0.062;
N0=10;
K0=5; 
L=6;
P=2;
T=30;
K(1)=K0;
N(1)=N0; 

A10=tech0(1);
A20=tech0(2);
A30=tech0(3);
A1(1)=A10;
A2(1)=A20;
A3(1)=A30;
U(1)=0;
wage(1)=0;
 for t=1:1:T   
     country_input=[K(t) N(t) L P];
     tech=[A1(t) A2(t) A3(t)];
     three_sector= three_sector_model(parameter,country_input,tech);
     Y1(t)=three_sector(1);
     Y2(t)=three_sector(2);
     Y3(t)=three_sector(3);
     GDP(t)=Y1(t)+Y2(t)+Y3(t);
     K(t+1)=three_sector(4);
     U(t)=three_sector(5);
     wage(t)=three_sector(6);
     N(t+1)=N(t)*(1+n);  
     A1(t+1)=A1(t)*(1+g);
     A2(t+1)=A2(t)*(1+g);
     A3(t+1)=A3(t)*(1+g);
 
 end
 % Shock
A1_shock(1)=A10;
A2_shock(1)=A20;
A3_shock(1)=A30;
U_shock(1)=0;
wage_shock(1)=0;
 for t=1:1:T   
     country_input=[K(t) N(t) L P];
     tech_shock=[A1_shock(t) A2_shock(t) A3_shock(t)];
     three_sector= three_sector_model(parameter,country_input,tech_shock);
     Y1_shock(t)=three_sector(1);
     Y2_shock(t)=three_sector(2);
     Y3_shock(t)=three_sector(3);
     GDP_shock(t)=Y1_shock(t)+Y2_shock(t)+Y3_shock(t);
     K(t+1)=three_sector(4);
     U_shock(t)=three_sector(5);
     wage_shock(t)=three_sector(6);
     N(t+1)=N(t)*(1+n);  
     A1_shock(t+1)=A1_shock(t)*(1+g);
     A2_shock(t+1)=A2_shock(t)*(1+g);
     A3_shock(t+1)=A3_shock(t)*(1+g);
     if t==26
         A2_shock(t+1)=0.8*A2_shock(t);
         A3_shock(t+1)=0.7*A3_shock(t);
     end
     
     if t==27
         A2_shock(t+1)=0.88*A2_shock(t-1);
         A3_shock(t+1)=0.8*A3_shock(t-1);
     end
     
     if t==28
          A2_shock(t+1)=0.95*A2_shock(t-2);
         A3_shock(t+1)=0.9*A3_shock(t-2);
         
     end
     if t==29
         A2_shock(t+1)=A2_shock(t-3);
         A3_shock(t+1)=A3_shock(t-3);
     end  
 end
 
 time=1994:1:2023;
 figure(1);
 plot( time,Y1,'Color',[0 0.4 0.54],"LineWidth",1.3);
 hold on
 plot( time,Y2,"--",'Color',[0.69 0.13 0.13],"LineWidth",1.3);
 hold on
 plot( time,Y3,"--",'Color',[0.47 0.54 0.54],"LineWidth",1.3);
 hold on
 plot( time,Y2_shock,'Color',[0.69 0.13 0.13],"LineWidth",1);
 hold on 
 plot( time,Y3_shock,'Color',[0.47 0.54 0.54],"LineWidth",1);
 legend("Agricultural Sector","Industrial Sector without Shock","Service Sector without Shock","Industrial Sector with Shock","Service Sector with Shock")
 title("GDP of Three Production Sectors");
 xlabel("Year")
 ylabel("Output");
 xlim([1998 2025]);
 ylim([0.3 8.5]);
 
figure(2);
plot(time,U,"--",'Color',[0.69 0.18 0.37] ,"LineWidth",1);
hold on
plot(time,U_shock,'Color',[0.73 0.56 0.56],"LineWidth",1.5);
title("Utility")
xlabel("Year");
ylabel("Utility");
 xlim([1998 2025]);

 figure(3);
plot(time,wage,"--",'Color',[0.85 0.80 0.80],"LineWidth",1.5);
hold on
plot(time,wage_shock,'Color',[0.54 0.52 0.43],"LineWidth",1.5);
title("Wage")
xlabel("Year");
ylabel("Wage");
 xlim([1998 2025]);

