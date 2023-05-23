//
//  FootballPlayerInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import Foundation

protocol IFootballPlayerInteractor {
	func load() -> [FootballPlayersEntity]?
}

final class FootballPlayerInteractor {
	weak var presenter: FootballPlayerPresenter?

}

extension FootballPlayerInteractor: IFootballPlayerInteractor {

	func load() -> [FootballPlayersEntity]? {
		var players = [FootballPlayersEntity]()
		guard let fileURL = Bundle.main.url(forResource: "FootballPlayersData", withExtension: "json") else {
			fatalError("Не удалось найти файл")
		}

		do {
			let jsonData = try Data(contentsOf: fileURL)
			let decoder = JSONDecoder()
			let data = try decoder.decode([FootballPlayersEntity].self, from: jsonData)
			players = data

		} catch {
			fatalError("Не удалось прочитать файл")
		}
		return players
	}
}

