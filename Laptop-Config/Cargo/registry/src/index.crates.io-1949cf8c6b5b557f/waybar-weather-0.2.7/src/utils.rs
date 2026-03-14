use chrono::prelude::DateTime;
use chrono::Utc;
use std::time::{Duration, SystemTime};

pub fn unix_to_timestamp(unix_time: i64) -> String {
    let dt = DateTime::<Utc>::from(SystemTime::UNIX_EPOCH + Duration::from_secs(unix_time as u64));
    let local_dt = dt.with_timezone(&chrono::Local);

    local_dt.format("%I:%M%P").to_string()
}

pub fn compass_from_degrees(degrees: f64) -> String {
    let normalized = degrees % 360.0;
    let index = ((normalized) / 22.5).round() as i32;

    match index {
        0 => "N",
        1 => "NNE",
        2 => "NE",
        3 => "ENE",
        4 => "E",
        5 => "ESE",
        6 => "SE",
        7 => "SSE",
        8 => "S",
        9 => "SSW",
        10 => "SW",
        11 => "WSW",
        12 => "W",
        13 => "WNW",
        14 => "NW",
        15 => "NNW",
        16 => "N",
        _ => "??",
    }
    .to_string()
}

pub fn get_icon(condition: String) -> String {
    match condition.as_str() {
        "01d" => "󰖙",
        "01n" => "󰖔",
        "02d" | "02n" => "󰖕",
        "03d" | "03n" => "󰖐",
        "04d" | "04n" => "󰖐",
        "09d" | "09n" => "󰖗",
        "10d" | "10n" => "󰖖",
        "11d" | "11n" => "󰖓",
        "13d" | "13n" => "󰼶",
        "50d" | "50n" => "",
        _ => "",
    }
    .to_string()
}

pub fn get_temperature_class(temp: f64, high_temp: i8, low_temp: i8) -> String {
    if temp > high_temp as f64 {
        "hot".to_string()
    } else if temp < low_temp as f64 {
        "cold".to_string()
    } else {
        "normal".to_string()
    }
}

pub fn get_condition_class(weather_id: i32) -> String {
    match weather_id {
        200..=299 => "rain".to_string(),
        300..=399 => "rain".to_string(),
        500..=599 => "rain".to_string(),
        600..=699 => "snow".to_string(),
        700..=799 => "smoke".to_string(),
        _ => "none".to_string(),
    }
}

#[test]
fn test_unix_to_timestamp() {
    let unix_time = 1609479273;
    let timestamp = unix_to_timestamp(unix_time);
    debug_assert_eq!(timestamp, "10:34pm");
}

macro_rules! compass_tests {
    ($($name:ident: ($degrees:expr, $expected:expr)),* $(,)?) => {
        $(
            #[test]
            fn $name() {
                let result = compass_from_degrees($degrees);
                assert_eq!(result, $expected, "Failed for {} degrees", $degrees);
            }
        )*
    };
}

compass_tests! {
    dir_n: (0.0, "N"),
    dir_nne: (22.5, "NNE"),
    dir_ne: (45.0, "NE"),
    dir_ene: (67.5, "ENE"),
    dir_e: (90.0, "E"),
    dir_ese: (112.5, "ESE"),
    dir_se: (135.0, "SE"),
    dir_sse: (157.5, "SSE"),
    dir_s: (180.0, "S"),
    dir_ssw: (202.5, "SSW"),
    dir_sw: (225.0, "SW"),
    dir_wsw: (247.5, "WSW"),
    dir_w: (270.0, "W"),
    dir_wnw: (292.5, "WNW"),
    dir_nw: (315.0, "NW"),
    dir_nnw: (337.5, "NNW"),
    dir_n2: (360.0, "N"),
    dir_unk: (-45.0, "??"),
}

#[test]
fn test_get_temperature_class() {
    assert_eq!(get_temperature_class(35.0, 30, -20), "hot");
    assert_eq!(get_temperature_class(-25.0, 30, -20), "cold");
    assert_eq!(get_temperature_class(15.0, 30, -20), "normal");
}

#[test]
fn test_get_condition_class() {
    assert_eq!(get_condition_class(200), "rain");
    assert_eq!(get_condition_class(300), "rain");
    assert_eq!(get_condition_class(500), "rain");
    assert_eq!(get_condition_class(600), "snow");
    assert_eq!(get_condition_class(700), "smoke");
    assert_eq!(get_condition_class(800), "none");
}

#[test]
fn test_get_icon() {
    assert_eq!(get_icon("01d".to_string()), "󰖙");
    assert_eq!(get_icon("01n".to_string()), "󰖔");
    assert_eq!(get_icon("02d".to_string()), "󰖕");
    assert_eq!(get_icon("03d".to_string()), "󰖐");
    assert_eq!(get_icon("04d".to_string()), "󰖐");
    assert_eq!(get_icon("09d".to_string()), "󰖗");
    assert_eq!(get_icon("10d".to_string()), "󰖖");
    assert_eq!(get_icon("11d".to_string()), "󰖓");
    assert_eq!(get_icon("13d".to_string()), "󰼶");
    assert_eq!(get_icon("50d".to_string()), "");
    assert_eq!(get_icon("unknown".to_string()), "");
}
