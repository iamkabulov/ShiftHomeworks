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

	func build() -> UIViewController {
		let interactor = FootballPlayerInteractor()
		let router = FootballPlayersRouter()
		let presenter = FootballPlayerPresenter(interactor: interactor, router: router)
		let vc = FootballPlayersViewController(presenter: presenter)
		return vc
	}
}
