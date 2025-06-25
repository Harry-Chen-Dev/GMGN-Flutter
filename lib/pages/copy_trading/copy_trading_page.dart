import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/copy_trading_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/trader_card.dart';

class CopyTradingPage extends StatefulWidget {
  const CopyTradingPage({super.key});

  @override
  State<CopyTradingPage> createState() => _CopyTradingPageState();
}

class _CopyTradingPageState extends State<CopyTradingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('复制交易'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CopyTradingProvider>(context, listen: false)
                  .loadCopyTradingWallets();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          _buildHeaderStats(),

          // Tabs
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.borderDark),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.primaryGreen,
              labelColor: AppTheme.primaryGreen,
              unselectedLabelColor: AppTheme.textSecondary,
              tabs: const [
                Tab(text: '热门交易员'),
                Tab(text: '已关注'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllTradersTab(),
                _buildFollowingTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard('总收益', '+\$12,456.78', Icons.trending_up),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard('胜率', '78.5%', Icons.military_tech),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard('跟单数', '12', Icons.people),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTradersTab() {
    return Consumer<CopyTradingProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
            ),
          );
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppTheme.errorRed,
                ),
                const SizedBox(height: 16),
                Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.loadCopyTradingWallets(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        if (provider.wallets.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_search_outlined,
                  size: 64,
                  color: AppTheme.textTertiary,
                ),
                SizedBox(height: 16),
                Text(
                  '暂无交易员数据',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await provider.loadCopyTradingWallets();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.wallets.length,
            itemBuilder: (context, index) {
              final wallet = provider.wallets[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TraderCard(
                  wallet: wallet,
                  onFollow: () {
                    if (wallet.isFollowing) {
                      provider.unfollowWallet(wallet.id);
                    } else {
                      provider.followWallet(wallet.id);
                    }
                  },
                  onTap: () {
                    // TODO: Navigate to trader detail page
                  },
                )
                    .animate(delay: (index * 100).ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.1, duration: 400.ms),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFollowingTab() {
    return Consumer<CopyTradingProvider>(
      builder: (context, provider, child) {
        final followingWallets =
            provider.wallets.where((w) => w.isFollowing).toList();

        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
            ),
          );
        }

        if (followingWallets.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_outlined,
                  size: 64,
                  color: AppTheme.textTertiary,
                ),
                SizedBox(height: 16),
                Text(
                  '还没有关注任何交易员',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                SizedBox(height: 8),
                Text(
                  '去"热门交易员"页面关注一些高手吧！',
                  style: TextStyle(color: AppTheme.textTertiary, fontSize: 12),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await provider.loadCopyTradingWallets();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: followingWallets.length,
            itemBuilder: (context, index) {
              final wallet = followingWallets[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TraderCard(
                  wallet: wallet,
                  onFollow: () {
                    provider.unfollowWallet(wallet.id);
                  },
                  onTap: () {
                    // TODO: Navigate to trader detail page
                  },
                )
                    .animate(delay: (index * 100).ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.1, duration: 400.ms),
              );
            },
          ),
        );
      },
    );
  }
}
