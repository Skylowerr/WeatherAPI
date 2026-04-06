//
//  AppConfig.swift
//  WeatherAppAPI
//
//  Created by Emirhan Gökçe on 6.04.2026.
//

import Foundation

enum AppConfig {
    
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found")
        }
        return key
    }
}
