//
//  FootballPlayerDetailInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import Foundation
import UIKit

protocol IFootballPlayerDetailInteractor {
	func load(name: String) -> FootballPlayerDetailEntity?
}

final class FootballPlayerDetailInteractor {

	weak var presenter: FootballPlayerDetailPresenter?
	var footballPlayerDetail: FootballPlayerDetailEntity?
}

extension FootballPlayerDetailInteractor: IFootballPlayerDetailInteractor {

	func load(name: String) -> FootballPlayerDetailEntity? {
		guard let fileURL = Bundle.main.url(forResource: "FootballPlayersData", withExtension: "json") else {
			fatalError("Не удалось найти файл")
		}
		do {
			let jsonData = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let model = try decoder.decode([FootballPlayersEntity].self, from: jsonData)
			model.forEach { player in
				if name == player.name {
					footballPlayerDetail = FootballPlayerDetailEntity(with: player)
				}
			}
		} catch {
			fatalError("Не удалось прочитать файл")
		}
		return footballPlayerDetail
	}
}
