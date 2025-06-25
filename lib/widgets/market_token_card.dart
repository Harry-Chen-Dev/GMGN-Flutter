import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/market_model.dart';
import '../theme/app_theme.dart';

class MarketTokenCard extends StatelessWidget {
  final MarketToken token;
  final VoidCallback? onTap;

  const MarketTokenCard({
    super.key,
    required this.token,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = token.priceChangePercentage24h >= 0;
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Token Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      token.symbol.substring(0, 2).toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Token Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            token.symbol,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.textTertiary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '#${token.symbol}',
                              style: const TextStyle(
                                color: AppTheme.textTertiary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        token.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '市值 \$${NumberFormat.compact().format(token.marketCap)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '成交量 \$${NumberFormat.compact().format(token.volume24h)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Price and Change
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${NumberFormat('#,##0.00').format(token.price)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPositive 
                          ? AppTheme.successGreen.withOpacity(0.1)
                          : AppTheme.errorRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositive ? Icons.trending_up : Icons.trending_down,
                            color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${isPositive ? '+' : ''}${token.priceChangePercentage24h.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '24h: \$${NumberFormat('#,##0.00').format(token.priceChange24h)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
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
}