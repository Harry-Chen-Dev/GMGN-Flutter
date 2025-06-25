import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/market_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/token_card.dart';
import '../../widgets/quick_action_card.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final walletProvider = Provider.of<WalletProvider>(context, listen: false);
            final marketProvider = Provider.of<MarketProvider>(context, listen: false);
            await Future.wait([
              walletProvider.refreshWallet(),
              marketProvider.refreshMarketData(),
            ]);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 24),

                // Portfolio Overview
                _buildPortfolioOverview(),
                const SizedBox(height: 24),

                // Quick Actions
                _buildQuickActions(),
                const SizedBox(height: 24),

                // Top Tokens
                _buildTopTokens(),
                const SizedBox(height: 24),

                // Market Overview
                _buildMarketOverview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '欢迎回来！',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  authProvider.user?.username ?? 'Guest',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                await authProvider.logout();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              },
              icon: const Icon(
                Icons.logout,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        );
      },
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildPortfolioOverview() {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, child) {
        if (walletProvider.isLoading) {
          return _buildLoadingCard();
        }

        final wallet = walletProvider.wallet;
        if (wallet == null) {
          return _buildErrorCard('无法加载钱包数据');
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryGreen,
                Color(0xFF00B894),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '总资产',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${NumberFormat('#,##0.00').format(wallet.totalBalanceUsd)}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatItem('币种数量', '${wallet.tokens.length}'),
                  const SizedBox(width: 24),
                  _buildStatItem('24h 变化', '+\$2,456.78'),
                ],
              ),
            ],
          ),
        );
      },
    ).animate()
      .fadeIn(delay: 200.ms, duration: 600.ms)
      .slideY(begin: 0.1, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '快捷功能',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                icon: Icons.account_balance_wallet,
                title: '钱包',
                subtitle: '查看资产',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                icon: Icons.copy,
                title: '复制交易',
                subtitle: '跟单高手',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                icon: Icons.trending_up,
                title: '市场',
                subtitle: '行情分析',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopTokens() {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, child) {
        if (walletProvider.isLoading) {
          return _buildLoadingSection('热门币种');
        }

        final wallet = walletProvider.wallet;
        if (wallet == null || wallet.tokens.isEmpty) {
          return _buildEmptySection('热门币种', '暂无持仓');
        }

        final topTokens = wallet.tokens.take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '我的持仓',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '查看全部',
                    style: TextStyle(color: AppTheme.primaryGreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...topTokens.map((token) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TokenCard(token: token),
            )),
          ],
        );
      },
    ).animate()
      .fadeIn(delay: 600.ms, duration: 600.ms)
      .slideY(begin: 0.1, delay: 600.ms, duration: 600.ms);
  }

  Widget _buildMarketOverview() {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading) {
          return _buildLoadingSection('市场概览');
        }

        final overview = marketProvider.overview;
        if (overview == null) {
          return _buildEmptySection('市场概览', '暂无数据');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '市场概览',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMarketStat(
                          '总市值',
                          '\$${NumberFormat.compact().format(overview.totalMarketCap)}',
                        ),
                      ),
                      Expanded(
                        child: _buildMarketStat(
                          '24h 交易量',
                          '\$${NumberFormat.compact().format(overview.totalVolume24h)}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMarketStat(
                          'BTC 占比',
                          '${overview.btcDominance.toStringAsFixed(1)}%',
                        ),
                      ),
                      Expanded(
                        child: _buildMarketStat(
                          'ETH 占比',
                          '${overview.ethDominance.toStringAsFixed(1)}%',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).animate()
      .fadeIn(delay: 800.ms, duration: 600.ms)
      .slideY(begin: 0.1, delay: 800.ms, duration: 600.ms);
  }

  Widget _buildMarketStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
      ),
    );
  }

  Widget _buildLoadingSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySection(String title, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            message,
            style: const TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }
}