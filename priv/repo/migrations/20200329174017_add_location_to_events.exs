defmodule ElixirVictoria.Repo.Migrations.AddLocationToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :location, :string
    end
  end
end
