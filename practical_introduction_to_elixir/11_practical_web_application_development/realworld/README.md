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

- https://realworld-docs.netfly.app
