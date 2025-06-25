class CopyTradingWallet {
  final String id;
  final String nickname;
  final String address;
  final String avatarUrl;
  final double totalPnl;
  final double totalPnlPercentage;
  final double winRate;
  final int followersCount;
  final double totalVolume;
  final List<String> topTokens;
  final List<TradeHistory> recentTrades;
  final bool isFollowing;

  CopyTradingWallet({
    required this.id,
    required this.nickname,
    required this.address,
    required this.avatarUrl,
    required this.totalPnl,
    required this.totalPnlPercentage,
    required this.winRate,
    required this.followersCount,
    required this.totalVolume,
    required this.topTokens,
    required this.recentTrades,
    required this.isFollowing,
  });

  factory CopyTradingWallet.fromJson(Map<String, dynamic> json) {
    return CopyTradingWallet(
      id: json['id'],
      nickname: json['nickname'],
      address: json['address'],
      avatarUrl: json['avatarUrl'],
      totalPnl: json['totalPnl'].toDouble(),
      totalPnlPercentage: json['totalPnlPercentage'].toDouble(),
      winRate: json['winRate'].toDouble(),
      followersCount: json['followersCount'],
      totalVolume: json['totalVolume'].toDouble(),
      topTokens: List<String>.from(json['topTokens']),
      recentTrades: (json['recentTrades'] as List)
          .map((e) => TradeHistory.fromJson(e))
          .toList(),
      isFollowing: json['isFollowing'] ?? false,
    );
  }
}

class TradeHistory {
  final String id;
  final String type; // 'buy' or 'sell'
  final String tokenSymbol;
  final String tokenIconUrl;
  final double amount;
  final double price;
  final double pnl;
  final double pnlPercentage;
  final DateTime timestamp;

  TradeHistory({
    required this.id,
    required this.type,
    required this.tokenSymbol,
    required this.tokenIconUrl,
    required this.amount,
    required this.price,
    required this.pnl,
    required this.pnlPercentage,
    required this.timestamp,
  });

  factory TradeHistory.fromJson(Map<String, dynamic> json) {
    return TradeHistory(
      id: json['id'],
      type: json['type'],
      tokenSymbol: json['tokenSymbol'],
      tokenIconUrl: json['tokenIconUrl'],
      amount: json['amount'].toDouble(),
      price: json['price'].toDouble(),
      pnl: json['pnl'].toDouble(),
      pnlPercentage: json['pnlPercentage'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
