defmodule FamilyFeud.Repo.Migrations.AddTeamXCountsToActiveRounds do
  use Ecto.Migration

  def change do
    alter table(:active_rounds) do
      add :team_1_x_count, :integer, default: 0
      add :team_2_x_count, :integer, default: 0
    end
  end
end
