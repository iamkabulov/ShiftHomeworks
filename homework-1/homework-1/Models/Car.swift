//
//  Car.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.04.2023.
//

import Foundation

struct Car {
	let manufaturer: String
	let model: String
	let body: Body
	let yearOfIssue: Int?
	let carNumber: String?
}

enum Body: Int {
	case van = 0
	case sedan = 1
	case pickup = 2
	case crossover = 3
	static var count: Int { return Body.crossover.rawValue + 1 }

	var description: String {
			switch self {
			case .van: return "Van"
			case .sedan   : return "Sedan"
			case .pickup : return "Pickup"
			case .crossover: return "Crossover"
			}
		}
}

var cars = [Car]()

func appendik(_ car: Car) {
	cars.append(car)
}
