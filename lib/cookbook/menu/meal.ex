defmodule Cookbook.Menu.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meals" do
    field :name, :string
    field :img_url, :string
    field :time, :integer
    field :note, :string
    field :first_seen, :date
    field :last_seen, :date

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, ~w[name img_url time note first_seen last_seen]a)
    |> validate_required(~w[name img_url first_seen last_seen]a)
    |> unique_constraint(:name)
  end
end
