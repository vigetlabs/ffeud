defmodule FamilyFeud.Repo.Migrations.AddMultiplierToRound do
  use Ecto.Migration

  def change do
    alter table(:rounds) do
      add :multiplier, :integer, default: 1
    end
  end
end
