//
//  FootballPlayerInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import Foundation

protocol IFootballPlayerInteractor {
	func load() -> [FootballPlayersEntity]
}

final class FootballPlayerInteractor {
	weak var presenter: FootballPlayerPresenter?

}

extension FootballPlayerInteractor: IFootballPlayerInteractor {
	func load() -> [FootballPlayersEntity] {
		FootballPlayersEntity.getDefaultModel()
	}
}
