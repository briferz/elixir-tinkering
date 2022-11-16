defmodule Discuss.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field(:likes, :integer)
    field(:title, :string)
    field(:views, :integer)

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
