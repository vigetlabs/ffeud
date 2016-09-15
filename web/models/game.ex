defmodule FamilyFeud.Game do
  use FamilyFeud.Web, :model

  schema "games" do
    field :name, :string
    field :public_code, :string
    belongs_to :user, User
    has_many :rounds, Round

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id, :public_code])
    |> validate_required([:name, :user_id, :public_code])
  end

  def create(params, user) do
    params    = Map.put(params, "user_id", user.id)
    params    = Map.put(params, "public_code", random_code)
    changeset = Game.changeset(%Game{}, params)

    Repo.insert(changeset)
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
