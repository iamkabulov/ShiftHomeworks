//
//  FootballPlayersViewModel.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

struct FootballPlayersEntity: Decodable {
	let name: String
	let bio: String
	let image: String
	let clubTeam: String
	let nationalTeam: String
	let number: Int
	let goals: Int
	let cost: Int
	let contract: Int
}

struct FootballPlayerCellModel {
	let name: String
	let image: String
}

extension FootballPlayerCellModel {
	init(with model: FootballPlayersEntity) {
		self.name = model.name
		self.image = model.image
	}
}
