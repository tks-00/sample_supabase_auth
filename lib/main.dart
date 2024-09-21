import 'package:flutter/material.dart';
import 'package:sample_login_signup/pages/home_page.dart';
import 'package:sample_login_signup/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabaseを使うためにインポート

void main() async {
  // ここで Supabase を初期化
  WidgetsFlutterBinding.ensureInitialized();  // Flutterの非同期処理を許可
  await Supabase.initialize(
    url: 'https://hogehoge.supabase.co',  // SupabaseプロジェクトURL
    anonKey: 'hogehoge',  // SupabaseのAPIキー
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Auth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),  // カラースキームを設定
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,  // AppBarの背景色をグローバルに設定
        ),
      ),
      // 初期ルートはログイン画面
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),  // ログイン画面
        '/home': (context) => const HomePage(),  // ホーム画面
      },
    );
  }
}