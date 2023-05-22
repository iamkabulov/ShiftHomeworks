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
		let footballPlayerContractBuilder = FootballPlayerContractModuleBuilder()
		footballPlayerContractBuilder.getModel(model)
		let sheetsVC = footballPlayerContractBuilder.build()
		vc.present(sheetsVC, animated: true)
	}
}
