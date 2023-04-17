//
//  TableCellView.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

	static let reuseId = "TableViewCell"
	static let rowHeight: CGFloat = 80

	let manufaturerLabel = UILabel()
	let modelLabel = UILabel()
	let bodyLabel = UILabel()
	let yearOfIssueLabel = UILabel()
	let carNumberLabel = UILabel()



	override init(style cellType: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: cellType, reuseIdentifier: reuseIdentifier)
		setup()
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TableViewCell {

	func setup() {
		
		manufaturerLabel.translatesAutoresizingMaskIntoConstraints = false
		manufaturerLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

		modelLabel.translatesAutoresizingMaskIntoConstraints = false
		modelLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

		bodyLabel.translatesAutoresizingMaskIntoConstraints = false
		bodyLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

		yearOfIssueLabel.translatesAutoresizingMaskIntoConstraints = false
		yearOfIssueLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

		carNumberLabel.translatesAutoresizingMaskIntoConstraints = false
		carNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

		contentView.addSubview(manufaturerLabel)
		contentView.addSubview(modelLabel)
		contentView.addSubview(bodyLabel)
		contentView.addSubview(yearOfIssueLabel)
		contentView.addSubview(carNumberLabel)

	}

	func layout() {
		NSLayoutConstraint.activate([
			manufaturerLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
			manufaturerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			modelLabel.topAnchor.constraint(equalTo: manufaturerLabel.topAnchor),
			modelLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: manufaturerLabel.trailingAnchor, multiplier: 2),
			bodyLabel.topAnchor.constraint(equalToSystemSpacingBelow: manufaturerLabel.bottomAnchor, multiplier: 2),
			bodyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			yearOfIssueLabel.topAnchor.constraint(equalTo: bodyLabel.topAnchor),
			yearOfIssueLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: bodyLabel.trailingAnchor, multiplier: 2),
			carNumberLabel.topAnchor.constraint(equalTo: bodyLabel.topAnchor),
			carNumberLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: yearOfIssueLabel.trailingAnchor, multiplier: 2),
		])
	}

	func configure(with car: Car) {
		let rawValueOfBody = car.body.rawValue
		guard let bodyType = Body(rawValue: rawValueOfBody)?.description else { return }
		manufaturerLabel.text = "Производитель: \(car.manufaturer)"
		modelLabel.text = "Модель: \(car.model)"
		bodyLabel.text = "Тип кузова: \(bodyType)"

		if let yearOfIssue = car.yearOfIssue {
			yearOfIssueLabel.text = "Год выпуска: \(yearOfIssue)"
		} else {
			yearOfIssueLabel.text = "Год выпуска: -"
		}
		if car.carNumber == "" {
			carNumberLabel.text = ""
		} else if let carNumber = car.carNumber {
			carNumberLabel.text = "Гос. номер: \(carNumber)"
		}
	}
}
