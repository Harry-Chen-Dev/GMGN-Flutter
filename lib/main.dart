import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/wallet/wallet_page.dart';
import 'pages/copy_trading/copy_trading_page.dart';
import 'pages/market/market_page.dart';
import 'providers/auth_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/market_provider.dart';
import 'providers/copy_trading_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => MarketProvider()),
        ChangeNotifierProvider(create: (_) => CopyTradingProvider()),
      ],
      child: MaterialApp(
        title: 'GMGN.AI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/wallet': (context) => const WalletPage(),
          '/copy-trading': (context) => const CopyTradingPage(),
          '/market': (context) => const MarketPage(),
        },
      ),
    );
  }
}
