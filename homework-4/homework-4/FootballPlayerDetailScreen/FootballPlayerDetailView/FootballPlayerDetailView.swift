//
//  FootballPlayerDetailView.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

protocol IFootballPlayerDetailView: AnyObject
{
	var buttonTappedHandler: (() -> Void)? { get set }
	func set(model: FootballPlayerDetailEntity)
}

final class FootballPlayerDetailView: UIView {
	
	private enum Metrics {
		enum Spacing {
			static let small: CGFloat = 8
			static let medium: CGFloat = 16
			static let large: CGFloat = 24
		}
		
		static let height: CGFloat = 200
		static let width: CGFloat = 190
	}
	
	private let vStackView = UIStackView()
	private let imageView = UIImageView()
	private let clubLabel = LabelBuilder()
		.cornerRaduis(5)
		.numberOfLines(0)
		.font(.body)
		.build()
	
	private let nationalTeamLabel = LabelBuilder()
		.cornerRaduis(5)
		.numberOfLines(0)
		.font(.body)
		.build()
	
	private let numberLabel = LabelBuilder()
		.cornerRaduis(5)
		.numberOfLines(0)
		.font(.body)
		.build()
	
	private let statsLabel = LabelBuilder()
		.cornerRaduis(5)
		.numberOfLines(0)
		.font(.body)
		.build()
	
	private let bioTextView = UITextView()
	private let contractButton = UIButton(type: .roundedRect)
	
	var buttonTappedHandler: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .secondarySystemBackground
		configureImageView()
		configureBioTextView()
		configureStackView()
		configureButton()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc
	private func buttonTapped(_ sender: UIButton) {
		self.buttonTappedHandler?()
	}
}

//MARK: - Extension
extension FootballPlayerDetailView: IFootballPlayerDetailView {
	func set(model: FootballPlayerDetailEntity) {
		clubLabel.text = model.getClub()
		numberLabel.text = model.getNumber()
		imageView.image = UIImage(named: "\(model.image)")
		statsLabel.text = model.getStats()
		nationalTeamLabel.text = model.getNationalTeam()
		bioTextView.text = model.bio
	}
}

private extension FootballPlayerDetailView {
	
	func configureBioTextView() {
		bioTextView.layer.cornerRadius = 5
		bioTextView.backgroundColor = .white
		bioTextView.textColor = .black
		bioTextView.font = UIFont.preferredFont(forTextStyle: .body)
		bioTextView.tintColor = .clear
	}
	
	func configureImageView() {
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 5
		imageView.clipsToBounds = true
	}
	
	func configureStackView() {
		vStackView.axis = .vertical
		vStackView.distribution = .equalSpacing
		vStackView.spacing = 5
	}
	
	func configureButton() {
		contractButton.setTitle("CONTRACT INFO", for: .normal)
		contractButton.layer.cornerRadius = 5
		contractButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
		contractButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	func setupViews() {
		vStackView.addArrangedSubview(numberLabel)
		vStackView.addArrangedSubview(clubLabel)
		vStackView.addArrangedSubview(nationalTeamLabel)
		vStackView.addArrangedSubview(statsLabel)
		
		addSubview(imageView)
		addSubview(vStackView)
		addSubview(bioTextView)
		addSubview(contractButton)
		
		imageView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(snp.leading).inset(Metrics.Spacing.small)
			make.height.equalTo(Metrics.height)
			make.width.equalTo(Metrics.width)
		}
		
		bioTextView.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(Metrics.Spacing.small)
			make.leading.equalTo(snp.leading).inset(Metrics.Spacing.small)
			make.trailing.equalTo(snp.trailing).inset(Metrics.Spacing.small)
		}
		
		vStackView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(imageView.snp.trailing).offset(Metrics.Spacing.medium)
			make.trailing.equalToSuperview()
		}
		
		contractButton.snp.makeConstraints { make in
			make.top.equalTo(bioTextView.snp.bottom).offset(Metrics.Spacing.small)
			make.leading.equalTo(snp.leading).inset(Metrics.Spacing.small)
			make.trailing.equalTo(snp.trailing).inset(Metrics.Spacing.small)
			make.bottom.equalTo(snp.bottom).inset(Metrics.Spacing.small)
		}
	}
}
