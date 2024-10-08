defmodule RealworldWeb.ArticleLiveTest do
  use RealworldWeb.ConnCase

  import Phoenix.LiveViewTest
  import Realworld.BlogsFixtures
  import Realworld.AccountsFixtures

  @create_attrs %{title: "some title", body: "some body"}
  @update_attrs %{title: "some updated title", body: "some updated body"}
  @invalid_attrs %{title: nil, body: nil}

  defp create_article(_) do
    article = article_fixture()
    %{article: article}
  end

  defp create_article_with_tag(_) do
    {:ok, %{article: article}} =
      Realworld.Blogs.insert_article_with_tags(%{
        title: "some title",
        body: "some body",
        author_id: user_fixture().id,
        tags_string: "test"
      })
    %{article_with_tag: article}
  end

  describe "Index" do
    setup [:create_article, :create_article_with_tag]

    test "lists all articles", %{conn: conn, article: article} do
      {:ok, _index_live, html} = live(conn, ~p"/articles")

      assert html =~ "Listing Articles"
      assert html =~ article.title
    end

    test "searches articles by tag", %{conn: conn, article: article, article_with_tag: article_with_tag} do
      {:ok, index_live, _html} = live(conn, ~p"/articles")

      index_live |> element("a", "test") |> render_click()
      assert_redirect(index_live, ~p"/articles?tag=test")

      {:ok, _index_live, html} = live(conn, ~p"/articles?tag=test")

      refute html =~ "/articles/#{article.id}"
      assert html =~ "/articles/#{article_with_tag.id}"
    end

    test "saves new article", %{conn: conn} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/articles")

      assert index_live |> element("a", "New Article") |> render_click() =~
      "New Article"

      assert_patch(index_live, ~p"/articles/new")

      assert index_live
      |> form("#article-form", article: @invalid_attrs)
      |> render_change() =~ "can&#39;t be blank"

      assert index_live
      |> form("#article-form", article: @create_attrs)
      |> render_submit()

      assert_patch(index_live, ~p"/articles")

      html = render(index_live)
      assert html =~ "Article created successfully"
      assert html =~ "some title"
    end
  end

  describe "Show" do
    setup [:create_article]

    test "displays article", %{conn: conn, article: article} do
      {:ok, _show_live, html} = live(conn, ~p"/articles/#{article}")

      assert html =~ "Show Article"
      assert html =~ article.title
    end

    test "updates article within modal", %{conn: conn, article: article} do
      {:ok, show_live, _html} =
        conn
        |> log_in_user(Realworld.Repo.preload(article, :author).author)
        |> live(~p"/articles/#{article}")

      assert show_live |> element("a", "Edit") |> render_click() =~
      "Edit Article"

      assert_patch(show_live, ~p"/articles/#{article}/show/edit")

      assert show_live
      |> form("#article-form", article: @invalid_attrs)
      |> render_change() =~ "can&#39;t be blank"

      assert show_live
      |> form("#article-form", article: @update_attrs)
      |> render_submit()

      assert_patch(show_live, ~p"/articles/#{article}")

      html = render(show_live)
      assert html =~ "Article updated successfully"
      assert html =~ "some updated title"
    end

    test "creates comment", %{conn: conn, article: article} do
      author = user_fixture()
      {:ok, show_live, _html} =
        conn
        |> log_in_user(author)
        |> live(~p"/articles/#{article}")

      assert show_live
      |> form("#comment-form", comment: %{body: ""})
              |> render_change() =~ "can&#39;t be blank"

      assert show_live
      |> form("#comment-form", comment: %{body: "some comment"})
              |> render_submit()

      html = render(show_live)

      assert html =~ author.email
      assert html =~ "some comment"
    end

    test "deletes article", %{conn: conn, article: article} do
      {:ok, show_live, _html} =
        conn
        |> log_in_user(Realworld.Repo.preload(article, :author).author)
        |> live(~p"/articles/#{article}")

      assert show_live |> element("a", "Delete") |> render_click()
      assert_redirect(show_live, ~p"/articles")

      {:ok, _index_live, html} = live(conn, ~p"/articles")

      refute html =~ "/articles/#{article.id}"
    end
  end
end
