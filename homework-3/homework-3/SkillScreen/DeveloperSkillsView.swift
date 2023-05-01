//
//  DeveloperSkillsView.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 30.04.2023.
//

import UIKit

class DeveloperSkillsView: UIView {

	private let prorammingLanguageIcon = UIImageView()
	private var programmingLanguageLabel = UILabel()
	private let learningDuration = UILabel()
	private let skillsTextView = UITextView()
	private let wishLabel = UILabel()
	private let revealButton = UIButton(type: .system)
	private let vStackView = UIStackView()

	init() {
		super.init(frame: .zero)
		backgroundColor = .systemGray5
		setupViews()
		configureProgrammingLanguageIcon()
		configureProgrammingLanguageLabel()
		configureLearningDuration()
		configureSkillsLabel()
		configureWishLabel()
		configureRevealButton()
		configureStackView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension DeveloperSkillsView {

	func setDate(model: DeveloperSkillsViewModel) {
		prorammingLanguageIcon.image = UIImage(systemName: model.languageIcon, withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.orange]))
		programmingLanguageLabel.text = model.languageName
		learningDuration.text = "Изучаю \(model.learningDuration) год"
		skillsTextView.text = model.skills
		wishLabel.text = model.wish
	}
	private func makeConguredLabel(label: UILabel, font: UIFont.TextStyle) {
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: font)
		label.numberOfLines = 0
	}

	private func configureStackView() {
		vStackView.translatesAutoresizingMaskIntoConstraints = false
		vStackView.distribution = .fill
		vStackView.spacing = Metrics.Spacing.small
		vStackView.axis = .vertical

	}
	private func configureProgrammingLanguageIcon() {
		prorammingLanguageIcon.translatesAutoresizingMaskIntoConstraints = false
		prorammingLanguageIcon.image = UIImage(systemName: "swift", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.orange]))

	}

	private func configureProgrammingLanguageLabel() {
		makeConguredLabel(label: programmingLanguageLabel, font: .title1)
	}

	private func configureLearningDuration() {
		makeConguredLabel(label: learningDuration, font: .title3)
	}

	private func configureSkillsLabel() {
		skillsTextView.translatesAutoresizingMaskIntoConstraints = false
		skillsTextView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
		skillsTextView.textColor = .black
		skillsTextView.layer.cornerRadius = 5
		skillsTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
	}

	private func configureWishLabel() {
		makeConguredLabel(label: wishLabel, font: .subheadline)
	}

	private func configureRevealButton() {
		revealButton.translatesAutoresizingMaskIntoConstraints = false
		revealButton.setTitle("Закрыть ожидания от обучения", for: .normal)
		revealButton.configuration = .tinted()
		revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
	}



	private func setupViews() {
		vStackView.addArrangedSubview(learningDuration)
		vStackView.addArrangedSubview(skillsTextView)
		vStackView.addArrangedSubview(wishLabel)
		
		addSubview(prorammingLanguageIcon)
		addSubview(programmingLanguageLabel)
		addSubview(vStackView)
		addSubview(revealButton)

		NSLayoutConstraint.activate([
			prorammingLanguageIcon.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.medium),
			prorammingLanguageIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			prorammingLanguageIcon.heightAnchor.constraint(equalToConstant: Metrics.imageViewHeight),
			prorammingLanguageIcon.widthAnchor.constraint(equalToConstant: Metrics.imageViewWidth)
		])

		NSLayoutConstraint.activate([
			programmingLanguageLabel.topAnchor.constraint(equalTo: prorammingLanguageIcon.topAnchor),
			programmingLanguageLabel.leadingAnchor.constraint(equalTo: prorammingLanguageIcon.trailingAnchor, constant: Metrics.Spacing.large),
			trailingAnchor.constraint(equalTo: programmingLanguageLabel.trailingAnchor, constant: Metrics.Spacing.medium)
		])

		NSLayoutConstraint.activate([
			vStackView.topAnchor.constraint(equalTo: prorammingLanguageIcon.bottomAnchor, constant: Metrics.Spacing.medium),
			vStackView.leadingAnchor.constraint(equalTo: prorammingLanguageIcon.leadingAnchor),
			trailingAnchor.constraint(equalTo: vStackView.trailingAnchor, constant: Metrics.Spacing.medium),
		])

		NSLayoutConstraint.activate([
			skillsTextView.heightAnchor.constraint(equalToConstant: Metrics.textViewHeight)
		])

		NSLayoutConstraint.activate([
			revealButton.leadingAnchor.constraint(equalTo: prorammingLanguageIcon.leadingAnchor),
			revealButton.trailingAnchor.constraint(equalTo: programmingLanguageLabel.trailingAnchor),
			safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: revealButton.bottomAnchor, constant: Metrics.Spacing.large)
		])
	}

	@objc func revealButtonTapped(_ sender: UIButton) {
		if wishLabel.isHidden {
			wishLabel.isHidden = false
			sender.setTitle("Закрыть ожидания от обучения", for: .normal)
		} else {
			wishLabel.isHidden = true
			sender.setTitle("Открыть ожидания от обучения", for: .normal)
		}
	}
}


private enum Metrics {
	enum Spacing {
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
	}

	static let imageViewHeight: CGFloat = 30
	static let imageViewWidth: CGFloat = 35
	static let textViewHeight: CGFloat = 300
}
