# What3Words Elixir Demo

A simple module to show how to use the `what3words` Elixir package, interacting with the [restcountries.eu](http://restcountries.eu/) public API (which, by the way, is awesome).

# Installation

The usual stuff:
```
$ git clone https://github.com/lucidstack/w3w-elixir-demo.git
$ cd w3w-elixir-demo
$ mix deps.get
```

Alternatively, you can use this module as a dep in your project (in case you
have any reason for that!). In your `mix.exs` file:
```
  defp deps do
    [{:w3w_elixir_demo, github: "lucidstack/w3w-elixir-demo"}]
  end
```

# Usage

Just a couple of methods of example: `W3wElixirDemo.w3w_for_country/1` and `W3wElixirDemo.w3w_for_all_countries/0`

## `w3w_for_country(iso)`

Retrieves the 3 words locating the centre of the given country. The coordinates are taken from restcountries.eu, and translated through the what3words API.
```
ex(1)> W3wElixirDemo.w3w_for_country("gb")
{"United Kingdom", {"blank", "then", "ridiculed"}}
```

## `w3w_for_all_countries`

Retrieves all countries from restcountries.eu, and finds the 3 words for each one of them, in parallel. This also showcases a little bit the power of `Task.async/1` and `Task.await/1`.

```
iex(1)> W3wElixirDemo.w3w_for_all_countries
%{"Comoros" => {"scrapped", "gears", "eyelashes"},
  "Montserrat" => {"trendier", "tingle", "softer"},
  "Republic of Ireland" => {"flattening", "emulation", "railing"},
  "Bangladesh" => {"sayings", "equine", "effort"},
  "Niue" => {"triathlons", "misfit", "previewed"},
  "Italy" => {"waiters", "plaiting", "unfounded"},
  "Sweden" => {"kneel", "waxers", "stimulant"},
  "Bosnia and Herzegovina" => {"matrix", "modem", ...},
  "Brunei" => {"bunker", ...}, "New Zealand" => {...}, ...}
```
