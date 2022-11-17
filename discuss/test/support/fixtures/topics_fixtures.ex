defmodule Discuss.TopicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Topics` context.
  """

  @doc """
  Generate a topic.
  """
  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(%{
        likes: 42,
        title: "some title"
      })
      |> Discuss.Topics.create_topic()

    topic
  end

  @doc """
  Generate a unique category title.
  """
  def unique_category_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: unique_category_title()
      })
      |> Discuss.Topics.create_category()

    category
  end
end
