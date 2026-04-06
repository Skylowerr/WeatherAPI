//
//  WeatherApp.swift
//  WeatherAppAPI
//
//  Created by Emirhan Gökçe on 14.10.2025.
//

import Foundation

// MARK: - WeatherApp
struct WeatherResponse: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let tempC : Double
    let tempF: Double
    let condition: Condition
    let feelslikeC: Double
    let feelslikeF: Double


    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"

    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
}

// MARK: - Location
struct Location: Codable {
    let name, country: String
    enum CodingKeys: String, CodingKey {
        case name, country
    }
}
