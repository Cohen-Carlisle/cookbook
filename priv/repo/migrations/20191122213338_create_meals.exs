defmodule Cookbook.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string, null: false
      add :img_url, :string, null: false

      timestamps()
    end

    create unique_index(:meals, [:name])
  end
end
