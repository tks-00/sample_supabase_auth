import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';  // Supabaseを使うためにインポート
import '../utils/error_translator.dart';  // エラーメッセージ翻訳をインポート
import 'login_page.dart';  // ログインページをインポート

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();  // メールアドレス入力用
  final _passwordController = TextEditingController();  // パスワード入力用
  bool _isLoading = false;  // ローディング状態を管理

  // サインアップ処理
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;  // ローディング開始
    });

    try {
      // Supabaseでのサインアップ処理
      final AuthResponse response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text,  // 入力されたメールアドレス
        password: _passwordController.text,  // 入力されたパスワード
      );

      // サインアップ成功時
      if (response.user != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('サインアップ成功！'), backgroundColor: Colors.green),
        );
        // ホーム画面へ遷移
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        throw Exception('サインアップに失敗しました');
      }
    } catch (error) {
      // エラーメッセージを翻訳して表示
      String errorMessage;
      if (error is AuthException) {
        errorMessage = translateError(error.message);
      } else {
        errorMessage = translateError(error.toString());
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;  // ローディング終了
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サインアップ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // 中央に配置
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,  // パスワードを隠す
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()  // ローディング中はインジケーターを表示
                : ElevatedButton(
              onPressed: _signup,  // サインアップボタン押下でサインアップ処理
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('サインアップ'),
            ),
            const SizedBox(height: 16),
            // ログイン画面に戻るボタン
            TextButton(
              onPressed: () {
                // ログインページに遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('既にアカウントをお持ち方はこちら'),
            ),
          ],
        ),
      ),
    );
  }
}