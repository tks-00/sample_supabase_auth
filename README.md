# Supabase認証サンプル

### プロジェクト構成

```
lib/
├── pages/
│   ├── home_page.dart        # ホーム画面のUI（ログアウト機能を含む）
│   ├── login_page.dart       # ログイン画面とログイン処理の実装
│   └── signup_page.dart      # サインアップ（新規登録）画面と処理の実装
├── utils/
│   └── error_translator.dart # エラーメッセージを翻訳する関数
└── main.dart                 # アプリケーションのエントリーポイント。ルーティングやテーマ設定を含む
```

### セットアップ手順

1. このリポジトリをフォークします
GitHub上で「フォーク」ボタンをクリックして、あなたのGitHubアカウントにこのリポジトリをコピーします。

2. フォークしたリポジトリをローカル環境にクローンします
```
git clone git@github.com:tks-00/sample_supabase_auth.git
```

3. 依存関係をインストールします
```
flutter pub get
```

4. Supabaseプロジェクトの設定
- Supabaseにアクセスし、新しいプロジェクトを作成します。
- プロジェクト作成後、APIセクションからSupabase URLとanonKeyを取得します。
- main.dartファイル内のurlとanonKeyをあなたのプロジェクトの情報に置き換えます。

5. プロジェクトを実行します
```
flutter run
```
