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
		let interactor = FootballPlayerDetailInteractor()
		let router = FootballPlayerDetailRouter()
		let presenter = FootballPlayerDetailPresenter(interactor: interactor, router: router, itemIndex: itemIndex)
		let detailVC = FootballPlayerDetailViewController(presenter: presenter)
		vc.navigationController?.pushViewController(detailVC, animated: true)
	}
}
