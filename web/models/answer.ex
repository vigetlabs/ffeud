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
    |> validate_8_answer_limit
  end

  def create(params, round) do
    params = Map.put(params, "round_id", round.id)

    changeset(%Answer{}, params) |> Repo.insert
  end

  def validate_8_answer_limit(changeset) do
    round_id = get_field(changeset, :round_id) || -1
    new?     = get_field(changeset, :id) == nil

    answers = Repo.all(from a in Answer, where: a.round_id == ^round_id)
    if new? && (Enum.count(answers) >= 8) do
      add_error(changeset, :base, "Can't create more than 8 answers per round.")
    else
      changeset
    end
  end
end
