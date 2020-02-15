defmodule ElixirVictoria.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :date, :date
      add :start, :string
      add :end, :string
      add :title, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
