defmodule FamilyFeud.Repo.Migrations.CreateAnswer do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :body, :string
      add :points, :integer
      add :round_id, references(:rounds, on_delete: :delete_all)

      timestamps()
    end
    create index(:answers, [:round_id])

  end
end
