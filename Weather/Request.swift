//
//  Request.swift
//  Weather
//
//  Created by Александр Меренков on 9/28/21.
//

import Foundation

public class Request {
    @Published var locationData = [Location]()
    @Published var currentData = [Current]()
    
    private let requestAdress = "http://api.weatherapi.com/v1/current.json?key="
    private let weatherKey = "42769d3ede75441186e131003212709"
    private let localCity = "Moscow"
    private var requestFull: String
    
    init() {
        self.requestFull = requestAdress + weatherKey + "&q=" + localCity + "&aqi=no"
        load()
    }
    
    func load() {
        if let url = URL(string: requestFull) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(Answer.self, from: data)
                self.locationData.append(dataFromJson.location)
                self.currentData.append(dataFromJson.current)
            } catch {
                print("There was an error finding in the data!")
            }
        }
    }
}

