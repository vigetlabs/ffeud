defmodule FamilyFeud.Repo.Migrations.CreateActiveGame do
  use Ecto.Migration

  def change do
    create table(:active_games) do
      add :active, :boolean, default: true, null: false
      add :pot, :integer
      add :team_1_score, :integer
      add :team_2_score, :integer
      add :game_id, references(:games, on_delete: :delete_all)

      timestamps()
    end
    create index(:active_games, [:game_id])

  end
end
