use openweathermap::blocking::weather;
use std::process::exit;
mod output;
mod settings;
mod utils;

#[cfg(not(tarpaulin_include))]
fn main() {
    let user_home = std::env::var("HOME").unwrap();

    let args = settings::Settings::build(
        vec![
            std::path::PathBuf::from(format!("{}/.config/waybar-weather/config.yaml", user_home)),
            std::path::PathBuf::from(format!("{}/.waybar-weather.yaml", user_home)),
        ],
        std::env::args_os(),
    )
    .unwrap();

    if args.apikey.is_empty() && args.cityid.is_empty() {
        println!(
            "Error: API key and City ID/Name must be set in the config file or as CLI arguments."
        );
        exit(1);
    }

    match &weather(&args.cityid, args.units.as_str(), "en", &args.apikey) {
        Ok(weather) => output::Output::build(args, weather).send(),
        Err(e) => println!("Could not fetch weather: {}", e),
    }
}
