//
//  FootbalPlayerContractViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

class FootballPlayerContractViewController: UIViewController {

	private let closeButton = UIButton(type: .roundedRect)
	private let contractView = FootballPlayerContractView()

	init(model: FootballPlayerDetailViewModel) {
		super.init(nibName: nil, bundle: nil)
		let contractViewModel = FootballPlayerContractViewModel(with: model)
		contractView.setData(data: contractViewModel)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureCloseButton()
		setupUI()
	}
}

extension FootballPlayerContractViewController {

	func configureCloseButton() {
		closeButton.setTitle("Close", for: .normal)
		closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
	}

	@objc func closeButtonTapped() {
		dismiss(animated: true)
	}

	func setupUI() {
		view.addSubview(closeButton)
		view.addSubview(contractView)

		closeButton.snp.makeConstraints { make in
			make.top.equalTo(view.snp.top).offset(10)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
		}

		contractView.snp.makeConstraints { make in
			make.top.equalTo(closeButton.snp.bottom)
			make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
		}

	}
}
