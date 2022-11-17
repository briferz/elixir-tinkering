defmodule Discuss.Topics.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Topics.Topic

  schema "categories" do
    field(:title, :string)

    many_to_many(:topics, Topic, join_through: "topic_categories")

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
