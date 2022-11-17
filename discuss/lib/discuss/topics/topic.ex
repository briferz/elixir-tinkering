defmodule Discuss.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Topics.Category

  schema "topics" do
    field(:title, :string)
    field(:likes, :integer)
    field(:views, :integer)

    many_to_many(:categories, Category, join_through: "topic_categories", on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :likes])
    |> validate_required([:title, :likes])
    |> validate_number(:likes, greater_than_or_equal_to: 0)
  end
end
