import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/copy_trading_model.dart';
import '../theme/app_theme.dart';

class TraderCard extends StatelessWidget {
  final CopyTradingWallet wallet;
  final VoidCallback onFollow;
  final VoidCallback? onTap;

  const TraderCard({
    super.key,
    required this.wallet,
    required this.onFollow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = wallet.totalPnlPercentage >= 0;
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          wallet.nickname.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Name and Address
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wallet.nickname,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${wallet.address.substring(0, 6)}...${wallet.address.substring(wallet.address.length - 4)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Follow Button
                    SizedBox(
                      width: 80,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: onFollow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: wallet.isFollowing 
                            ? AppTheme.cardDark 
                            : AppTheme.primaryGreen,
                          foregroundColor: wallet.isFollowing 
                            ? AppTheme.textSecondary 
                            : Colors.black,
                          side: wallet.isFollowing 
                            ? const BorderSide(color: AppTheme.borderDark) 
                            : null,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Text(wallet.isFollowing ? '已关注' : '关注'),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        '总收益',
                        '${isPositive ? '+' : ''}\$${NumberFormat('#,##0.00').format(wallet.totalPnl)}',
                        isPositive,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        '收益率',
                        '${isPositive ? '+' : ''}${wallet.totalPnlPercentage.toStringAsFixed(2)}%',
                        isPositive,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        '胜率',
                        '${wallet.winRate.toStringAsFixed(1)}%',
                        wallet.winRate > 50,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Additional Info
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 16,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${wallet.followersCount} 关注者',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.bar_chart_outlined,
                      size: 16,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '总交易量 \$${NumberFormat.compact().format(wallet.totalVolume)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Top Tokens
                if (wallet.topTokens.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '主要交易币种',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: wallet.topTokens.take(4).map((token) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              token,
                              style: const TextStyle(
                                color: AppTheme.primaryGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool isPositive) {
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
          style: TextStyle(
            color: label == '胜率' 
              ? AppTheme.textPrimary 
              : (isPositive ? AppTheme.successGreen : AppTheme.errorRed),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}