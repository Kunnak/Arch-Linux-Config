use crate::settings::Settings;
use crate::utils;
use openweathermap::CurrentWeather;
use serde::Serialize;
use tinytemplate::TinyTemplate;

#[derive(Debug, Serialize)]
pub struct Context {
    pub city: String,    // e.g. "London"
    pub country: String, // e.g. "GB" for Great Britain
    pub icon: String,

    pub main: String,        // e.g. "Clear", "Clouds"
    pub description: String, // e.g. "clear sky", "few clouds"

    pub temp: String,
    pub feels_like: String,
    pub temp_min: String,
    pub temp_max: String,
    pub symbol: String,

    pub humidity: String,
    pub pressure: String,

    pub wind_speed: String,
    pub wind_direction: String,
    pub wind_unit: String,
    pub wind_gust: String,

    pub sunrise: String,
    pub sunset: String,
}

impl Context {
    pub fn from(args: Settings, weather: &CurrentWeather) -> Self {
        let icon = utils::get_icon(weather.weather[0].icon.to_owned());
        let symbol = args.units.symbol();
        let wind_gust = weather.wind.gust.map_or("".to_string(), |gust| {
            format!("{}", (gust * args.units.wind_multiply()).round())
        });
        let wind_speed = format!(
            "{}{}",
            (weather.wind.speed * args.units.wind_multiply()).round(),
            wind_gust
        );

        Context {
            city: weather.name.to_owned(),
            country: weather.sys.country.to_owned(),
            icon,
            main: weather.weather[0].main.to_owned(),
            description: weather.weather[0].description.to_owned(),
            temp: format!("{}", weather.main.temp.round()),
            feels_like: format!("{:.0}", weather.main.feels_like),
            temp_min: format!("{:.1}", weather.main.temp_min),
            temp_max: format!("{:.1}", weather.main.temp_max),
            symbol,
            humidity: format!("{}", weather.main.humidity),
            pressure: format!("{}", weather.main.pressure),
            wind_speed,
            wind_gust,
            wind_direction: utils::compass_from_degrees(weather.wind.deg).to_string(),
            wind_unit: args.units.wind_unit(),
            sunrise: utils::unix_to_timestamp(weather.sys.sunrise),
            sunset: utils::unix_to_timestamp(weather.sys.sunset),
        }
    }
}

#[derive(Debug, Serialize)]
pub struct Output {
    pub text: String,
    pub tooltip: String,
    pub class: Vec<String>,
    pub percentage: i8,
}

impl Output {
    pub fn build(args: Settings, weather: &CurrentWeather) -> Self {
        let text_template = args
            .text
            .to_owned()
            .unwrap_or_else(|| "{icon} {temp}{symbol}".to_string());

        let tooltip_template = args
            .tooltip
            .to_owned()
            .unwrap_or_else(|| "{city}, {country}\n{main} ({description})\nFeels like: {feels_like}{symbol}\nHumidity: {humidity}%\nPressure: {pressure} hPa\nWind: {wind_speed} {wind_unit} ({wind_direction})\n\n {sunrise}  {sunset}".to_string());

        let mut tt = TinyTemplate::new();
        let context = Context::from(args.to_owned(), weather);
        tt.add_template("text", text_template.as_str())
            .expect("Failed to add text template");
        tt.add_template("tooltip", tooltip_template.as_str())
            .expect("Failed to add tooltip template");

        let text = tt
            .render("text", &context)
            .unwrap_or_else(|_| "Error rendering text template".to_string());

        let tooltip = tt
            .render("tooltip", &context)
            .unwrap_or_else(|_| "Error rendering tooltip template".to_string());

        Output {
            text,
            tooltip,
            class: vec![
                "weather".to_string(),
                utils::get_temperature_class(
                    weather.main.temp,
                    args.high_temp.to_owned(),
                    args.low_temp.to_owned(),
                ),
                utils::get_condition_class(weather.weather[0].id as i32),
            ],
            percentage: 100,
        }
    }

    pub fn send(&self) {
        println!("{}", self.to_json());
    }

    pub fn to_json(&self) -> String {
        serde_json::to_string(self).unwrap()
    }
}

#[test]
fn test_build_output() {
    use crate::settings::Settings;
    use crate::settings::Units;

    let args = Settings {
        apikey: "test_api_key".to_string(),
        cityid: "test_city_id".to_string(),
        units: Units::Metric,
        high_temp: 30_i8,
        low_temp: -10_i8,
        text: None,
        tooltip: None,
    };
    let weather = CurrentWeather {
        clouds: openweathermap::Clouds { all: 0.0_f64 },
        dt: 1609459200_i64,
        timezone: 0_i64,
        cod: 200_u64,
        id: 123456_u64,
        coord: openweathermap::Coord {
            lon: -0.1276_f64,
            lat: 51.5074_f64,
        },
        visibility: 10000_u64,
        base: "stations".to_string(),
        snow: None,
        rain: None,
        name: "Test City".to_string(),
        sys: openweathermap::Sys {
            id: Some(123456_u64),
            message: Some(0.0_f64),
            type_: Some(1_u64),
            country: "TC".to_string(),
            sunrise: 1609459200_i64,
            sunset: 1609495200_i64,
        },
        weather: vec![openweathermap::Weather {
            id: 800,
            main: "Clear".to_string(),
            description: "clear sky".to_string(),
            icon: "01d".to_string(),
        }],
        main: openweathermap::Main {
            sea_level: None,
            grnd_level: None,
            temp: 20.0_f64,
            feels_like: 18.0_f64,
            temp_min: 15.0_f64,
            temp_max: 25.0_f64,
            pressure: 1016_f64,
            humidity: 60_f64,
        },
        wind: openweathermap::Wind {
            gust: Some(12.0_f64),
            speed: 5.0_f64,
            deg: 99.0_f64,
        },
    };

    let output = Output::build(args, &weather);
    assert_eq!(output.text, "󰖙 20");
    debug_assert_eq!(output.tooltip, "Test City, TC\nClear (clear sky)\nFeels like: 18\nHumidity: 60%\nPressure: 1016 hPa\nWind: 1843 km/h (E)\n\n 05:00pm  03:00am");
}

#[test]
fn test_output_send() {
    let output = Output {
        text: "Test".to_string(),
        tooltip: "This is a test".to_string(),
        class: vec!["test-class".to_string()],
        percentage: 100,
    };
    output.send();
}

#[test]
fn test_output_to_json() {
    let output = Output {
        text: "Test".to_string(),
        tooltip: "This is a test".to_string(),
        class: vec!["test-class".to_string()],
        percentage: 100,
    };

    let json_output = output.to_json();
    assert!(json_output.contains("\"text\":\"Test\""));
    assert!(json_output.contains("\"tooltip\":\"This is a test\""));
    assert!(json_output.contains("\"class\":[\"test-class\"]"));
    assert!(json_output.contains("\"percentage\":100"));
}
