# Waybar Weather

![Crates.io Version](https://img.shields.io/crates/v/waybar-weather)
![Crates.io Downloads](https://img.shields.io/crates/d/waybar-weather)
![Gitlab Pipeline Status](https://img.shields.io/gitlab/pipeline-status/baconisaveg%2Fwaybar-weather?branch=main)

Simple widget for displaying the current weather information for a given location using the OpenWeatherMap API.

[[_TOC_]]

Designed for use with [Waybar](https://github.com/Alexays/Waybar), though it may work with other status bars that support JSON output as well.

You will need to obtain a free API key from [OpenWeatherMap](https://home.openweathermap.org/api_keys) using the Current weather and Forecasts API. Once you've created a new API key, it can take up to 30 minutes to become active.

**Important**: You will also need a nerd patched font to display the weather icons. You can find one at [Nerd Fonts](https://www.nerdfonts.com/). Many distributions already include these fonts, so you may not need to install anything extra.

![As a Waybar module](https://gitlab.com/baconisaveg/waybar-weather/-/raw/main/docs/screenshot.png\?raw=true "Screenshot")

```
Usage: waybar-weather [OPTIONS]

Options:
  -a, --apikey <APIKEY>        API key for OpenWeatherMap
  -c, --cityid <CITYID>        City ID or Name, ex. London, GB
  -u, --units <UNITS>          Units of measurement [possible values: metric, imperial, standard]
      --high-temp <HIGH_TEMP>  High temperature threshold for 'hot' class
      --low-temp <LOW_TEMP>    Low temperature threshold for 'cold' class
  -h, --help                   Print help
  -V, --version                Print version
```

The `--cityid` should be a string with your city and country code, e.g. `London, GB` or `New York, US`. You can also use the city ID from OpenWeatherMap, which is a numeric value.

# Configuration Options

As an alternative to passing the command line options, the application will look for the following configuration files:

```
~/.config/waybar-weather/config.yaml
~/.waybar-weather.yaml
```

An example configuration file is provided in the docs folder.

# Installation

## From Source

You can install the `waybar-weather` binary by checking out this repository and then using [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html):

```bash
cargo build --release
cargo install --path .
```

## Arch Linux

```bash
makepkg -si
```

## From crates.io

You can also install `waybar-weather` directly from crates.io using cargo:

```bash
cargo install waybar-weather
```

## Pre-built Binary

You can download the pre-built binary (amd64) from the Gitlab releases page.

# Waybar Configuration

Add the following configuration to your Waybar config file (usually located at `~/.config/waybar/config.jsonc`):

```jsonc
"custom/weather": {
  "exec": "~/.cargo/bin/waybar-weather",
  "return-type": "json",
  "interval": 600,
}
```

And the corresponding CSS to style the widget (usually located at `~/.config/waybar/style.css`). Feel free to adjust the CSS to your liking:

```css
#custom-weather {
  padding: 0.3rem 0.6rem;
  margin: 0.4rem 0.25rem;
  border-radius: 6px;
  background-color: #1a1a1f;
  color: #f9e2af;
}
```

## Conditional Styling

You can also add conditional styling based on the weather condition. For example, to change the background color based on the weather condition and have the module blink during adverse conditions, you can use the following CSS:

```css
#custom-weather {
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink-condition {
  to {
    background-color: #dedede;
  }
}

#custom-weather.hot {
  background-color: #dd5050;
}

#custom-weather.cold {
  background-color: #5050dd;
}

#custom-weather.rain,
#custom-weather.snow,
#custom-weather.smoke {
  color: #dedede;
  animation-name: blink-condition;
  animation-duration: 2s;
}

```

# Credits

- [OpenWeatherMap](https://openweathermap.org/api) for providing the weather data
- [Waybar](https://github.com/Alexays/Waybar) for being a great status bar
- [LawnGnome/waybar-custom-modules](https://github.com/LawnGnome/waybar-custom-modules) for the Output struct
- [fightling/openweathermap](https://github.com/fightling/openweathermap) for the library used to fetch weather data, eliminating my reqwest sphagetti code

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
