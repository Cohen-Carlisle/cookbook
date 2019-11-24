defmodule Cookbook.Repo.Migrations.AddEvenMoreMealColumns do
  use Ecto.Migration

  def change do
    alter table(:meals) do
      add :first_seen, :date, null: false
      add :last_seen, :date, null: false
    end
  end
end
