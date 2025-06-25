# GMGN.AI Flutter Web 应用

一个像素级精度复刻 GMGN.AI 移动端应用的 Flutter Web 项目，包含智能复制交易功能。

## 📱 项目概述

本项目是基于 Flutter Web 技术栈开发的加密货币复制交易应用，具有以下特色：

- 🎯 **像素级还原**：高度还原 GMGN.AI 移动端页面设计
- 📱 **响应式设计**：优先适配移动端，支持多种屏幕尺寸
- 🚀 **现代化UI**：采用暗色主题，流畅的动画效果
- 🔄 **实时数据**：模拟实时的市场数据和交易信息
- 💎 **高质量代码**：遵循 Flutter 最佳实践，代码结构清晰

## 🛠️ 技术栈

- **前端框架**: Flutter Web
- **状态管理**: Provider
- **UI设计**: Material Design 3
- **动画库**: flutter_animate
- **图表库**: fl_chart
- **字体**: Google Fonts (Inter)
- **数据持久化**: SharedPreferences
- **网络请求**: HTTP (Mock数据)

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Web 浏览器（推荐 Chrome）

### 安装依赖

```bash
# 克隆项目
git clone https://github.com/your-username/gmgn-flutter-web.git
cd gmgn-flutter-web

# 安装依赖
flutter pub get
```

### 本地运行

```bash
# 运行开发服务器
flutter run -d chrome

# 或指定端口
flutter run -d chrome --web-port 8080
```

### 构建生产版本

```bash
# 构建 Web 应用
flutter build web

# 构建产物位于 build/web/ 目录
```

## 📦 项目结构

```
lib/
├── main.dart                 # 应用入口
├── theme/
│   └── app_theme.dart       # 主题配置
├── models/                  # 数据模型
│   ├── user_model.dart
│   ├── wallet_model.dart
│   ├── copy_trading_model.dart
│   └── market_model.dart
├── providers/               # 状态管理
│   ├── auth_provider.dart
│   ├── wallet_provider.dart
│   ├── market_provider.dart
│   └── copy_trading_provider.dart
├── services/               # 业务逻辑服务
│   ├── auth_service.dart
│   ├── wallet_service.dart
│   ├── market_service.dart
│   └── copy_trading_service.dart
├── pages/                  # 页面组件
│   ├── splash_page.dart
│   ├── auth/
│   │   ├── login_page.dart
│   │   └── register_page.dart
│   ├── home/
│   │   ├── home_page.dart
│   │   └── home_dashboard.dart
│   ├── wallet/
│   │   └── wallet_page.dart
│   ├── copy_trading/
│   │   └── copy_trading_page.dart
│   └── market/
│       └── market_page.dart
└── widgets/                # 通用组件
    ├── custom_button.dart
    ├── custom_text_field.dart
    ├── token_card.dart
    ├── trader_card.dart
    ├── transaction_card.dart
    ├── market_token_card.dart
    └── quick_action_card.dart
```

## 🎨 核心功能

### 1. 用户认证
- 登录/注册功能
- 演示账号支持
- 状态持久化

### 2. 钱包总览
- 总资产显示
- 币种余额列表
- 实时价格更新
- 交易记录查看

### 3. 复制交易
- 交易员列表展示
- 关注/取消关注功能
- 收益率统计
- 交易历史记录

### 4. 市场行情
- 实时价格数据
- 市场概览统计
- 排序和筛选
- 涨跌幅显示

## 🔐 演示账号

```
邮箱: admin@gmgn.ai
密码: 123456

邮箱: trader@gmgn.ai  
密码: 123456
```

## 🌐 GitHub Pages 部署

### 方法一：手动部署

```bash
# 构建项目
flutter build web --base-href "/gmgn-flutter-web/"

# 复制构建产物到 docs 文件夹
cp -r build/web/* docs/

# 提交到 GitHub
git add .
git commit -m "Deploy to GitHub Pages"
git push origin main
```

### 方法二：GitHub Actions 自动部署

在 `.github/workflows/deploy.yml` 中配置自动部署：

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        
    - run: flutter pub get
    - run: flutter build web --base-href "/gmgn-flutter-web/"
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
```

## 🎨 设计特色

### 颜色方案
- **主色调**: #00D4AA (薄荷绿)
- **背景色**: #121212 (深灰)
- **卡片色**: #1E1E1E (中灰)
- **文字色**: #FFFFFF / #8E8E93 / #5A5A5A

### 动画效果
- 页面切换动画
- 卡片加载动画
- 按钮交互反馈
- 数据刷新指示

### 响应式设计
- 移动端优先设计
- 自适应布局
- 触摸友好的交互

## 🚧 开发计划

- [ ] 添加图表组件显示价格走势
- [ ] 实现实时WebSocket数据更新
- [ ] 添加更多交易功能
- [ ] 支持多语言国际化
- [ ] 优化性能和加载速度
- [ ] 添加暗色/亮色主题切换

## 🤝 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目基于 MIT 许可证开源 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

如有问题或建议，请通过以下方式联系：

- GitHub Issues: [提交问题](https://github.com/your-username/gmgn-flutter-web/issues)
- Email: your-email@example.com

---

⭐ 如果这个项目对你有帮助，请给它一个 Star！