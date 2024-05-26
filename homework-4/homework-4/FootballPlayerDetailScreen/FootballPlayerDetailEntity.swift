//
//  FootballPlayerDetailViewModel.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

struct FootballPlayerDetailEntity: Decodable {

	let name: String
	let image: String
	let bio: String
	let clubTeam: String
	let nationalTeam: String
	let number: Int
	let goals: Int
	let cost: Int
	let contract: Int

	func getClub() -> String {
		"Current club: \(clubTeam)"
	}

	func getNumber() -> String {
		"T-shirt number: \(number)"
	}

	func getNationalTeam() -> String {
		"National team: \(nationalTeam)"
	}

	func getStats() -> String {
		"Goals in current season: \(goals)"
	}
}

extension FootballPlayerDetailEntity {
	init(with model: FootballPlayersEntity) {
		name = model.name
		image = model.image
		clubTeam = model.clubTeam
		nationalTeam = model.nationalTeam
		number = model.number
		goals = model.goals
		cost = model.cost
		contract = model.contract
		bio = model.bio
	}
}
