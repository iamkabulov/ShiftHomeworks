//
//  FootballPlayerDetailViewController.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

class FootballPlayerDetailViewController: UIViewController {

	private let contractButton = UIButton(type: .roundedRect)
	private let footballPlayerDetailView = FootballPlayDetailView(frame: .zero)
	private var footBallPlayerDetailViewModel: FootballPlayerDetailViewModel?

	init(with model: FootballPlayerDetailViewModel) {
		super.init(nibName: nil, bundle: nil)
		title = model.name
		view.backgroundColor = .secondarySystemBackground
		footballPlayerDetailView.setData(model: model)
		footBallPlayerDetailViewModel = model
		
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		configureButton()
	}

	func configureButton() {
		contractButton.setTitle("CONTRACT INFO", for: .normal)
		contractButton.layer.cornerRadius = 5
		contractButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
		contractButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	@objc func buttonTapped() {
		guard let model = footBallPlayerDetailViewModel else { return }
		let contractInfoViewController = FootballPlayerContractViewController(model: model)
		if let sheet = contractInfoViewController.sheetPresentationController {
			sheet.detents = [.custom(resolver: { _ in
				return 200
			})]
		}
		present(contractInfoViewController, animated: true)
	}
	
	func setupViews() {
		view.addSubview(footballPlayerDetailView)
		view.addSubview(contractButton)

		footballPlayerDetailView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metrics.Spacing.small)
			make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(Metrics.Spacing.small)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(Metrics.Spacing.small)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metrics.Spacing.large)

		}
		contractButton.snp.makeConstraints { make in
			make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(Metrics.Spacing.small)
			make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(Metrics.Spacing.small)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Metrics.Spacing.small)
		}
	}
}

private enum Metrics {
	enum Spacing {
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 50
	}
}
