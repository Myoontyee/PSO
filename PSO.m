clc;clear;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data：20181221
%% License：BSD 3.0
%% PSO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialization初始化种群

%% 可修改参数

f= @(x)x.*sin(x)+x.*sin(2.*x);          % 待解目标函数
xLower = 0;                             % 待解函数下限
xTop = 30;                              % 待解函数上限
Interpolation = 0.01;                   % 插值
maxIterations = 100;                    % 最大迭代次数     
selfFactor = 3;                         % 自我学习因子
crowdFactor = 3;                        % 群体学习因子 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 建议默认参数
InitialNum = 50;                        % 初始种群个数
d = 1;                                  % 空间维数
weightFactor = 0.8;                     % 惯性权重
vLower = -1;                            % 速度下限
vTop = 1;                               % 速度上限
xLimit = [xLower, xTop];                % 位置参数限制
vLimit = [vLower, vTop];                % 设置速度限制
figure(1);
% 线型颜色
Figure1 = ezplot(f,[xLower, Interpolation, xTop]);
set(Figure1,'Color','k');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 位置初始化及其图像

for i = 1:d
    x = xLimit(i, 1) + (xLimit(i, 2) - xLimit(i, 1)) * rand(InitialNum, d);
end                                     %初始种群的位置

vInitial = rand(InitialNum, d);         % 初始种群的速度
xm = x;                                 % 每个个体的历史最佳位置
ym = zeros(1, d);                       % 种群的历史最佳位置
fxm = zeros(InitialNum, 1);             % 每个个体的历史最佳适应度
fym = -inf;                             % 种群历史最佳适应度
hold on
plot(xm, f(xm), 'ro');title('参数初始化结果');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 群体更新
figure(2);
iter = 1;
record = zeros(maxIterations, 1);       % 记录器
while iter <= maxIterations
     fx = f(x) ;                        % 个体当前适应度   
     for i = 1:InitialNum      
        if fxm(i) < fx(i)
            fxm(i) = fx(i);             % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);           % 更新个体历史最佳位置
        end 
     end
if fym < max(fxm)
        [fym, nmax] = max(fxm);         % 更新群体历史最佳适应度
        ym = xm(nmax, :);               % 更新群体历史最佳位置
end                                     % 速度更新
    vInitial = vInitial * weightFactor + selfFactor * rand * (xm - x) + crowdFactor * rand * (repmat(ym, InitialNum, 1) - x);
                                        % 边界速度处理
    vInitial(vInitial > vLimit(2)) = vLimit(2);
    vInitial(vInitial < vLimit(1)) = vLimit(1);
    x = x + vInitial;                   % 位置更新
                                        % 边界位置处理
    x(x > xLimit(2)) = xLimit(2);
    x(x < xLimit(1)) = xLimit(1);
    record(iter) = fym;                 %最大值记录
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 迭代过程及其图像
    % 若想直接观看结果，可注释掉该部分
    x0 = xLower : Interpolation : xTop;
    plot(x0, f(x0), 'k-', x, f(x), 'ro');title('状态位置变化');
    pause(0.1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    iter = iter+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 收敛过程记录图像
figure(3);
plot(record,'k-');
title('收敛过程记录');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 最终状态位置图像
x0 = xLower : Interpolation : xTop;
figure(4);
plot(x0, f(x0), 'k-', x, f(x), 'ro');title('最终状态位置');
disp(['最大值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);
