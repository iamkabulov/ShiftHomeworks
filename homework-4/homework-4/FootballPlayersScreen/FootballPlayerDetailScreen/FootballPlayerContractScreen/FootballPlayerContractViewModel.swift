//
//  FootballPlayerContractViewModel.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 08.05.2023.
//

import Foundation

struct FootballPlayerContractViewModel {
	let cost: Int
	let contract: Int

	func getCost() -> String {
		"Market Value: \(cost) million $"
	}

	func getContract() -> String {
		"Contract: \(contract) million € per season"
	}
}

extension FootballPlayerContractViewModel {
	init(with model: FootballPlayerDetailViewModel) {
		self.cost = model.cost
		self.contract = model.contract
	}
}
