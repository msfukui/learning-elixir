defmodule RealworldWeb.ArticleLive.Index do
  use RealworldWeb, :live_view

  alias Realworld.Blogs
  alias Realworld.Blogs.Article

  @impl true
  def mount(%{"tag" => tag}, _session, socket) do
    {:ok,
      socket
      |> stream(:articles, Blogs.list_articles_by_tag(tag))
      |> assign(:tags, Blogs.list_tags())}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> stream(:articles, Blogs.list_articles())
      |> assign(:tags, Blogs.list_tags())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Blogs.get_article!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_info({RealworldWeb.ArticleLive.FormComponent, {:saved, article}}, socket) do
    {:noreply, stream_insert(socket, :articles, article)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Blogs.get_article!(id)
    {:ok, _} = Blogs.delete_article(article)

    {:noreply, stream_delete(socket, :articles, article)}
  end
end
