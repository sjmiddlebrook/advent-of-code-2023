defmodule Day02 do
  def read_input do
    {:ok, contents} = File.read("./day-02/input.txt")
    contents
  end

  def calculate do
    read_input()
    |> String.split("\n", trim: true)
    |> Enum.map(&create_game_map/1)
    |> Enum.filter(&is_game_valid/1)
    |> Enum.map(fn {game_num, _} -> game_num end)
    |> Enum.reduce(fn x, acc -> acc + x end)
    |> IO.inspect()
  end

  def calculate_part_2 do
    read_input()
    |> String.split("\n", trim: true)
    |> Enum.map(&create_game_map/1)
    |> Enum.map(&calculate_min_set/1)
    |> Enum.map(&calculate_power_of_set/1)
    |> Enum.reduce(fn x, acc -> acc + x end)
    |> IO.inspect()
  end

  def get_game_num(line) do
    line
    |> String.split(":")
    |> List.first()
    |> String.split(" ")
    |> List.last()
    |> String.to_integer()
  end

  def split_game_sets(line) do
    line
    |> String.split(": ")
    |> List.last()
    |> String.split("; ")
    |> Enum.map(&create_color_map(&1))
  end

  def create_color_map(text) do
    text
    |> String.split(", ")
    |> Enum.map(&color_to_count(&1))
    |> Enum.reduce(&Map.merge/2)
  end

  def color_to_count(text) do
    [count, color] = String.split(text, " ")
    %{color => String.to_integer(count)}
  end

  def create_game_map(line) do
    game_num = get_game_num(line)
    sets = split_game_sets(line)
    {game_num, sets}
  end

  def is_game_valid({_, sets}) do
    Enum.all?(sets, &is_set_valid/1)
  end

  def is_set_valid(set) do
    Map.get(set, "red", 0) <= 12 &&
      Map.get(set, "green", 0) <= 13 &&
      Map.get(set, "blue", 0) <= 14
  end

  def calculate_min_set({_, sets}) do
    sets
    |> Enum.reduce(&Map.merge(&1, &2, fn _, v1, v2 -> max(v1, v2) end))
  end

  def calculate_power_of_set(set) do
    Map.get(set, "red", 0) * Map.get(set, "green", 0) * Map.get(set, "blue", 0)
  end
end

Day02.calculate_part_2()
