import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';  // Supabaseを使うためにインポート
import '../utils/error_translator.dart';  // エラーメッセージ翻訳をインポート
import 'signup_page.dart';  // サインアップページをインポート

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();  // メールアドレス入力用
  final _passwordController = TextEditingController();  // パスワード入力用

  // ログイン処理
  Future<void> _login() async {
    try {
      // Supabaseでのサインイン処理
      final AuthResponse response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,  // 入力されたメールアドレス
        password: _passwordController.text,  // 入力されたパスワード
      );

      // ログイン成功時
      if (response.session != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ログイン成功！'), backgroundColor: Colors.green),
          );
          // ホーム画面へ遷移
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        throw Exception('ログインに失敗しました。');
      }
    } catch (e) {
      // エラーメッセージを翻訳
      String errorMessage = translateError(e.toString());

      // エラーメッセージを表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),  // メールアドレス入力フィールド
              keyboardType: TextInputType.emailAddress,  // メール用キーボードを指定
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),  // パスワード入力フィールド
              obscureText: true,  // パスワードを隠す
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,  // ログインボタン押下でログイン処理
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('ログイン'),
            ),
            const SizedBox(height: 16),
            // 新規登録ボタン
            TextButton(
              onPressed: () {
                // サインアップ画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text('新規登録はこちら'),
            ),
          ],
        ),
      ),
    );
  }
}