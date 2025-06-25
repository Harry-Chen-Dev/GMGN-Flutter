import 'package:flutter/material.dart';
import '../models/copy_trading_model.dart';
import '../services/copy_trading_service.dart';

class CopyTradingProvider with ChangeNotifier {
  List<CopyTradingWallet> _wallets = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CopyTradingWallet> get wallets => _wallets;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final CopyTradingService _copyTradingService = CopyTradingService();

  Future<void> loadCopyTradingWallets() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _wallets = await _copyTradingService.getCopyTradingWallets();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> followWallet(String walletId) async {
    try {
      await _copyTradingService.followWallet(walletId);
      
      // 更新本地状态
      _wallets = _wallets.map((wallet) {
        if (wallet.id == walletId) {
          return CopyTradingWallet(
            id: wallet.id,
            nickname: wallet.nickname,
            address: wallet.address,
            avatarUrl: wallet.avatarUrl,
            totalPnl: wallet.totalPnl,
            totalPnlPercentage: wallet.totalPnlPercentage,
            winRate: wallet.winRate,
            followersCount: wallet.followersCount + 1,
            totalVolume: wallet.totalVolume,
            topTokens: wallet.topTokens,
            recentTrades: wallet.recentTrades,
            isFollowing: true,
          );
        }
        return wallet;
      }).toList();
      
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> unfollowWallet(String walletId) async {
    try {
      await _copyTradingService.unfollowWallet(walletId);
      
      // 更新本地状态
      _wallets = _wallets.map((wallet) {
        if (wallet.id == walletId) {
          return CopyTradingWallet(
            id: wallet.id,
            nickname: wallet.nickname,
            address: wallet.address,
            avatarUrl: wallet.avatarUrl,
            totalPnl: wallet.totalPnl,
            totalPnlPercentage: wallet.totalPnlPercentage,
            winRate: wallet.winRate,
            followersCount: wallet.followersCount - 1,
            totalVolume: wallet.totalVolume,
            topTokens: wallet.topTokens,
            recentTrades: wallet.recentTrades,
            isFollowing: false,
          );
        }
        return wallet;
      }).toList();
      
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}