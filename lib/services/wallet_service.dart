import '../models/wallet_model.dart';

class WalletService {
  Future<Wallet> getWallet() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 1200));

    // Mock钱包数据
    return Wallet(
      id: 'wallet_1',
      name: '主钱包',
      address: '0x742d35Cc6634C0532925a3b8D00C2Cc1e5B6c0C2',
      totalBalance: 15.47,
      totalBalanceUsd: 42567.89,
      tokens: [
        Token(
          id: 'bitcoin',
          symbol: 'BTC',
          name: 'Bitcoin',
          iconUrl: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
          balance: 0.75,
          balanceUsd: 28890.45,
          priceUsd: 38520.60,
          priceChange24h: 2.34,
        ),
        Token(
          id: 'ethereum',
          symbol: 'ETH',
          name: 'Ethereum',
          iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          balance: 4.28,
          balanceUsd: 8567.32,
          priceUsd: 2001.24,
          priceChange24h: -1.45,
        ),
        Token(
          id: 'solana',
          symbol: 'SOL',
          name: 'Solana',
          iconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png',
          balance: 125.5,
          balanceUsd: 3890.75,
          priceUsd: 31.02,
          priceChange24h: 5.67,
        ),
        Token(
          id: 'usdc',
          symbol: 'USDC',
          name: 'USD Coin',
          iconUrl: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png',
          balance: 1219.37,
          balanceUsd: 1219.37,
          priceUsd: 1.00,
          priceChange24h: 0.02,
        ),
      ],
      transactions: [
        Transaction(
          id: 'tx_1',
          type: 'buy',
          tokenSymbol: 'SOL',
          tokenIconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png',
          amount: 25.5,
          amountUsd: 790.75,
          status: 'completed',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          hash: '0x1234...5678',
        ),
        Transaction(
          id: 'tx_2',
          type: 'sell',
          tokenSymbol: 'ETH',
          tokenIconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          amount: 1.2,
          amountUsd: 2401.49,
          status: 'completed',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          hash: '0x2345...6789',
        ),
        Transaction(
          id: 'tx_3',
          type: 'buy',
          tokenSymbol: 'BTC',
          tokenIconUrl: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
          amount: 0.15,
          amountUsd: 5778.09,
          status: 'pending',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
          hash: '0x3456...7890',
        ),
        Transaction(
          id: 'tx_4',
          type: 'sell',
          tokenSymbol: 'USDC',
          tokenIconUrl: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png',
          amount: 500.0,
          amountUsd: 500.0,
          status: 'completed',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          hash: '0x4567...8901',
        ),
        Transaction(
          id: 'tx_5',
          type: 'buy',
          tokenSymbol: 'SOL',
          tokenIconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png',
          amount: 100.0,
          amountUsd: 3100.0,
          status: 'completed',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          hash: '0x5678...9012',
        ),
      ],
    );
  }
}
