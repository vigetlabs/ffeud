defmodule FamilyFeud.Repo.Migrations.CreateRound do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :question, :string
      add :position, :integer
      add :game_id, references(:games, on_delete: :delete_all)

      timestamps()
    end
    create index(:rounds, [:game_id])

  end
end
