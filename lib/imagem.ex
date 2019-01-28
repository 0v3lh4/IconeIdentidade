defmodule IconeIdentidade.Imagem do
  @moduledoc """
    Modulo que representa uma imagem de identidade
  """

  @doc """
    Estrutura da imagem:
    * hex: Array com o hexadecimal que representa a imagem
    * cor: Cor da imagem
    * grid: Mapeamento do array hexadecimal e seus indices
    * pixel_map: Representação da imagem em pixels
  """
  defstruct hex: nil, cor: nil, grid: nil, pixel_map: nil
end
