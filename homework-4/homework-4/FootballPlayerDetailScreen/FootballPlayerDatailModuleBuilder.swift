//
//  FootballPlayerDatailModuleBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 19.05.2023.
//

import UIKit

final class FootballPlayerDatailModuleBuilder {

	private enum ModuleBuilderError: Error {
		case interactorNil
		case routerNil
		case itemIndexNil
	}

	private var itemIndex: Int?
	private var interactor: FootballPlayerDetailInteractor?
	private var router: FootballPlayerDetailRouter?
}


extension FootballPlayerDatailModuleBuilder {
	func getId(_ id: Int) -> FootballPlayerDatailModuleBuilder {
		self.itemIndex = id
		return self
	}

	func interactor(_ interactor: FootballPlayerDetailInteractor) -> FootballPlayerDatailModuleBuilder {
		self.interactor = interactor
		return self
	}

	func router(_ router: FootballPlayerDetailRouter) -> FootballPlayerDatailModuleBuilder {
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

		guard let itemIndex = self.itemIndex else {
			throw ModuleBuilderError.itemIndexNil
		}

		let presenter = FootballPlayerDetailPresenter(interactor: interactor, router: router, itemIndex: itemIndex)
		let vc = FootballPlayerDetailViewController(presenter: presenter)
		return vc
	}
}
