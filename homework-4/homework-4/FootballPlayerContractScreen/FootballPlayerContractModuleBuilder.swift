//
//  FootballPlayerContractBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 20.05.2023.
//

import UIKit

protocol IFootballPlayerContractModuleBuilder {
	func getModel(_ model: FootballPlayerDetailEntity)
}

final class FootballPlayerContractModuleBuilder {
	var model: FootballPlayerDetailEntity?

	func build() -> UIViewController {
		let interactor = FootballPlayerContractInteractor()
		let router = FootballPlayerContractRouter()
		guard let model = model else { return UIViewController()}
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

extension FootballPlayerContractModuleBuilder: IFootballPlayerContractModuleBuilder {
	func getModel(_ model: FootballPlayerDetailEntity) {
		self.model = model
	}
}
