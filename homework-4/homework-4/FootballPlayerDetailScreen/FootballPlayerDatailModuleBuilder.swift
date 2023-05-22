//
//  FootballPlayerDatailModuleBuilder.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 19.05.2023.
//

import UIKit

protocol IFootballPlayerDatailModuleBuilder: AnyObject {
	func getId(_ id: Int)
}

final class FootballPlayerDatailModuleBuilder {
	
	var itemIndex: Int?

	func build() -> UIViewController {
		let interactor = FootballPlayerDetailInteractor()
		let router = FootballPlayerDetailRouter()
		let presenter = FootballPlayerDetailPresenter(interactor: interactor, router: router, itemIndex: self.itemIndex)
		let detailVC = FootballPlayerDetailViewController(presenter: presenter)
		return detailVC
	}
}

extension FootballPlayerDatailModuleBuilder: IFootballPlayerDatailModuleBuilder {
	func getId(_ id: Int) {
		self.itemIndex = id
	}
}
