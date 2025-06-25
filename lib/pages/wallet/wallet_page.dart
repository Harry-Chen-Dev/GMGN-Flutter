import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../providers/wallet_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/token_card.dart';
import '../../widgets/transaction_card.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with SingleTickerProviderStateMixin {
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
        title: const Text('我的钱包'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<WalletProvider>(context, listen: false).refreshWallet();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          if (walletProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
              ),
            );
          }

          if (walletProvider.errorMessage != null) {
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
                    walletProvider.errorMessage!,
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => walletProvider.loadWallet(),
                    child: const Text('重试'),
                  ),
                ],
              ),
            );
          }

          final wallet = walletProvider.wallet;
          if (wallet == null) {
            return const Center(
              child: Text(
                '暂无钱包数据',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            );
          }

          return Column(
            children: [
              // Wallet Header
              _buildWalletHeader(wallet),
              
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
                    Tab(text: '资产'),
                    Tab(text: '交易记录'),
                  ],
                ),
              ),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAssetsTab(wallet),
                    _buildTransactionsTab(wallet),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWalletHeader(wallet) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Total Balance
          Text(
            '总资产',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${NumberFormat('#,##0.00').format(wallet.totalBalanceUsd)}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Wallet Address
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${wallet.address.substring(0, 6)}...${wallet.address.substring(wallet.address.length - 4)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.copy,
                  size: 16,
                  color: AppTheme.textTertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildAssetsTab(wallet) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<WalletProvider>(context, listen: false).refreshWallet();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wallet.tokens.length,
        itemBuilder: (context, index) {
          final token = wallet.tokens[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TokenCard(
              token: token,
              onTap: () {
                // TODO: Navigate to token detail page
              },
            ).animate(delay: (index * 100).ms)
              .fadeIn(duration: 400.ms)
              .slideX(begin: 0.1, duration: 400.ms),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsTab(wallet) {
    if (wallet.transactions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppTheme.textTertiary,
            ),
            SizedBox(height: 16),
            Text(
              '暂无交易记录',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<WalletProvider>(context, listen: false).refreshWallet();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wallet.transactions.length,
        itemBuilder: (context, index) {
          final transaction = wallet.transactions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransactionCard(
              transaction: transaction,
              onTap: () {
                // TODO: Navigate to transaction detail page
              },
            ).animate(delay: (index * 100).ms)
              .fadeIn(duration: 400.ms)
              .slideX(begin: 0.1, duration: 400.ms),
          );
        },
      ),
    );
  }
}