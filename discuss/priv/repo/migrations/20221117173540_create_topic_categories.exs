defmodule Discuss.Repo.Migrations.CreateTopicCategories do
  use Ecto.Migration

  def change do
    create table(:topic_categories) do
      add(:topic_id, references(:topics, on_delete: :delete_all))
      add(:category_id, references(:categories, on_delete: :delete_all))
      timestamps()
    end

    create(index(:topic_categories, [:topic_id]))
    create(index(:topic_categories, [:category_id]))
    create(unique_index(:topic_categories, [:topic_id, :category_id]))
  end
end
