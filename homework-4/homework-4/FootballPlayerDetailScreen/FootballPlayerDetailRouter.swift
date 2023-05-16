//
//  FootballPlayerDetailRouter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import UIKit

protocol IFootballPlayerDetailRouter: AnyObject
{
	func nextModule(vc: UIViewController, model: FootballPlayerDetailEntity)
}

final class FootballPlayerDetailRouter {

}

extension FootballPlayerDetailRouter: IFootballPlayerDetailRouter
{
	func nextModule(vc: UIViewController, model: FootballPlayerDetailEntity) {
		let interactor = FootballPlayerContractInteractor()
		let router = FootballPlayerContractRouter()
		let presenter = FootballPlayerContractPresenter(interactor: interactor, router: router, model: model)
		let sheetsVC = FootballPlayerContractViewController(presenter: presenter)
		if let sheet = sheetsVC.sheetPresentationController {
			sheet.detents = [.custom(resolver: { _ in
				return 200
			})]
		}
		vc.present(sheetsVC, animated: true)
	}
}
