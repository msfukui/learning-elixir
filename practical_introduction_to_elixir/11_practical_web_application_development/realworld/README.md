# Realworld

A Sample Web Application using Phoenix Framework

ref. https://github.com/introduction-to-practical-elixir/realworld

## Commands

```bash
mix phx.new realworld
cd realworld
docker compose up -d --build
mix ecto.setup
mix phx.gen.live Blogs Article articles title:string body:text
mix ecto.migrate
mix phx.server
mix phx.gen.context Blogs Comment comments body:text article_id:references:articles
mix ecto.migrate```
mix phx.gen.context Blogs Tag tags tag:string:unique
mix phx.gen.schema Blogs.ArticleTag articles_tags article_id:references:articles tag_id:references:tags
mix ecto.migrate
mix phx.gen.auth Accounts User users
mix deps.get
mix ecto.migrate
mix ecto.gen.migration add_author_id_to_articles
mix ecto.migrate
mix ecto.gen.migration add_author_id_to_comments
mix ecto.migrate
```

## References

- Elixir実践入門 ――基本文法、Web開発、機械学習、IoT の公式ページ
  https://gihyo.jp/book/2024/978-4-297-14014-4/support

- 第11章 実践的な Web アプリケーションの開発 に登場したサンプルアプリケーションのリポジトリ
  https://github.com/introduction-to-practical-elixir/realworld/

- サンプルアプリケーションの元になった説明ページ
  https://realworld-docs.netfly.app
