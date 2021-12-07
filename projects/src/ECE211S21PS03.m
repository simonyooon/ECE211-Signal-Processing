% Simon Yoon ECE211S21PS03
clc
clear
close all
%% Number 1

x = linspace(-5,5,1000);

y1 = 3* (heaviside(x+2) - heaviside(x-1)); % h(t)
y2 = exp(-2.*x).*heaviside(x); % x(t)
y3 = conv(y1,y2,"same").*.01;

figure(1);

xlabel('time (t)');
ylabel('h(t), x(t), y(t)')
title('Superimposed Convolution of x(t) and h(t)')
axis([-5 5 -2 5])

hold on;
plot(x,y1)
plot(x,y2)
plot(x,y3)
legend('h(t)', 'x(t)', 'y(t) = x(t)*h(t)')
%% Number 2

x = struct();
h = struct();
y = struct();

x.data = [2,1,0,-1,3];
x.start = -2;
h.data = [2,1,3];
h.start = 1;

[y.data,y.start] = convolute(x,h)

GraphStemPlot(x,1,"x[n]");
GraphStemPlot(h,2,"h[n]");
GraphStemPlot(y,3,"y[n] = x[n]*h[n]");

fprintf("Length of y: %d \n", length(y.data));
fprintf("Support of y: [%d, %d] \n", y.start, y.start + length(y.data)-1);
fprintf("Length of h: %d \n", length(h.data));
fprintf("Support of h: [%d, %d] \n", h.start, h.start + length(h.data)-1);
fprintf("Length of x: %d \n", length(x.data));
fprintf("Support of x: [%d, %d] \n", x.start, x.start + length(x.data)-1);
fprintf("Expected Length of y: %d \n", length(h.data) +length(x.data) -1);
fprintf("Expected Support of y: [%d, %d] \n", h.start + x.start, h.start + length(h.data)-1 +(x.start + length(x.data)-1));
fprintf("y[1] = 7");
%%
function stemplot = GraphStemPlot(struc,subPlotPos,subPlotTitle)
  
    bounds = struc.start:(length(struc.data) + struc.start - 1);
    figure(2);
    
    hold on;
    subplot(2,2,subPlotPos)
    stemplot = stem(bounds,struc.data)
    xlabel('n')
    title(subPlotTitle)
end

function [data, start] = convolute(fx1, fx2)
    data = conv(fx1.data, fx2.data);
    start = fx1.start + fx2.start;
end