defmodule Discuss.Repo.Migrations.AddTopicCategoriesDefaults do
  use Ecto.Migration

  def change do
    alter table(:topic_categories) do
      modify(:inserted_at, :timestamp, default: fragment("now()"))
      modify(:updated_at, :timestamp, default: fragment("now()"))
    end
  end
end
