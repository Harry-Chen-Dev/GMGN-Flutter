import '../models/market_model.dart';
import 'dart:math';

class MarketService {
  Future<List<MarketToken>> getMarketTokens() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 1000));

    final random = Random();
    
    return [
      MarketToken(
        id: 'bitcoin',
        symbol: 'BTC',
        name: 'Bitcoin',
        iconUrl: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
        price: 38520.60,
        priceChange24h: 902.45,
        priceChangePercentage24h: 2.34,
        marketCap: 755840000000,
        volume24h: 25890000000,
        high24h: 39120.89,
        low24h: 37456.32,
        sparklineData: List.generate(24, (index) => 
          38520.60 + (random.nextDouble() - 0.5) * 2000),
      ),
      MarketToken(
        id: 'ethereum',
        symbol: 'ETH',
        name: 'Ethereum',
        iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
        price: 2001.24,
        priceChange24h: -29.12,
        priceChangePercentage24h: -1.45,
        marketCap: 240560000000,
        volume24h: 15670000000,
        high24h: 2045.67,
        low24h: 1987.43,
        sparklineData: List.generate(24, (index) => 
          2001.24 + (random.nextDouble() - 0.5) * 100),
      ),
      MarketToken(
        id: 'solana',
        symbol: 'SOL',
        name: 'Solana',
        iconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png',
        price: 31.02,
        priceChange24h: 1.76,
        priceChangePercentage24h: 5.67,
        marketCap: 13450000000,
        volume24h: 1890000000,
        high24h: 32.15,
        low24h: 29.87,
        sparklineData: List.generate(24, (index) => 
          31.02 + (random.nextDouble() - 0.5) * 3),
      ),
      MarketToken(
        id: 'cardano',
        symbol: 'ADA',
        name: 'Cardano',
        iconUrl: 'https://cryptologos.cc/logos/cardano-ada-logo.png',
        price: 0.4523,
        priceChange24h: 0.0234,
        priceChangePercentage24h: 5.18,
        marketCap: 15890000000,
        volume24h: 456000000,
        high24h: 0.4678,
        low24h: 0.4321,
        sparklineData: List.generate(24, (index) => 
          0.4523 + (random.nextDouble() - 0.5) * 0.05),
      ),
      MarketToken(
        id: 'polkadot',
        symbol: 'DOT',
        name: 'Polkadot',
        iconUrl: 'https://cryptologos.cc/logos/polkadot-new-dot-logo.png',
        price: 6.78,
        priceChange24h: -0.23,
        priceChangePercentage24h: -3.39,
        marketCap: 8450000000,
        volume24h: 234000000,
        high24h: 7.12,
        low24h: 6.54,
        sparklineData: List.generate(24, (index) => 
          6.78 + (random.nextDouble() - 0.5) * 0.8),
      ),
      MarketToken(
        id: 'chainlink',
        symbol: 'LINK',
        name: 'Chainlink',
        iconUrl: 'https://cryptologos.cc/logos/chainlink-link-logo.png',
        price: 14.56,
        priceChange24h: 0.89,
        priceChangePercentage24h: 6.12,
        marketCap: 8120000000,
        volume24h: 567000000,
        high24h: 15.23,
        low24h: 13.87,
        sparklineData: List.generate(24, (index) => 
          14.56 + (random.nextDouble() - 0.5) * 1.5),
      ),
    ];
  }

  Future<MarketOverview> getMarketOverview() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));

    return MarketOverview(
      totalMarketCap: 1567890000000,
      totalVolume24h: 89450000000,
      btcDominance: 48.25,
      ethDominance: 15.34,
      totalCoins: 2567,
      totalExchanges: 456,
    );
  }
}