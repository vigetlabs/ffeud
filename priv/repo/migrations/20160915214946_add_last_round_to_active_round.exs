defmodule FamilyFeud.Repo.Migrations.AddLastRoundToActiveRound do
  use Ecto.Migration

  def change do
    alter table(:active_rounds) do
      add :last_round, :boolean, default: false
    end
  end
end
