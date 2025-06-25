import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../providers/market_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/market_token_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  String _sortBy = 'market_cap'; // market_cap, price, change
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('市场'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                if (_sortBy == value) {
                  _isAscending = !_isAscending;
                } else {
                  _sortBy = value;
                  _isAscending = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'market_cap',
                child: Text('按市值排序'),
              ),
              const PopupMenuItem(
                value: 'price',
                child: Text('按价格排序'),
              ),
              const PopupMenuItem(
                value: 'change',
                child: Text('按涨跌幅排序'),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Provider.of<MarketProvider>(context, listen: false).refreshMarketData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Consumer<MarketProvider>(
        builder: (context, marketProvider, child) {
          if (marketProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
              ),
            );
          }

          if (marketProvider.errorMessage != null) {
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
                    marketProvider.errorMessage!,
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => marketProvider.loadMarketData(),
                    child: const Text('重试'),
                  ),
                ],
              ),
            );
          }

          final overview = marketProvider.overview;
          var tokens = marketProvider.tokens;

          // Sort tokens
          if (tokens.isNotEmpty) {
            tokens = List.from(tokens);
            tokens.sort((a, b) {
              switch (_sortBy) {
                case 'price':
                  return _isAscending 
                    ? a.price.compareTo(b.price)
                    : b.price.compareTo(a.price);
                case 'change':
                  return _isAscending 
                    ? a.priceChangePercentage24h.compareTo(b.priceChangePercentage24h)
                    : b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h);
                case 'market_cap':
                default:
                  return _isAscending 
                    ? a.marketCap.compareTo(b.marketCap)
                    : b.marketCap.compareTo(a.marketCap);
              }
            });
          }

          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.refreshMarketData();
            },
            child: CustomScrollView(
              slivers: [
                // Market Overview Header
                if (overview != null)
                  SliverToBoxAdapter(
                    child: _buildMarketOverview(overview),
                  ),
                
                // Market Tokens List
                if (tokens.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final token = tokens[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MarketTokenCard(
                              token: token,
                              onTap: () {
                                // TODO: Navigate to token detail page
                              },
                            ).animate(delay: (index * 100).ms)
                              .fadeIn(duration: 400.ms)
                              .slideX(begin: 0.1, duration: 400.ms),
                          );
                        },
                        childCount: tokens.length,
                      ),
                    ),
                  )
                else
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.trending_up_outlined,
                              size: 64,
                              color: AppTheme.textTertiary,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '暂无市场数据',
                              style: TextStyle(color: AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMarketOverview(overview) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '市场概览',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Top row stats
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat(
                  '总市值',
                  '\$${NumberFormat.compact().format(overview.totalMarketCap)}',
                  Icons.account_balance,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOverviewStat(
                  '24h 交易量',
                  '\$${NumberFormat.compact().format(overview.totalVolume24h)}',
                  Icons.bar_chart,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Bottom row stats
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat(
                  'BTC 占比',
                  '${overview.btcDominance.toStringAsFixed(1)}%',
                  Icons.currency_bitcoin,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOverviewStat(
                  'ETH 占比',
                  '${overview.ethDominance.toStringAsFixed(1)}%',
                  Icons.diamond,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildOverviewStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
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
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}