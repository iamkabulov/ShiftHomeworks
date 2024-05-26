//
//  FootballPlayersBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 19.05.2023.
//

import UIKit
protocol IFootballPlayerModuleBuilder: AnyObject {

}
final class FootballPlayersModuleBuilder {

	private enum ModuleBuilderError: Error {
		case interactorNil
		case routerNil
	}

	private var interactor: FootballPlayerInteractor?
	private var router: FootballPlayersRouter?
}

extension FootballPlayersModuleBuilder {

	func interactor(_ interactor: FootballPlayerInteractor) -> FootballPlayersModuleBuilder {
		self.interactor = interactor
		return self
	}

	func router(_ router: FootballPlayersRouter) -> FootballPlayersModuleBuilder {
		self.router = router
		return self
	}

	func build() throws -> UIViewController {
		guard let interactor = self.interactor else {
			throw ModuleBuilderError.interactorNil
		}

		guard let router = self.router else {
			throw ModuleBuilderError.routerNil
		}

		let presenter = FootballPlayerPresenter(interactor: interactor, router: router)
		let vc = FootballPlayersViewController(presenter: presenter)
		return vc
	}
}
