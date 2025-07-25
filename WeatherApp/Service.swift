//
//  Service.swift
//  WeatherApp
//
//  Created by Caio Luna on 05/07/25.
//

import Foundation

struct City {
	let lat: String
	let lon: String
	let name: String
}

class Service {
	
	private var apiKey: String {
		guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
			fatalError("API_KEY não encontrada nas Environment Variables. Configure no Scheme do Xcode.")
		}
		return key
	}
	
	private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
	private let session = URLSession.shared
	
	func fetchData(city: City, _ completion: @escaping (ForecastResponse?) -> Void) {
		
		let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)&units=metric"
		
		guard let url = URL(string: urlString) else {
			return
		}
		
		let task = session.dataTask(with: url) { data, response, error in
			
			guard let data else {
				completion(nil)
				return
			}
			
			do {
				let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
				completion(forecastResponse)
				
			} catch {
				print(String(data: data, encoding: .utf8) ?? "")
				completion(nil)
			}
		}
		
		task.resume()
	}
}

// MARK:  - ForecastResponse
struct ForecastResponse: Codable {
	let current: Forecast
	let hourly: [Forecast]
	let daily: [DailyForecast]
}

// MARK:  - Forecast
struct Forecast: Codable {
	let dt: Int
	let temp: Double
	let humidity: Int
	let windSpeed: Double
	let weather: [Weather]
	
	enum CodingKeys: String, CodingKey {
		case dt, temp, humidity
		case windSpeed = "wind_speed"
		case weather
	}
}

// MARK:  - Weather
struct Weather: Codable {
	let id: Int
	let main, description, icon: String
}

// MARK:  - DailyForecast
struct DailyForecast: Codable {
	let dt: Int
	let temp: Temp
	let weather: [Weather]
}

// MARK:  - Temperature
struct Temp: Codable {
	let day, min, max, night: Double
	let eve, morn: Double
}

//// MARK: - ForecastResponse
//struct ForecastResponse: Codable {
//		let weather: [Weather]
//		let main: Main
//		let wind: Wind
//		let dt: Int
//		let name: String
//}
//
//
//// MARK: - Main
//struct Main: Codable {
//		let temp: Double
//		let humidity: Int
//}
//
//
//// MARK: - Weather
//struct Weather: Codable {
//		let id: Int
//		let main, description, icon: String
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//		let speed: Double
//		let deg: Int
//		let gust: Double
//}
