//
//  FootballPlayerDetailView.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

class FootballPlayDetailView: UIView {

	private let vStackView = UIStackView()
	private let clubLabel = UILabel()
	private let imageView = UIImageView()
	private let nationalTeamLabel = UILabel()
	private let numberLabel = UILabel()
	private let statsLabel = UILabel()
	private let bioTextView = UITextView()


	override init(frame: CGRect) {
		super.init(frame: frame)
		configureImageView()
		configureNumberLabel()
		configureClubLabel()
		configureNationalTeamLabel()
		configureStatsLabel()
		configureBioTextView()
		configureStackView()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setData(model: FootballPlayerDetailViewModel) {
		clubLabel.text = model.getClub()
		numberLabel.text = model.getNumber()
		imageView.image = model.image
		statsLabel.text = model.getStats()
		nationalTeamLabel.text = model.getNationalTeam()
		bioTextView.text = model.bio
	}

}

private extension FootballPlayDetailView {
	func makeConfiguredLabel(label: UILabel, font: UIFont.TextStyle) {
		label.layer.cornerRadius = 5
		label.font = UIFont.preferredFont(forTextStyle: font)
		label.numberOfLines = 0
	}

	func configureClubLabel() {
		makeConfiguredLabel(label: clubLabel, font: .body)
	}

	func configureNationalTeamLabel() {
		makeConfiguredLabel(label: nationalTeamLabel, font: .body)
	}

	func configureNumberLabel() {
		makeConfiguredLabel(label: numberLabel, font: .body)
	}

	func configureStatsLabel() {
		makeConfiguredLabel(label: statsLabel, font: .body)
	}

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

	func setupViews() {
		vStackView.addArrangedSubview(numberLabel)
		vStackView.addArrangedSubview(clubLabel)
		vStackView.addArrangedSubview(nationalTeamLabel)
		vStackView.addArrangedSubview(statsLabel)

		addSubview(imageView)
		addSubview(vStackView)
		addSubview(bioTextView)

		imageView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.height.equalTo(Metrics.height)
			make.width.equalTo(Metrics.width)
		}

		bioTextView.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).offset(Metrics.Spacing.small)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}

		vStackView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalTo(imageView.snp.trailing).offset(Metrics.Spacing.medium)
			make.trailing.equalToSuperview()
		}
	}
}
private enum Metrics {
	enum Spacing {
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
	}

	static let height: CGFloat = 200
	static let width: CGFloat = 190
}
