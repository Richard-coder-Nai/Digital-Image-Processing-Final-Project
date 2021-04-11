# 图像替换和风格迁移

> 作者：佴瑞乾
>
> 班级：自84
>
> 学号：2018011716
>

## 运行环境

- Windows 10 x64
- MATLAB R2019b
- GUI使用MATLAB App designer 编写

## 运行方式

### 打开GUI

- 将`src/`及`dataset/`及其子文件夹添加到路径
- 双击`GUI.mlapp`
- *由于Matlab app响应较慢，查看可能需要等待1-2s*


### 使用GUI

- 点击`Background`中的选项选择背景
- 点击`Style`中的选项选择风格
- 点击`Upload from file`可以从文件中上传图片
- 点击`Display Results`查看结果，可以选择保存

### 使用Matlab命令行
```Matlab
demo
```
4中风格迁移和3种图像替换结果将弹出窗口显示
## 目录结构

- `src/`：源代码
- `dataset/`：背景图像和相关素材，自己拍摄的图像位于`dataset/input/`，可以作为样例输入使用
- `results/`：处理结果，包括风格迁移结果和图像替换结果
- `project03report.pdf`：报告
