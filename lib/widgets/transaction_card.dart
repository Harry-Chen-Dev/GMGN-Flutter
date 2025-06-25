import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/wallet_model.dart';
import '../theme/app_theme.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBuy = transaction.type == 'buy';
    final isPending = transaction.status == 'pending';

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
                // Transaction Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isBuy
                        ? AppTheme.successGreen.withOpacity(0.1)
                        : AppTheme.errorRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isBuy ? Icons.trending_up : Icons.trending_down,
                    color: isBuy ? AppTheme.successGreen : AppTheme.errorRed,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Transaction Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isBuy ? '买入' : '卖出',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            transaction.tokenSymbol,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const Spacer(),
                          if (isPending)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.warningOrange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '处理中',
                                style: TextStyle(
                                  color: AppTheme.warningOrange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MM/dd HH:mm').format(transaction.timestamp),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),

                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isBuy ? '+' : '-'}${transaction.amount.toStringAsFixed(4)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: isBuy
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      '\$${NumberFormat('#,##0.00').format(transaction.amountUsd)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
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
