defmodule IconeIdentidade do
  @moduledoc """
  Documentation for IconeIdentidade.
  """

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
    |> remover_impar
    |> constroi_pixel
    |> desenhar
    |> salvar(input)
  end

  def salvar(imagem, input) do
    File.write("#{input}.png", imagem)
  end

  def desenhar(%IconeIdentidade.Imagem{cor: cor, pixel_map: pixel_map}) do
    imagem = :egd.create(250, 250)
    preencha = :egd.color(cor)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(imagem, start, stop, preencha)
    end)
    :egd.render(imagem)
  end

  def criar_cor(%IconeIdentidade.Imagem{hex: [r, g, b | _]} = imagem) do
    %IconeIdentidade.Imagem{imagem | cor: {r, g, b}}
  end

  def criar_tabela(%IconeIdentidade.Imagem{hex: hex} = imagem) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&espelhar/1)
      |> List.flatten()
      |> Enum.with_index()

    %IconeIdentidade.Imagem{imagem | grid: grid}
  end

  def remover_impar(%IconeIdentidade.Imagem{grid: grid} = imagem) do
    new_grid =
      Enum.filter(grid, fn {valor, _} ->
        rem(valor, 2) == 0
      end)

    %IconeIdentidade.Imagem{imagem | grid: new_grid}
  end

  def constroi_pixel(%IconeIdentidade.Imagem{grid: grid} = imagem) do
    pixel_map =
      Enum.map(grid, fn {_, indice} ->
        h = rem(indice, 5) * 50
        v = div(indice, 5) * 50
        t_esquerda = {h, v}
        t_direira = {h + 50, v + 50}
        {t_esquerda, t_direira}
      end)

    %IconeIdentidade.Imagem{imagem | pixel_map: pixel_map}
  end

  def espelhar(linha) do
    [pri, sec | _] = linha
    linha ++ [sec, pri]
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %IconeIdentidade.Imagem{hex: hex}
  end
end
