defmodule FamilyFeud.Game do
  use FamilyFeud.Web, :model

  schema "games" do
    field :name, :string
    field :public_code, :string
    field :team_1_name, :string
    field :team_2_name, :string
    belongs_to :user, User
    has_many :rounds, Round
    has_many :active_games, ActiveGame

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id, :public_code, :team_1_name, :team_2_name])
    |> validate_required([:name, :user_id, :public_code, :team_1_name, :team_2_name])
  end

  def create(params, user) do
    params    = Map.put(params, "user_id", user.id)
    params    = Map.put(params, "public_code", random_code)
    changeset = Game.changeset(%Game{}, params)

    Repo.insert(changeset)
  end

  def get_active_game(game) do
    active_game = Repo.get_by(ActiveGame, game_id: game.id, active: true)

    if !active_game do
      ActiveGame.create(game)
    end

    Repo.get_by(ActiveGame, game_id: game.id, active: true)
  end

  def first_round(game) do
    query = from r in Round,
      where:    r.game_id == ^game.id,
      order_by: r.position,
      limit:    1

    Repo.all(query) |> List.first
  end

  def ordered_rounds(game) do
    query = from r in Round,
      where:    r.game_id == ^game.id,
      order_by: r.position

    Repo.all query
  end

  def random_code do
    Enum.map(1..4, fn(_x) -> random_letter end) |> Enum.join
  end

  def random_letter do
    :random.seed(:os.timestamp)
    Enum.shuffle(alphabet) |> List.first
  end

  def alphabet do
    ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
  end
end
