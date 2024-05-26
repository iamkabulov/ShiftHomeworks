//
//  FootballPlayersRouter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import UIKit

protocol IFootballPlayersRouter: AnyObject {
	func nextModule(vc: UIViewController, name: String)
}

final class FootballPlayersRouter {
	
}

extension FootballPlayersRouter: IFootballPlayersRouter
{
	func nextModule(vc: UIViewController, itemIndex: Int) {
		do {
			let interactor = FootballPlayerDetailInteractor()
			let router = FootballPlayerDetailRouter()
			let module = try FootballPlayerDatailModuleBuilder()
				.getId(itemIndex)
				.interactor(interactor)
				.router(router)
				.build()

			vc.navigationController?.pushViewController(module, animated: true)
		} catch {
			let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			vc.present(alert, animated: true)
		}
	}
}
