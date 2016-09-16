defmodule FamilyFeud.Repo.Migrations.MovePotToActiveRound do
  use Ecto.Migration

  def up do
    alter table(:active_rounds) do
      add :pot, :integer, default: 0
    end

    alter table(:active_games) do
      remove :pot
    end
  end

  def down do
    alter table(:active_games) do
      add :pot, :integer, default: 0
    end

    alter table(:active_rounds) do
      remove :pot
    end
  end
end
