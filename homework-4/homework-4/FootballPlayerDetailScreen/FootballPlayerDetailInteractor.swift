//
//  FootballPlayerDetailInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import Foundation

protocol IFootballPlayerDetailInteractor {
	func load(index: Int) -> FootballPlayerDetailEntity
}

final class FootballPlayerDetailInteractor {
	weak var presenter: FootballPlayerDetailPresenter?

}

extension FootballPlayerDetailInteractor: IFootballPlayerDetailInteractor {
	func load(index: Int) -> FootballPlayerDetailEntity {
		return FootballPlayerDetailEntity(with: FootballPlayersEntity.getDefaultModel()[index])
	}
}
