//
//  Model.swift
//  Weather
//
//  Created by Александр Меренков on 9/28/21.
//

struct Answer: Decodable {
    let location: Location
    let current: Current
}

struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

struct Current: Decodable {
    let temp_c: Double
    let condition: Condition
    let wind_mph: Double
    let wind_dir: String
    let pressure_mb: Double
    let feelslike_c: Double
}

struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}
