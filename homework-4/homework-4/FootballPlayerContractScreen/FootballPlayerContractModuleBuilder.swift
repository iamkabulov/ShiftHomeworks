//
//  FootballPlayerContractBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 20.05.2023.
//

import UIKit

final class FootballPlayerContractModuleBuilder {
	
	private enum ModuleBuilderError: Error {
		case interactorNil
		case routerNil
		case modelNil
	}

	private var model: FootballPlayerDetailEntity?
	private var interactor: FootballPlayerContractInteractor?
	private var router: FootballPlayerContractRouter?
}

extension FootballPlayerContractModuleBuilder {
	func getModel(_ model: FootballPlayerDetailEntity) -> FootballPlayerContractModuleBuilder {
		self.model = model
		return self
	}

	func interactor(_ interactor: FootballPlayerContractInteractor) -> FootballPlayerContractModuleBuilder {
		self.interactor = interactor
		return self
	}

	func router(_ router: FootballPlayerContractRouter) -> FootballPlayerContractModuleBuilder {
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

		guard let model = self.model else {
			throw ModuleBuilderError.modelNil
		}

		let presenter = FootballPlayerContractPresenter(interactor: interactor, router: router, model: model)
		let sheetsVC = FootballPlayerContractViewController(presenter: presenter)

		if let sheet = sheetsVC.sheetPresentationController {
			sheet.detents = [.custom(resolver: { _ in
				return 200
			})]
		}
		return sheetsVC
	}
}
