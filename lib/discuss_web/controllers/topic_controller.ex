defmodule DiscussWeb.TopicController do
  
  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

  def index(conn , _params)do
    topic = Repo.all(Topic) 

   conn
    |> assign(:topic, topic)
    |> render(:index)

  end

  def new(conn,_params) do
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
      {:ok , post} -> 
        conn
        |> put_flash(:info , "Topic created")
        |> redirect(to: ~p"/topics/index")
      {:error, changeset} ->
      render conn , :new ,changeset: changeset
    end
  end
end
