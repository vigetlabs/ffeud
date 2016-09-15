defmodule FamilyFeud.ActiveGame do
  use FamilyFeud.Web, :model

  schema "active_games" do
    field :active, :boolean, default: true
    field :pot, :integer, default: 0
    field :team_1_score, :integer, default: 0
    field :team_2_score, :integer, default: 0
    belongs_to :game, Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:active, :pot, :team_1_score, :team_2_score, :game_id])
    |> validate_required([:active, :pot, :team_1_score, :team_2_score, :game_id])
  end

  def create(game) do
    changeset(%ActiveGame{}, %{game_id: game.id}) |> Repo.insert
  end

  def get_state(active_game, access) do
    active_round = get_active_round(active_game)

    %{
      pot:          active_game.pot,
      team_1_score: active_game.team_1_score,
      team_2_score: active_game.team_2_score,
      round_info:   ActiveRound.get_state(active_round, access)
    }
  end

  def get_active_round(active_game) do
    game         = Repo.get(Game, active_game.game_id)
    active_round = Repo.get_by(ActiveRound, active_game_id: active_game.id, active: true)

    if !active_round do
      ActiveRound.create(active_game, Game.first_round(game))
    end

    Repo.get_by(ActiveRound, active_game_id: active_game.id, active: true)
  end
end
