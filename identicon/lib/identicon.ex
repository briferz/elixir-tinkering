defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Generates a MD5 hash from the input string.
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> Enum.map(&discretize_row/1)
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    case length(row) |> rem(2) do
      0 -> row ++ Enum.reverse(row)
      1 -> row ++ Enum.reverse(Enum.drop(row, -1))
    end
  end

  def discretize_row(row) do
    row
    |> Enum.map(fn x -> rem(x, 2) === 0 end)
    |> Enum.with_index()
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      for {row, y} <- grid, {pixel, x} <- row do
        {x * 50, y * 50, pixel}
      end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {x, y, pixel} ->
      if pixel do
        :egd.filledRectangle(image, {x, y}, {x + 50, y + 50}, fill)
      end
    end)

    :egd.render(image)
  end

  def save_image(image, input) do
    File.write("identicon_#{input}.png", image)
  end
end
