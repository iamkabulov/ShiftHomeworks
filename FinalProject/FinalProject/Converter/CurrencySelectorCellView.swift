//
//  CurrencySelectorCellView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICurrencySelectorCellView: AnyObject
{

}

final class CurrencySelectorCellView: UITableViewCell
{
	static let reuseId = "currencyCellId"

	lazy private var currencyLabel: UILabel = {
		let currencyLabel = UILabel()
		currencyLabel.text = "USD"
		return currencyLabel
	}()

	lazy private var flagImage: UIImageView = {
		let flagImage = UIImageView()
		flagImage.contentMode = .scaleToFill
		flagImage.image = UIImage(named: "ea")
		return flagImage
	}()

	let tableView = CurrencySelectorListView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CurrencySelectorCellView: ICurrencySelectorCellView
{
	@objc func btnTapped() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 20),
			tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 30),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90)
		])
	}
	func setupView() {
		currencyLabel.translatesAutoresizingMaskIntoConstraints = false
		flagImage.translatesAutoresizingMaskIntoConstraints = false
		addSubview(currencyLabel)
		addSubview(flagImage)
		NSLayoutConstraint.activate([
			flagImage.topAnchor.constraint(equalTo: topAnchor),
			flagImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			flagImage.heightAnchor.constraint(equalToConstant: 18),
			flagImage.widthAnchor.constraint(equalToConstant: 28),
			currencyLabel.topAnchor.constraint(equalTo: topAnchor),
			currencyLabel.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 2)
		])
	}
}

