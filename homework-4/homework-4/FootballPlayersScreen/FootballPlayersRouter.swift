//
//  FootballPlayersRouter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import UIKit

protocol IFootballPlayersRouter: AnyObject
{
	func nextModule(vc: UIViewController, itemIndex: Int)
}

final class FootballPlayersRouter {

}

extension FootballPlayersRouter: IFootballPlayersRouter
{
	func nextModule(vc: UIViewController, itemIndex: Int) {
		let module = FootballPlayerDatailModuleBuilder()
		module.getId(itemIndex)
		let detailVC = module.build()
		vc.navigationController?.pushViewController(detailVC, animated: true)
	}
}
