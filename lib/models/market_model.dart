class MarketToken {
  final String id;
  final String symbol;
  final String name;
  final String iconUrl;
  final double price;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double marketCap;
  final double volume24h;
  final double high24h;
  final double low24h;
  final List<double> sparklineData;

  MarketToken({
    required this.id,
    required this.symbol,
    required this.name,
    required this.iconUrl,
    required this.price,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCap,
    required this.volume24h,
    required this.high24h,
    required this.low24h,
    required this.sparklineData,
  });

  factory MarketToken.fromJson(Map<String, dynamic> json) {
    return MarketToken(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      price: json['price'].toDouble(),
      priceChange24h: json['priceChange24h'].toDouble(),
      priceChangePercentage24h: json['priceChangePercentage24h'].toDouble(),
      marketCap: json['marketCap'].toDouble(),
      volume24h: json['volume24h'].toDouble(),
      high24h: json['high24h'].toDouble(),
      low24h: json['low24h'].toDouble(),
      sparklineData: List<double>.from(json['sparklineData']),
    );
  }
}

class MarketOverview {
  final double totalMarketCap;
  final double totalVolume24h;
  final double btcDominance;
  final double ethDominance;
  final int totalCoins;
  final int totalExchanges;

  MarketOverview({
    required this.totalMarketCap,
    required this.totalVolume24h,
    required this.btcDominance,
    required this.ethDominance,
    required this.totalCoins,
    required this.totalExchanges,
  });

  factory MarketOverview.fromJson(Map<String, dynamic> json) {
    return MarketOverview(
      totalMarketCap: json['totalMarketCap'].toDouble(),
      totalVolume24h: json['totalVolume24h'].toDouble(),
      btcDominance: json['btcDominance'].toDouble(),
      ethDominance: json['ethDominance'].toDouble(),
      totalCoins: json['totalCoins'],
      totalExchanges: json['totalExchanges'],
    );
  }
}
