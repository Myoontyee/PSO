clc;clear;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author: Myoontyee.Chen
%% Data��20181221
%% License��BSD 3.0
%% PSO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialization��ʼ����Ⱥ

%% ���޸Ĳ���

f= @(x)x.*sin(x)+x.*sin(2.*x);          % ����Ŀ�꺯��
xLower = 0;                             % ���⺯������
xTop = 30;                              % ���⺯������
Interpolation = 0.01;                   % ��ֵ
maxIterations = 100;                    % ����������     
selfFactor = 3;                         % ����ѧϰ����
crowdFactor = 3;                        % Ⱥ��ѧϰ���� 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ����Ĭ�ϲ���
InitialNum = 50;                        % ��ʼ��Ⱥ����
d = 1;                                  % �ռ�ά��
weightFactor = 0.8;                     % ����Ȩ��
vLower = -1;                            % �ٶ�����
vTop = 1;                               % �ٶ�����
xLimit = [xLower, xTop];                % λ�ò�������
vLimit = [vLower, vTop];                % �����ٶ�����
figure(1);
% ������ɫ
Figure1 = ezplot(f,[xLower, Interpolation, xTop]);
set(Figure1,'Color','k');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% λ�ó�ʼ������ͼ��

for i = 1:d
    x = xLimit(i, 1) + (xLimit(i, 2) - xLimit(i, 1)) * rand(InitialNum, d);
end                                     %��ʼ��Ⱥ��λ��

vInitial = rand(InitialNum, d);         % ��ʼ��Ⱥ���ٶ�
xm = x;                                 % ÿ���������ʷ���λ��
ym = zeros(1, d);                       % ��Ⱥ����ʷ���λ��
fxm = zeros(InitialNum, 1);             % ÿ���������ʷ�����Ӧ��
fym = -inf;                             % ��Ⱥ��ʷ�����Ӧ��
hold on
plot(xm, f(xm), 'ro');title('������ʼ�����');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Ⱥ�����
figure(2);
iter = 1;
record = zeros(maxIterations, 1);       % ��¼��
while iter <= maxIterations
     fx = f(x) ;                        % ���嵱ǰ��Ӧ��   
     for i = 1:InitialNum      
        if fxm(i) < fx(i)
            fxm(i) = fx(i);             % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);           % ���¸�����ʷ���λ��
        end 
     end
if fym < max(fxm)
        [fym, nmax] = max(fxm);         % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmax, :);               % ����Ⱥ����ʷ���λ��
end                                     % �ٶȸ���
    vInitial = vInitial * weightFactor + selfFactor * rand * (xm - x) + crowdFactor * rand * (repmat(ym, InitialNum, 1) - x);
                                        % �߽��ٶȴ���
    vInitial(vInitial > vLimit(2)) = vLimit(2);
    vInitial(vInitial < vLimit(1)) = vLimit(1);
    x = x + vInitial;                   % λ�ø���
                                        % �߽�λ�ô���
    x(x > xLimit(2)) = xLimit(2);
    x(x < xLimit(1)) = xLimit(1);
    record(iter) = fym;                 %���ֵ��¼
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % �������̼���ͼ��
    % ����ֱ�ӹۿ��������ע�͵��ò���
    x0 = xLower : Interpolation : xTop;
    plot(x0, f(x0), 'k-', x, f(x), 'ro');title('״̬λ�ñ仯');
    pause(0.1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    iter = iter+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �������̼�¼ͼ��
figure(3);
plot(record,'k-');
title('�������̼�¼');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����״̬λ��ͼ��
x0 = xLower : Interpolation : xTop;
figure(4);
plot(x0, f(x0), 'k-', x, f(x), 'ro');title('����״̬λ��');
disp(['���ֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);
