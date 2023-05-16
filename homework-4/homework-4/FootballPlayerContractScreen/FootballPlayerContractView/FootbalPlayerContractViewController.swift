//
//  FootbalPlayerContractViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

class FootballPlayerContractViewController: UIViewController {

	private let contractView = FootballPlayerContractView()
	var presenter: IFootballPlayerContractPresenter

	init(presenter: IFootballPlayerContractPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(ui: self.contractView,
								   vc: self)
		view.backgroundColor = .systemBackground
		setupView()
	}
}

extension FootballPlayerContractViewController {
	func setupView() {
		view.addSubview(contractView)
		contractView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
