defmodule FamilyFeud.Round do
  use FamilyFeud.Web, :model

  schema "rounds" do
    field :question, :string
    field :position, :integer
    belongs_to :game, Game
    has_many :answers, Answer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :position, :game_id])
    |> validate_required([:question, :position, :game_id])
  end

  def create(params, game) do
    params = Map.put(params, "game_id", game.id)

    changeset(%Round{}, params) |> Repo.insert
  end

  def ordered_answers(round) do
    query = from a in Answer,
      where:    a.round_id == ^round.id,
      order_by: [desc: a.points, asc: a.body]

    Repo.all query
  end
end
