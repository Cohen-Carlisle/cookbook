defmodule Cookbook.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meals" do
    field :img_url, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:name, :img_url])
    |> validate_required([:name, :img_url])
    |> unique_constraint(:name)
  end
end
