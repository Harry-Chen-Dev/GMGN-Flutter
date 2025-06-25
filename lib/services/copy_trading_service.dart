import '../models/copy_trading_model.dart';
import 'dart:math';

class CopyTradingService {
  Future<List<CopyTradingWallet>> getCopyTradingWallets() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 1500));

    return [
      CopyTradingWallet(
        id: 'trader_1',
        nickname: '🚀 DeGen King',
        address: '0x1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=DeGenKing',
        totalPnl: 125670.45,
        totalPnlPercentage: 156.78,
        winRate: 78.5,
        followersCount: 1456,
        totalVolume: 2567890.12,
        topTokens: ['BTC', 'ETH', 'SOL', 'ADA'],
        recentTrades: _generateMockTrades(),
        isFollowing: false,
      ),
      CopyTradingWallet(
        id: 'trader_2',
        nickname: '💎 Diamond Hands',
        address: '0x2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u',
        avatarUrl:
            'https://api.dicebear.com/7.x/avataaars/svg?seed=DiamondHands',
        totalPnl: 89456.23,
        totalPnlPercentage: 89.45,
        winRate: 82.3,
        followersCount: 2134,
        totalVolume: 1890456.78,
        topTokens: ['ETH', 'LINK', 'DOT', 'UNI'],
        recentTrades: _generateMockTrades(),
        isFollowing: true,
      ),
      CopyTradingWallet(
        id: 'trader_3',
        nickname: '⚡ Speed Trader',
        address: '0x3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v',
        avatarUrl:
            'https://api.dicebear.com/7.x/avataaars/svg?seed=SpeedTrader',
        totalPnl: 67890.12,
        totalPnlPercentage: 67.89,
        winRate: 75.2,
        followersCount: 987,
        totalVolume: 1234567.89,
        topTokens: ['SOL', 'AVAX', 'MATIC', 'FTM'],
        recentTrades: _generateMockTrades(),
        isFollowing: false,
      ),
      CopyTradingWallet(
        id: 'trader_4',
        nickname: '🎯 Sniper Pro',
        address: '0x4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=SniperPro',
        totalPnl: 234567.89,
        totalPnlPercentage: 234.56,
        winRate: 91.7,
        followersCount: 3421,
        totalVolume: 4567890.12,
        topTokens: ['BTC', 'ETH', 'BNB', 'XRP'],
        recentTrades: _generateMockTrades(),
        isFollowing: false,
      ),
      CopyTradingWallet(
        id: 'trader_5',
        nickname: '🔥 Hot Wallet',
        address: '0x5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=HotWallet',
        totalPnl: 45678.91,
        totalPnlPercentage: 45.67,
        winRate: 69.8,
        followersCount: 678,
        totalVolume: 890123.45,
        topTokens: ['DOGE', 'SHIB', 'PEPE', 'FLOKI'],
        recentTrades: _generateMockTrades(),
        isFollowing: true,
      ),
    ];
  }

  List<TradeHistory> _generateMockTrades() {
    final random = Random();
    final tokens = ['BTC', 'ETH', 'SOL', 'ADA', 'DOT', 'LINK'];
    final types = ['buy', 'sell'];

    return List.generate(5, (index) {
      final isBuy = types[random.nextInt(2)] == 'buy';
      final token = tokens[random.nextInt(tokens.length)];
      final amount = random.nextDouble() * 100;
      final price = random.nextDouble() * 1000 + 100;
      final pnl = (random.nextDouble() - 0.3) * 1000;

      return TradeHistory(
        id: 'trade_$index',
        type: isBuy ? 'buy' : 'sell',
        tokenSymbol: token,
        tokenIconUrl:
            'https://cryptologos.cc/logos/${token.toLowerCase()}-logo.png',
        amount: amount,
        price: price,
        pnl: pnl,
        pnlPercentage: (pnl / (amount * price)) * 100,
        timestamp: DateTime.now().subtract(Duration(hours: index * 2)),
      );
    });
  }

  Future<void> followWallet(String walletId) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 500));

    // 模拟操作成功
    print('Following wallet: $walletId');
  }

  Future<void> unfollowWallet(String walletId) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 500));

    // 模拟操作成功
    print('Unfollowing wallet: $walletId');
  }
}
