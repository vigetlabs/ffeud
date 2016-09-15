defmodule FamilyFeud.Repo.Migrations.CreateActiveRound do
  use Ecto.Migration

  def change do
    create table(:active_rounds) do
      add :active, :boolean, default: true, null: false
      add :answer_state, {:array, :boolean}
      add :x_count, :integer
      add :rebuttal, :boolean, default: false, null: false
      add :active_game_id, references(:games, on_delete: :delete_all)
      add :round_id, references(:rounds, on_delete: :delete_all)

      timestamps()
    end
    create index(:active_rounds, [:round_id])
    create index(:active_rounds, [:active_game_id])

  end
end
