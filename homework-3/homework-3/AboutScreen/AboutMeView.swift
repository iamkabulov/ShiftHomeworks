//
//  AboutMeView.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 28.04.2023.
//

import UIKit

class AboutMeView: UIView {

	private let stackView = UIStackView()
	private let imageView = UIImageView()
	private let additionalInfoView = UITextView()
	private var firstNameLabel = UILabel()
	private var lastNameLabel = UILabel()
	private var middleNameLabel = UILabel()
	private var ageLabel = UILabel()
	private var cityLabel = UILabel()
	private var degreeLabel = UILabel()


	init() {
		super.init(frame: .zero)
		configureImageView()
		configureFirstNameLabel()
		configureLastNameLabel()
		configureMiddleNameLabel()
		configureAgeLabel()
		configureCityLabel()
		configureDegreeLabel()
		configureStackView()
		configureTextView()
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupData(_ model: AboutMeViewModel) {
		imageView.image = model.image
		firstNameLabel.text = model.firstName
		lastNameLabel.text = model.lastName
		middleNameLabel.text = model.middleName
		ageLabel.text = model.age
		cityLabel.text = model.city
		degreeLabel.text = model.degree
		additionalInfoView.text = model.additionalInfo
	}
}

private extension AboutMeView {

	private func makeConguredLabel(label: UILabel, font: UIFont.TextStyle) {
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: font)
		label.numberOfLines = 0
	}

	private func configureFirstNameLabel() {
		makeConguredLabel(label: firstNameLabel,font: .title1)
	}

	private func configureLastNameLabel() {
		makeConguredLabel(label: lastNameLabel, font: .title1)
	}

	private func configureMiddleNameLabel() {
		makeConguredLabel(label: middleNameLabel, font: .title1)
	}

	private func configureAgeLabel() {
		makeConguredLabel(label: ageLabel,font: .body)
	}

	private func configureCityLabel() {
		makeConguredLabel(label: cityLabel, font: .body)
	}

	private func configureDegreeLabel() {
		makeConguredLabel(label: degreeLabel, font: .subheadline)
	}

	private func configureImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 5
		imageView.clipsToBounds = true
	}

	private func configureStackView() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.distribution = .equalSpacing
		stackView.axis = .vertical

	}

	private func configureTextView() {
		additionalInfoView.translatesAutoresizingMaskIntoConstraints = false
		additionalInfoView.layer.cornerRadius = 5
		additionalInfoView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
		additionalInfoView.textColor = .black
		additionalInfoView.font = .preferredFont(forTextStyle: .body)
	}

	private func setupViews() {
		stackView.addArrangedSubview(firstNameLabel)
		stackView.addArrangedSubview(lastNameLabel)
		stackView.addArrangedSubview(middleNameLabel)
		stackView.addArrangedSubview(ageLabel)
		stackView.addArrangedSubview(cityLabel)
		stackView.addArrangedSubview(degreeLabel)

		addSubview(imageView)
		addSubview(stackView)
		addSubview(additionalInfoView)

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.medium),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			imageView.heightAnchor.constraint(equalToConstant: Metrics.height),
			imageView.widthAnchor.constraint(equalToConstant: Metrics.width)
		])

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.medium),
			stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Metrics.Spacing.large),
			trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Metrics.Spacing.medium),
			stackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
		])

		NSLayoutConstraint.activate([
			additionalInfoView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metrics.Spacing.medium),
			additionalInfoView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			additionalInfoView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
			bottomAnchor.constraint(equalTo: additionalInfoView.safeAreaLayoutGuide.bottomAnchor, constant: Metrics.Spacing.medium)
		])
	}
}

private enum Metrics {
	enum Spacing {
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
	}

	static let height: CGFloat = 200
	static let width: CGFloat = 120
}

