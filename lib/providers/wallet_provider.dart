import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../services/wallet_service.dart';

class WalletProvider with ChangeNotifier {
  Wallet? _wallet;
  bool _isLoading = false;
  String? _errorMessage;

  Wallet? get wallet => _wallet;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WalletService _walletService = WalletService();

  Future<void> loadWallet() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _wallet = await _walletService.getWallet();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshWallet() async {
    try {
      _wallet = await _walletService.getWallet();
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