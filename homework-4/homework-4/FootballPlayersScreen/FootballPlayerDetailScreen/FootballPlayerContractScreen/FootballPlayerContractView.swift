//
//  FootballPlayerContractView.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 08.05.2023.
//

import UIKit

class FootballPlayerContractView: UIView {

	private let costLabel = UILabel()
	private let contractLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureCostLabel()
		configureContractLabel()
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setData(data: FootballPlayerContractViewModel) {
		costLabel.text = data.getCost()
		contractLabel.text = data.getContract()
	}
}

private extension FootballPlayerContractView {

	func configureCostLabel() {
		makeConfiguredLabel(label: costLabel, font: .body)
	}

	func configureContractLabel() {
		makeConfiguredLabel(label: contractLabel, font: .body)
	}

	func makeConfiguredLabel(label: UILabel, font: UIFont.TextStyle) {
		label.backgroundColor = .white
		label.layer.cornerRadius = 5
		label.font = UIFont.preferredFont(forTextStyle: font)
	}

	func setupUI() {
		addSubview(costLabel)
		addSubview(contractLabel)

		costLabel.snp.makeConstraints { make in
			make.top.equalTo(snp.top).offset(Metrics.Spacing.small)
			make.leading.equalTo(snp.leading).inset(Metrics.Spacing.medium)
			make.trailing.equalTo(snp.trailing).inset(Metrics.Spacing.medium)
		}

		contractLabel.snp.makeConstraints { make in
			make.top.equalTo(costLabel.snp.bottom).offset(Metrics.Spacing.large)
			make.leading.equalTo(snp.leading).inset(Metrics.Spacing.medium)
			make.trailing.equalTo(snp.trailing).inset(Metrics.Spacing.medium)
		}
	}
}

private enum Metrics {
	enum Spacing {
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
	}
}
