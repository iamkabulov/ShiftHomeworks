//
//  FootballPlayerContractViewModel.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 08.05.2023.
//

import Foundation

struct FootballPlayerContractEntity {
	let cost: Int
	let contract: Int

	func getCost() -> String {
		"Market Value: \(cost) million $"
	}

	func getContract() -> String {
		"Contract: \(contract) million € per season"
	}
}

extension FootballPlayerContractEntity {
	init(with model: FootballPlayerDetailEntity) {
		self.cost = model.cost
		self.contract = model.contract
	}
}
