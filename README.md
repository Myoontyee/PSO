# PSO
Implementation of PSO in MATLAB   

blog:  
i)https://www.jianshu.com/p/e13c78f22bc5  
ii)https://blog.csdn.net/Myoonyee_Chen_CSDN/article/details/85169282  

---

# 背景
**粒子群优化（Particle Swarm Optimization, PSO）**，又称**微粒群算法**，是由J. Kennedy和R. C. Eberhart等[1]于1995年开发的一种演化计算技术，来源于对一个简化社会模型的模拟。其中“群（swarm）”来源于微粒群匹配M. M. Millonas在开发应用于人工生命（artificial life）的模型时所提出的群体智能的5个基本原则。“粒子（particle）”是一个折衷的选择，因为既需要将群体中的成员描述为没有质量、没有体积的，同时也需要描述它的速度和加速状态。

PSO算法最初是为了图形化的模拟鸟群优美而不可预测的运动。而通过对动物社会行为的观察，发现在群体中对信息的社会共享提供一个演化的优势，并以此作为开发算法的基础。通过加入近邻的速度匹配、并考虑了多维搜索和根据距离的加速，形成了PSO的最初版本。之后引入了惯性权重来更好的控制开发（exploitation）和探索（exploration），形成了标准版本。为了提高粒群算法的性能和实用性，中山大学、（英国）格拉斯哥大学等又开发了自适应（Adaptive PSO）版本和离散（discrete）版本。

# 特点
&emsp;&emsp;i)相较于传统算法计算速度非常快，全局搜索能力也很强；   
&emsp;&emsp;ii)PSO对于种群大小不十分敏感;    
&emsp;&emsp;iii)适用于连续函数极值问题，对于非线性、多峰问题均有较强的全局搜索能力。    
&emsp;&emsp;即    
> * **输入**
> 连续函数极值、非线性、多峰值问题
> * **f(x)**
> PSO、MOPSO、etc...
> * **输出**
> 全局较优解、全局最优解

# 变量
针对建议修改与建议默认参数均给予解释与建议值。

&emsp;&emsp;1)**待解目标函数**  

&emsp;&emsp;程序：
```
f= @(x)x.*sin(x)+x.*sin(2.*x);          % 待解目标函数
```
&emsp;&emsp;解释：
> * **输入**
> 需要求解的目标函数（该程序仅针对单目标优化）
> * **输出**
> 定义优化的目标函数
> * **Tip**
> 该处使用函数 $x\times sin(x)+x\times sin(2x)$作为目标函数检验算法，在具体的问题中修改该函数为目标函数即可，注意该处为矩阵计算，使用.* .^等进行计算

&emsp;&emsp;2)**待解函数上下限**      

&emsp;&emsp;程序：    
```
xLower = 0;                             % 待解函数下限
xTop = 30;                              % 待解函数上限
```
&emsp;&emsp;解释：    
> * **输入**
> 目标函数上下限，2个函数定义域内的值
> * **输出**
> 定义优化时自变量的上下限

&emsp;&emsp;3)**插值**     

&emsp;&emsp;程序：    
```
Interpolation = 0.01;                   % 插值
```
&emsp;&emsp;解释：   
> * **输入**
> 小于函数上下限的数值
> * **输出**
> 定义目标函数求解时的插值密度
> * **Tip**
> 理论上任意小于函数上下限的数值均可，一般取值≤0.01，越小的数值将使得目标函数连续性更好，求解时间更长

&emsp;&emsp;4)**最大迭代次数**     

&emsp;&emsp;程序：   
```
maxIterations = 100;                    % 最大迭代次数 
```
&emsp;&emsp;解释：    
> * **输入**
> 最大迭代次数数值
> * **输出**
> 定义最大迭代次数
> * **Tip**
> 取值范围一般为100~5000，依照实际情况，权衡计算时间与求解结果而定

&emsp;&emsp;5)**学习因子**     

&emsp;&emsp;程序：
```
selfFactor = 3;                         % 自我学习因子
crowdFactor = 3;                        % 群体学习因子 
```
&emsp;&emsp;解释：   
> * **输入**
> 个体（自我）与群体的学习因子
> * **输出**
> 个体、群体学习因子定义
> * **Tip**
> 取值范围一般为0~4，依照实际情况，权衡自变量取值范围而定

&emsp;&emsp;6)**速度上下限**    

&emsp;&emsp;程序：
```
vLower = -1;                            % 速度下限
vTop = 1;                               % 速度上限
```
&emsp;&emsp;解释：
> * **输入**
> 速度上下限数值
> * **输出**
> 定义学习速度的上下限数值
> * **Tip**
> i)过大速度将导致最优解被越过
ii)过小速度将导致求解速度过慢

&emsp;&emsp;7)**初始种群个数**     
&emsp;&emsp;程序：
```
InitialNum = 50;                        % 初始种群个数
```
&emsp;&emsp;解释：    

> * **输入**
> 输入初始种群个数数值
> * **输出**
> 定义初始化种群个数
> * **Tip**
> 取值范围一般为500~1000，PSO算法对种群大小不敏感，该处设定为50

&emsp;&emsp;8)**惯性权重**     
&emsp;&emsp;程序：
```
weightFactor = 0.8;                     % 惯性权重
```
&emsp;&emsp;解释：
> * **输入**
> 惯性权重数值
> * **输出**
> 定义惯性权重
> * **Tip**
> 取值范围一般为0.5~1，该参数反映个体历史成绩对现有成绩的影响

&emsp;&emsp;9)**空间维数**      
&emsp;&emsp;程序：
```
d = 1;                                  % 空间维数
```
&emsp;&emsp;解释：     
> * **输入**
> 1
> * **输出**
> 设定空间维数为1
> * **Tip**
> 该参数指代自变量个数，1意味着这是个单目标优化问题

# 结果
运行程序   

**输入**
```
PSO.m
```
**输出**
```
最大值：45.8982
变量取值：26.0839
```
![参数初始化结果](https://upload-images.jianshu.io/upload_images/15178919-0f9220f7506cbfc4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  
![状态位置变化](https://upload-images.jianshu.io/upload_images/15178919-29d041b6d037b366.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  
![收敛过程记录](https://upload-images.jianshu.io/upload_images/15178919-ffdb087028ac6500.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  
![最终状态位置](https://upload-images.jianshu.io/upload_images/15178919-cda5833b3b2f9ff3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)  

# 参考
[1]杨维, 李歧强. 粒子群优化算法综述[J]. 中国工程科学, 2004, 6(5):87-94.  
[2][粒子群优化](https://zh.wikipedia.org/wiki/%E7%B2%92%E5%AD%90%E7%BE%A4%E4%BC%98%E5%8C%96)  
[3][粒子群算法的matlab实现（一）](https://blog.csdn.net/nightmare_dimple/article/details/74331679)




