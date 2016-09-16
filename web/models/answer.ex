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
    |> validate_6_answer_limit
  end

  def create(params, round) do
    params = Map.put(params, "round_id", round.id)

    changeset(%Answer{}, params) |> Repo.insert
  end

  def validate_6_answer_limit(changeset) do
    new?  = get_field(changeset, :id) == nil
    round = Repo.get(Round, get_field(changeset, :round_id)) |> Repo.preload(:answers)

    if new? && (round.answers |> Enum.count >= 6) do
      add_error(changeset, :base, "Can't create more than 6 answers per round.")
    else
      changeset
    end
  end
end
