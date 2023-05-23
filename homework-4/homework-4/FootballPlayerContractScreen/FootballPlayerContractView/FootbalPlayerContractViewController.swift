//
//  FootbalPlayerContractViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

final class FootballPlayerContractViewController: UIViewController {

	private let contractView = FootballPlayerContractView()
	private var presenter: IFootballPlayerContractPresenter

	init(presenter: IFootballPlayerContractPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.contractView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(ui: self.contractView,
								   vc: self)
	}
}
