import 'package:flutter/material.dart';
import '../models/market_model.dart';
import '../services/market_service.dart';

class MarketProvider with ChangeNotifier {
  List<MarketToken> _tokens = [];
  MarketOverview? _overview;
  bool _isLoading = false;
  String? _errorMessage;

  List<MarketToken> get tokens => _tokens;
  MarketOverview? get overview => _overview;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final MarketService _marketService = MarketService();

  Future<void> loadMarketData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _marketService.getMarketTokens(),
        _marketService.getMarketOverview(),
      ]);
      
      _tokens = results[0] as List<MarketToken>;
      _overview = results[1] as MarketOverview;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMarketData() async {
    try {
      final results = await Future.wait([
        _marketService.getMarketTokens(),
        _marketService.getMarketOverview(),
      ]);
      
      _tokens = results[0] as List<MarketToken>;
      _overview = results[1] as MarketOverview;
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