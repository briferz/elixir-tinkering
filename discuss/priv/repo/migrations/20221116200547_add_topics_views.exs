defmodule Discuss.Repo.Migrations.AddTopicsViews do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add(:views, :integer, null: false, default: 0)
    end
  end
end
