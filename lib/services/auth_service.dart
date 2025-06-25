import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Mock用户数据
  static final Map<String, Map<String, dynamic>> _mockUsers = {
    'admin@gmgn.ai': {
      'id': '1',
      'email': 'admin@gmgn.ai',
      'username': 'GMGNAdmin',
      'password': '123456',
      'avatarUrl': 'https://api.dicebear.com/7.x/avataaars/svg?seed=GMGNAdmin',
      'createdAt':
          DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'isVerified': true,
    },
    'trader@gmgn.ai': {
      'id': '2',
      'email': 'trader@gmgn.ai',
      'username': 'CryptoTrader',
      'password': '123456',
      'avatarUrl':
          'https://api.dicebear.com/7.x/avataaars/svg?seed=CryptoTrader',
      'createdAt':
          DateTime.now().subtract(const Duration(days: 15)).toIso8601String(),
      'isVerified': true,
    },
  };

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final userData = prefs.getString(_userKey);

    if (token != null && userData != null) {
      try {
        final userJson = jsonDecode(userData);
        return User.fromJson(userJson);
      } catch (e) {
        // 清除无效数据
        await logout();
        return null;
      }
    }
    return null;
  }

  Future<User> login(String email, String password) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));

    final mockUser = _mockUsers[email.toLowerCase()];
    if (mockUser == null || mockUser['password'] != password) {
      throw Exception('邮箱或密码错误');
    }

    final user = User.fromJson(mockUser);

    // 保存用户数据和token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, 'mock_token_${user.id}');
    await prefs.setString(_userKey, jsonEncode(user.toJson()));

    return user;
  }

  Future<User> register(String email, String password, String username) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 1000));

    // 检查邮箱是否已存在
    if (_mockUsers.containsKey(email.toLowerCase())) {
      throw Exception('该邮箱已被注册');
    }

    // 创建新用户
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      username: username,
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$username',
      createdAt: DateTime.now(),
      isVerified: false,
    );

    // 添加到mock数据
    _mockUsers[email.toLowerCase()] = {
      ...user.toJson(),
      'password': password,
    };

    // 保存用户数据和token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, 'mock_token_${user.id}');
    await prefs.setString(_userKey, jsonEncode(user.toJson()));

    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
