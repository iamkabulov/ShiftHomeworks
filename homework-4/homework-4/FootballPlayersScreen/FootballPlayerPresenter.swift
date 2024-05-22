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
		vc.title = "Footballers"
		let model = self.interactor.load()
		guard let model = model else { return }
		self.ui?.set(model: model)
		self.ui?.tapButtonHandler = { [weak self] playerName in
			self?.router.nextModule(vc: vc,
									name: playerName)
		}
	}
}
