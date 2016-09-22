defmodule FamilyFeud.Repo.Migrations.CreateActiveFastMoneyRound do
  use Ecto.Migration

  def change do
    create table(:active_fast_money_rounds) do
      add :answers, {:array, :string}
      add :points, {:array, :integer}
      add :answer_state, {:array, :boolean}
      add :point_state, {:array, :boolean}
      add :active, :boolean, default: true, null: false
      add :last_round, :boolean, default: false, null: false
      add :pot, :integer, default: 0
      add :active_game_id, references(:games, on_delete: :delete_all)
      add :fast_money_round_id, references(:fast_money_rounds, on_delete: :nothing)

      timestamps()
    end
    create index(:active_fast_money_rounds, [:fast_money_round_id])

  end
end
