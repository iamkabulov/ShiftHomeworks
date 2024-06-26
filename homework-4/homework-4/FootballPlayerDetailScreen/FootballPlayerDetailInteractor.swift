//
//  FootballPlayerDetailInteractor.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import Foundation
import UIKit

protocol IFootballPlayerDetailInteractor {
	func load(index: Int?) -> FootballPlayerDetailEntity
}

final class FootballPlayerDetailInteractor {
	
	weak var presenter: FootballPlayerDetailPresenter?
	var footballPlayerDetail: FootballPlayerDetailEntity?
}

extension FootballPlayerDetailInteractor: IFootballPlayerDetailInteractor {
	func load(index: Int?) -> FootballPlayerDetailEntity {
		guard let index = index else { return FootballPlayerDetailEntity(with: FootballPlayersEntity.getDefaultModel()[0])}
		return FootballPlayerDetailEntity(with: FootballPlayersEntity.getDefaultModel()[index])
	}
}
