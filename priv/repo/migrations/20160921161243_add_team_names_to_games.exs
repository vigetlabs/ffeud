defmodule FamilyFeud.Repo.Migrations.AddTeamNamesToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :team_1_name, :string, default: "Team 1"
      add :team_2_name, :string, default: "Team 2"
    end
  end
end
