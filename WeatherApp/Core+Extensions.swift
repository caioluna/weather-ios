//
//  Core+Extensions.swift
//  WeatherApp
//
//  Created by Caio Luna on 06/07/25.
//

import Foundation

extension Int {
	func toWeekdayName() -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EE"
		
		return dateFormatter.string(from: date)
	}
	
	func toHourFormat() -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm"
		
		return dateFormatter.string(from: date)
	}
	
	func isDayTime() -> Bool {
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		let hour = Calendar.current.component(.hour, from: date)
		
		let dayStartHour: Int = 6
		let dayEndHour: Int = 18
		
		return hour >= dayStartHour && hour < dayEndHour
	}
}

extension Double {
	func toCelcius() -> String {
		"\(Int(self))ºC"
	}
}
