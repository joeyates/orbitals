defmodule Orbitals do
  @moduledoc """
  Calculate atomic orbital configurations.
  """

  @doc """
  Stream sublevels in progressive order.

  ## Examples

  iex> Orbitals.sublevels() |> Stream.take(5) |> Enum.to_list
  [{1, 0}, {2, 0}, {2, 1}, {3, 0}, {3, 1}]

  """
  def sublevels do
    Stream.unfold(
      {0, 0},
      fn ({n, l}) ->
        cond do
          n > 7      -> nil
          l + 1 >= n -> {{n + 1, 0}, {n + 1, 0}}
          true       -> {{n, l + 1}, {n, l + 1}}
        end
      end
    )
  end

  @doc """
  Get the name for a numeric sublevel.

  ## Examples

  iex> Enum.map(0..7, &Orbitals.sublevel_name(&1))
  [:s, :p, :d, :f, :g, :h, :j, :k]

  """
  def sublevel_name(l) do
    cond do
      l == 0 -> :s
      l == 1 -> :p
      l == 2 -> :d
      l == 3 -> :f
      l == 4 -> :g
      l == 5 -> :h
      l > 5 -> String.to_atom(<<?j + l - 6>>)
    end
  end

  @doc """
  Convert a numeric sublevel to a named sublevel.

  ## Examples

  iex> Orbitals.sublevels() |> Stream.take(5) |> Enum.map(&Orbitals.named(&1))
  [{1, :s}, {2, :s}, {2, :p}, {3, :s}, {3, :p}]

  """

  def named({n, l}) do
    {n, sublevel_name(l)}
  end

  @doc """
  Stream sublevels with a certain n + l value, ordered by n.

  ## Examples

  iex> Orbitals.sublevels_with_total(5) |> Enum.to_list
  [{3, 2}, {4, 1}, {5, 0}]

  """
  def sublevels_with_total(total) do
    Stream.unfold(
      div(total, 2) + 1,
      fn (n) ->
        if n > total do
          nil
        else
          {{n, total - n}, n + 1}
        end
      end
    )
  end

  @doc """
  Stream sublevels ordered by n + l and n.

  ## Examples

  iex> Orbitals.ordered_sublevels |> Stream.take(7) |> Enum.to_list
  [{1, 0}, {2, 0}, {2, 1}, {3, 0}, {3, 1}, {4, 0}, {3, 2}]

  """

  def ordered_sublevels do
    Stream.unfold(
      {1, sublevels_with_total(1)},
      fn ({sublevel_total, sublevel_stream}) ->
        {
          sublevel_stream |> Enum.to_list,
          {sublevel_total + 1, sublevels_with_total(sublevel_total + 1)}
        }
      end
    ) |> Stream.flat_map(fn (x) -> x end)
  end

  defp electrons_in_sublevel(l) do
    2 * (2 * l + 1)
  end

  @doc """
  Stream electron configurations.

  ## Examples

  iex> Orbitals.configurations |> Stream.take(7) |> Enum.to_list
  [{2, {1, 0}}, {2, {2, 0}}, {6, {2, 1}}, {2, {3, 0}}, {6, {3, 1}}, {2, {4, 0}}, {10, {3, 2}}]

  """

  def configurations do
    Stream.map(
      ordered_sublevels(),
      fn ({n, l}) ->
        {electrons_in_sublevel(l), {n, l}}
      end
    )
  end

  def configuration_signature({n, l, count}) do
    "#{n}#{sublevel_name(l)}#{count}"
  end

  @doc """
  Electron configurations for a given atomic number

  ## Examples

  iex> Orbitals.configurations_for(79)
  ...> |> Stream.map(&Orbitals.configuration_signature(&1))
  ...> |> Enum.to_list
  ...> |> Enum.join(", ")
  "1s2, 2s2, 2p6, 3s2, 3p6, 4s2, 3d10, 4p6, 5s2, 4d10, 5p6, 6s2, 4f14, 5d9"

  """

  def configurations_for(atomic_number) do
    Stream.transform(
      configurations(),
      atomic_number,
      fn item, remaining ->
        {electrons, {n, l}} = item
        if remaining <= 0 do
          {:halt, 0}
        else
          in_subshell = if remaining < electrons, do: remaining, else: electrons
          {
            [{n, l, in_subshell}],
            remaining - electrons
          }
        end
      end
    )
  end
end
