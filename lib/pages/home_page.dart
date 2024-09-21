import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';  // ログインページをインポート

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // ログアウト処理のロジック
  Future<void> _logout(BuildContext context) async {
    try {
      // Supabaseでのログアウト処理
      await Supabase.instance.client.auth.signOut();

      // ログアウト成功後にログイン画面へ遷移
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (error) {
      // エラー発生時の処理
      if (!context.mounted) return;  // context が無効か確認
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ログアウトに失敗しました: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ホーム画面へようこそ！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _logout(context),  // ボタン押下でログアウト処理を実行
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
