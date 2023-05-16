//
//  FootballPlayerPresenter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.05.2023.
//

import UIKit

protocol IFootballPlayerPresenter: AnyObject {
	func viewDidLoad(ui: IFootballPlayersView, vc: UIViewController)
}

final class FootballPlayerPresenter {
	weak var ui: IFootballPlayersView?
	private let interactor: IFootballPlayerInteractor
	private let router: IFootballPlayersRouter

	init(interactor: IFootballPlayerInteractor, router: IFootballPlayersRouter) {
		self.interactor = interactor
		self.router = router
	}
}

extension FootballPlayerPresenter: IFootballPlayerPresenter {
	func viewDidLoad(ui: IFootballPlayersView, vc: UIViewController) {
		self.ui = ui
		let model = self.interactor.load()
		
		self.ui?.set(model: model)
		self.ui?.tapButtonHandler = { [weak self] itemIndex in
			self?.router.nextModule(vc: vc,
									itemIndex: itemIndex)
		}
	}
}
