defmodule Cookbook.Repo.Migrations.AddMoreMealColumns do
  use Ecto.Migration

  def change do
    alter table(:meals) do
      add :time, :integer, null: true
      add :note, :string, null: true
    end
  end
end
