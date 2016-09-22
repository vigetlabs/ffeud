defmodule FamilyFeud.Repo.Migrations.CreateFastMoneyRound do
  use Ecto.Migration

  def change do
    create table(:fast_money_rounds) do
      add :game_id, references(:games, on_delete: :nothing)
      add :notes, :text
      add :position, :integer
      add :multiplier, :integer, default: 1

      timestamps()
    end
    create index(:fast_money_rounds, [:game_id])

  end
end
