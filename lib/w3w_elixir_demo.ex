defmodule W3wElixirDemo do
  @restcountries_base "https://restcountries.eu/rest/v1/"

  def w3w_for_all_countries do
    :all
    |> get_countries
    |> decode_body
    |> async_translate
  end

  def w3w_for_country(iso) do
    iso
    |> get_countries
    |> decode_body
    |> translate
  end

  defp get_countries(:all), do: HTTPoison.get!(@restcountries_base <> "all")
  defp get_countries(iso),  do: HTTPoison.get!(@restcountries_base <> "alpha/" <> iso)

  defp decode_body(%{body: body}), do:
    Poison.decode!(body)

  defp get_latlng(%{"latlng" => latlng}), do:
    latlng |> List.to_tuple

  defp async_translate(countries) do
    countries
    |> Enum.map(&Task.async(fn -> translate(&1) end))
    |> Enum.map(&Task.await/1)
    |> Map.new
  end

  defp translate(country) do
    words = country |> get_latlng |> get_words
    {country["name"], words}
  end

  defp get_words({_lat, _lng} = coords), do: What3Words.position_to_words!(coords)
  defp get_words({}),                    do: nil
end
