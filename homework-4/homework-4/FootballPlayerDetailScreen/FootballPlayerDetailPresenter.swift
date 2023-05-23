//
//  FootballPlayerDetailPresenter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import UIKit

protocol IFootballPlayerDetailPresenter: AnyObject {
	func viewDidLoad(ui: IFootballPlayerDetailView, vc: UIViewController)
}

final class FootballPlayerDetailPresenter {

	weak var ui: IFootballPlayerDetailView?
	private var model: FootballPlayerDetailEntity?
	private let interactor: IFootballPlayerDetailInteractor
	private let router: IFootballPlayerDetailRouter

	init(interactor: IFootballPlayerDetailInteractor, router: IFootballPlayerDetailRouter, name: String) {
		self.interactor = interactor
		self.router = router
		self.model = self.interactor.load(name: name)
	}
}

extension FootballPlayerDetailPresenter: IFootballPlayerDetailPresenter {
	func viewDidLoad(ui: IFootballPlayerDetailView, vc: UIViewController) {
		self.ui = ui
		guard let model = self.model else { return }
		vc.title = model.name
		self.ui?.set(model: model)
		self.ui?.buttonTappedHandler = { [weak self] in
			self?.router.nextModule(vc: vc,
									model: model)
		}
	}


}
