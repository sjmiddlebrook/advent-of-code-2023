defmodule Day01 do
  def read_input do
    {:ok, contents} = File.read("./day-01/input.txt")
    contents
  end

  def calculate do
    read_input()
    |> String.split("\n")
    |> Enum.map(&extract_number(&1))
    |> Enum.sum()
  end

  def extract_number(line) do
    line
    |> replace_numbers()
    |> String.replace(~r/[^\d]/, "")
    |> first_last()
  end

  def replace_numbers(text) do
    text
    |> String.replace("zero", "zero0zero")
    |> String.replace("one", "one1one")
    |> String.replace("two", "two2two")
    |> String.replace("three", "three3three")
    |> String.replace("four", "four4four")
    |> String.replace("five", "five5five")
    |> String.replace("six", "six6six")
    |> String.replace("seven", "seven7seven")
    |> String.replace("eight", "eight8eight")
    |> String.replace("nine", "nine9nine")
  end

  def first_last("") do
    0
  end

  def first_last(number) do
    first = number |> String.slice(0, 1)
    last = number |> String.slice(-1, 1)
    String.to_integer(first <> last)
  end
end

IO.inspect(Day01.calculate())
