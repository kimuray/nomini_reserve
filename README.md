# README

nomini.の予約システムを構築します

## Version

| 項目 | バージョン |
|:-----|:-----|
| Ruby | 2.4.1 |
| Ruby on Rails | 5.1.3 |
| MySQL | 5.5以上 |

## Provisioning

* 管理者ユーザーの作成

```
$ rails c
> Admin.create(email: 'admin@example.com', password: 'password')

# 管理画面バス
http://localhost:3000/admin/sign_in
```

