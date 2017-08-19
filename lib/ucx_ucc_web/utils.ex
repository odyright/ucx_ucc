defmodule UcxUccWeb.Utils do

  def format_error_list(%Ecto.Changeset{valid?: false, errors: errors}) do
    for {field, error} <- errors do
      "#{field} - #{elem(error, 0)}"
    end
  end

  def format_error_list(_), do: [""]

  def format_errors(changeset, join_by \\ "<br>") do
    changeset
    |> format_error_list
    |> Enum.join(join_by)
  end

end