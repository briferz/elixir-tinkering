defmodule Discuss.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add(:title, :string, null: false, size: 50)
      add(:likes, :integer, default: 0, null: false)

      timestamps()
    end
  end
end
