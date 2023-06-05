defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

  def index(conn, _params) do
    topic = Repo.all(Topic)

    conn
    |> assign(:topic, topic)
    |> render(:index)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    conn
    |> assign(:changeset, changeset)
    |> render(:new)

    #   or we can write the above code as 
    #   render(conn , :new , changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, :edit, changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id) 
    changeset = Topic.changeset(old_topic , topic)

    case Repo.update(changeset) do
      {:ok, _topic} -> 
        conn
        |> put_flash(:info , "Topic Updated")
        |> redirect(to: ~p"/")
      {:error, changeset} ->
        render(conn , :edit , changeset: changeset, topic: old_topic)
    end
  end
end
