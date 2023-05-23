//
//  FootballPlayerContractPresenter.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.05.2023.
//

import UIKit

protocol IFootballPlayerContractPresenter {
	func viewDidLoad(ui: IFootballPlayerContractView, vc: UIViewController)
}

final class FootballPlayerContractPresenter {

	weak var ui: IFootballPlayerContractView?
	private let interactor: IFootballPlayerContractInteractor
	private let router: IFootballPlayerContractRouter
	private let model: FootballPlayerContractEntity?

	init(interactor: IFootballPlayerContractInteractor, router: IFootballPlayerContractRouter, model: FootballPlayerDetailEntity) {
		self.interactor = interactor
		self.router = router
		self.model = FootballPlayerContractEntity(with: model)
	}
}

extension FootballPlayerContractPresenter: IFootballPlayerContractPresenter {
	func viewDidLoad(ui: IFootballPlayerContractView, vc: UIViewController) {
		self.ui = ui
		guard let model = self.model else { return }
		self.ui?.set(model: model)

		self.ui?.closeTappedHandler = { [unowned self] in
			vc.dismiss(animated: true)
		}
	}


}
