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
		do {
			let interactor = FootballPlayerContractInteractor()
			let router = FootballPlayerContractRouter()
			let module = try FootballPlayerContractModuleBuilder()
				.interactor(interactor)
				.router(router)
				.getModel(model)
				.build()
			
			vc.present(module, animated: true)
		} catch {
			let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			vc.present(alert, animated: true)
		}
	}
}
