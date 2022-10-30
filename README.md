# 模型简介

## 网络模型结构

本项目采用带3个隐藏层的多层感知器，并带有以下特点:

- 采用以下激活函数：

  f(x) = x exp(-x^2/(2e))

- 最后一层线性层使用weight normalization。

- 所有权重都采用``mindspore``的``HeUniform``初始化。

每层的神经元数目为800, 400, 200,100和1。

## 数据集

本赛题要求在矩形、圆形、三角形和五边形内求解泊松方程。需求的数据为在这些区域内和边界的随机样本。矩形和圆形由``mindelec``自带的方法给出。三角形和五边形由本代码库给出。本项目假设所有求解区域都在[0, 1] × [0, 1]内。对于四种几何形状，训练集在区域内和边界上都随机生成10^6个点，测试集在区域内和边界上都随机生成5000个点。


# 环境要求
- mindspore 1.7.0
- mindelec 0.1.0
- numpy 1.19.5

# 脚本说明

```
├── possion_2dsss
│   ├── scripts
│   │   ├── run_eval.sh # 验证脚本
│   │   └── run_train_2d.sh # 训练脚本
│   ├── src
│   │   ├── config
│   │   │   ├── dataset_disk.yml # 圆形数据集配置
│   │   │   ├── dataset_pentagon.yml # 五边形数据集配置
│   │   │   ├── dataset_rectangle.yml # 矩形数据集配置
│   │   │   ├── dataset_triangle.yml # 三角形数据集配置
│   │   │   ├── learning_rate.yml # 学习率配置
│   │   │   └── model_2d.yml # 模型参数配置
│   │   ├── geometry # 求解区域采样方法定义
│   │   │   ├── geometry.py
│   │   │   ├── __init__.py
│   │   │   └── shapes.py
│   │   ├── core.py # 泊松方程定义
│   │   ├── dataset.py # 数据集处理定义
│   │   └── networks.py # 神经网络定义
│   ├── eval.py # 验证精度脚本
│   └── train.py # 训练脚本
└── README.md
```

# 训练和测试

## 训练超参数

- Batch size: 5000
- Epoch: 600
- Learning rate: 采用[Super-Convergence: Very Fast Training of Neural Networks Using Large Learning Rates](https://arxiv.org/abs/1708.07120)提出的动态学习率进行训练，该学习率按余弦函数先升后降。本项目选择初始学习率为2 × 10^(-5)，最大学习率为5 × 10^(-4)，最终学习率为5 × 10^(-8), pct_start=0.15（学习率上升的Epoch/总Epoch）。
- Loss function: 由``mindelec``给出的``MTLWeightedLossCell``
- Optimizer: Adam

## 训练

``python train.py DATASET_CONFIG src/config/model_2d.yml --save_dir=SAVE_DIR --n_epoch=XXX``

其中，``DATASET_CONFIG``为数据集配置文件，可选择的文件在config/文件夹内。``SAVE_DIR``为checkpoints保存路径。

在scripts/目录下运行``./run_train_2d.sh``来训练所有情况。

## 评估                                                                                     

在scripts目录下运行``./run_eval.sh``。

# 模型精度

表格内均为相对L2误差，括号内的是在测试集上的误差。矩形区域的解在边界上均为0，因此没有L2相对误差。

|        | Domain        | Boundary      |
| ------ | ------------- | ------------- |
| 矩形   | 0.04% (0.04%) | NA            |
| 圆形   | 0.05% (0.05%) | 0.22% (0.21%) |
| 三角形 | 0.10% (0.10%) | 0.38% (0.38%) |
| 五边形 | 0.08% (0.08%) | 0.29% (0.28%) |

# 参考文献
[1] Smith L N ,  Topin N . Super-Convergence: Very Fast Training of Neural Networks Using Large Learning Rates[J].  2017.


