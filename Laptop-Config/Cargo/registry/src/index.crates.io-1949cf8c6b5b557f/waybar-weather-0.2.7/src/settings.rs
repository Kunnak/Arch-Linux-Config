use clap::ValueEnum;
use cli_settings_derive::cli_settings;
use serde::Deserialize;

#[derive(ValueEnum, Clone, Debug, Deserialize, Default)]
pub enum Units {
    #[default]
    Metric = 0,
    Imperial = 1,
    Standard = 2,
}

impl Units {
    pub fn as_str(&self) -> &str {
        match self {
            Units::Metric => "metric",
            Units::Imperial => "imperial",
            Units::Standard => "standard",
        }
    }

    pub fn symbol(&self) -> String {
        match self {
            Units::Metric => "",
            Units::Imperial => "",
            Units::Standard => "K",
        }
        .to_string()
    }

    pub fn wind_unit(&self) -> String {
        match self {
            Units::Metric => "km/h",
            Units::Imperial => "mph",
            Units::Standard => "km/h",
        }
        .to_string()
    }

    pub fn wind_multiply(&self) -> f64 {
        match self {
            Units::Metric => 3.6,   // m/s to km/h
            Units::Imperial => 1.0, // m/s to mph
            Units::Standard => 3.6, // m/s to km/h
        }
    }
}

#[derive(Debug, Clone)]
#[cli_settings]
#[cli_settings_file = "#[serde_with::serde_as]#[derive(serde::Deserialize)]"]
#[cli_settings_clap = "#[derive(clap::Parser)]#[command(name = \"waybar-weather\", version)]"]
pub struct Settings {
    #[cli_settings_file]
    #[cli_settings_clap = "#[arg(short, long, help = \"API key for OpenWeatherMap\")]"]
    pub apikey: String,

    #[cli_settings_file]
    #[cli_settings_clap = "#[arg(short, long, help = \"City ID or Name, ex. London, GB\")]"]
    pub cityid: String,

    #[cli_settings_file]
    #[cli_settings_clap = "#[arg(short, long, help = \"Units of measurement\")]"]
    pub units: Units,

    #[cli_settings_file]
    #[cli_settings_clap = "#[arg(long, help = \"High temperature threshold for 'hot' class\")]"]
    #[cli_settings_default = "30"]
    pub high_temp: i8,

    #[cli_settings_file]
    #[cli_settings_clap = "#[arg(long, help = \"Low temperature threshold for 'cold' class\")]"]
    #[cli_settings_default = "-10"]
    pub low_temp: i8,

    #[cli_settings_file]
    pub text: Option<String>,

    #[cli_settings_file]
    pub tooltip: Option<String>,
}

#[test]
fn test_units() {
    let metric = Units::Metric;
    let imperial = Units::Imperial;
    let standard = Units::Standard;

    assert_eq!(metric.as_str(), "metric");
    assert_eq!(imperial.as_str(), "imperial");
    assert_eq!(standard.as_str(), "standard");

    assert_eq!(metric.symbol(), "");
    assert_eq!(imperial.symbol(), "");
    assert_eq!(standard.symbol(), "K");

    assert_eq!(metric.wind_unit(), "km/h");
    assert_eq!(imperial.wind_unit(), "mph");
    assert_eq!(standard.wind_unit(), "km/h");

    assert_eq!(metric.wind_multiply(), 3.6);
    assert_eq!(imperial.wind_multiply(), 1.0);
    assert_eq!(standard.wind_multiply(), 3.6);
}
