import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/market_provider.dart';
import '../../providers/copy_trading_provider.dart';
import '../wallet/wallet_page.dart';
import '../copy_trading/copy_trading_page.dart';
import '../market/market_page.dart';
import 'home_dashboard.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final List<Widget> _pages = [
    const HomeDashboard(),
    const WalletPage(),
    const CopyTradingPage(),
    const MarketPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      final marketProvider = Provider.of<MarketProvider>(context, listen: false);
      final copyTradingProvider = Provider.of<CopyTradingProvider>(context, listen: false);

      walletProvider.loadWallet();
      marketProvider.loadMarketData();
      copyTradingProvider.loadCopyTradingWallets();
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppTheme.borderDark, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.cardDark,
          selectedItemColor: AppTheme.primaryGreen,
          unselectedItemColor: AppTheme.textTertiary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: '钱包',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.copy_outlined),
              activeIcon: Icon(Icons.copy),
              label: '复制交易',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined),
              activeIcon: Icon(Icons.trending_up),
              label: '市场',
            ),
          ],
        ),
      ),
    );
  }
}