//
//  FootballPlayerContractView.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 08.05.2023.
//

import UIKit

protocol IFootballPlayerContractView: AnyObject {
	var closeTappedHandler: (() -> Void)? { get set }
	func set(model: FootballPlayerContractEntity)
}

final class FootballPlayerContractView: UIView {
	
	private enum Metrics {
		enum Spacing {
			static let small: CGFloat = 8
			static let medium: CGFloat = 16
			static let large: CGFloat = 24
		}
	}
	
	var closeTappedHandler: (() -> Void)?
	
	private let closeButton = UIButton(type: .roundedRect)
	private let costLabel = LabelBuilder()
		.font(.body)
		.cornerRaduis(0)
		.build()
	
	private let contractLabel = LabelBuilder()
		.font(.body)
		.cornerRaduis(0)
		.build()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .secondarySystemBackground
		configureCloseButton()
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc
	private func closeButtonTapped(_ sender: UIButton) {
		self.closeTappedHandler?()
	}
}

//MARK: - Extension
extension FootballPlayerContractView: IFootballPlayerContractView {
	
	func set(model: FootballPlayerContractEntity) {
		costLabel.text = model.getCost()
		contractLabel.text = model.getContract()
	}
}

private extension FootballPlayerContractView {
	
	func configureCloseButton() {
		closeButton.setTitle("Close", for: .normal)
		closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
	}
	
	func setupUI() {
		addSubview(costLabel)
		addSubview(contractLabel)
		addSubview(closeButton)
		
		closeButton.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Metrics.Spacing.small)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(Metrics.Spacing.medium)
		}
		
		costLabel.snp.makeConstraints { make in
			make.top.equalTo(closeButton.snp.bottom).offset(Metrics.Spacing.small)
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
