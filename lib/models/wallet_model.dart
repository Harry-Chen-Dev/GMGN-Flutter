class Wallet {
  final String id;
  final String name;
  final String address;
  final double totalBalance;
  final double totalBalanceUsd;
  final List<Token> tokens;
  final List<Transaction> transactions;

  Wallet({
    required this.id,
    required this.name,
    required this.address,
    required this.totalBalance,
    required this.totalBalanceUsd,
    required this.tokens,
    required this.transactions,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      totalBalance: json['totalBalance'].toDouble(),
      totalBalanceUsd: json['totalBalanceUsd'].toDouble(),
      tokens: (json['tokens'] as List).map((e) => Token.fromJson(e)).toList(),
      transactions: (json['transactions'] as List)
          .map((e) => Transaction.fromJson(e))
          .toList(),
    );
  }
}

class Token {
  final String id;
  final String symbol;
  final String name;
  final String iconUrl;
  final double balance;
  final double balanceUsd;
  final double priceUsd;
  final double priceChange24h;

  Token({
    required this.id,
    required this.symbol,
    required this.name,
    required this.iconUrl,
    required this.balance,
    required this.balanceUsd,
    required this.priceUsd,
    required this.priceChange24h,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      balance: json['balance'].toDouble(),
      balanceUsd: json['balanceUsd'].toDouble(),
      priceUsd: json['priceUsd'].toDouble(),
      priceChange24h: json['priceChange24h'].toDouble(),
    );
  }
}

class Transaction {
  final String id;
  final String type;
  final String tokenSymbol;
  final String tokenIconUrl;
  final double amount;
  final double amountUsd;
  final String status;
  final DateTime timestamp;
  final String hash;

  Transaction({
    required this.id,
    required this.type,
    required this.tokenSymbol,
    required this.tokenIconUrl,
    required this.amount,
    required this.amountUsd,
    required this.status,
    required this.timestamp,
    required this.hash,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      tokenSymbol: json['tokenSymbol'],
      tokenIconUrl: json['tokenIconUrl'],
      amount: json['amount'].toDouble(),
      amountUsd: json['amountUsd'].toDouble(),
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
      hash: json['hash'],
    );
  }
}
