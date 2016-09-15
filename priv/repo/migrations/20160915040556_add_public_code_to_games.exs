defmodule FamilyFeud.Repo.Migrations.AddPublicCodeToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :public_code, :string
    end
  end
end
