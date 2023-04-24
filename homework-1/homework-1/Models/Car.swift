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
	case nothing = 0
	case van = 1
	case sedan = 2
	case pickup = 3
	case crossover = 4
	static var count: Int { return Body.crossover.rawValue + 1 }

	var description: String? {
			switch self {
			case .nothing: return nil
			case .van: return "Вэн"
			case .sedan: return "Седан"
			case .pickup: return "Пикап"
			case .crossover: return "Кроссовер"
			}
		}
}

var cars = [Car]()

func addNewCar(_ car: Car) {
	cars.append(car)
}
