defmodule FamilyFeud.Answer do
  use FamilyFeud.Web, :model

  schema "answers" do
    field :body, :string
    field :points, :integer
    belongs_to :round, Round

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :points, :round_id])
    |> validate_required([:body, :points, :round_id])
  end

  def create(params, round) do
    params = Map.put(params, "round_id", round.id)

    changeset(%Answer{}, params) |> Repo.insert
  end

  def update(answer, params) do
    changeset(answer, params) |> Repo.update
  end

end
