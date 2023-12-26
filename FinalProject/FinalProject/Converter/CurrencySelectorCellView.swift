//
//  CurrencySelectorCellView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

protocol ICurrencySelectorCellViewDelegate: AnyObject
{
	func didTappedHandler(code: String, name: String)
	func getCurrency() -> String
}

final class CurrencySelectorCellView: UIButton
{
	lazy private var currencyLabel: UILabel = {
		let currencyLabel = UILabel()
		return currencyLabel
	}()

	lazy private var flagImage: UIImageView = {
		let flagImage = UIImageView()
		flagImage.contentMode = .scaleToFill
		return flagImage
	}()

	lazy private var showMenuButton: UIButton = {
		let button = UIButton(type: .custom)
		let image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(image, for: .normal)
		button.tintColor = .black
		return button
	}()

	weak var buttonTappedHandler: ICurrencySelectorCellViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		buttonTappedHandler = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CurrencySelectorCellView: ICurrencySelectorCellViewDelegate
{
	func setCurrency(_ currency: Currency?) {
		guard let currency = currency else { return }
		currencyLabel.text = currency.code
		flagImage.image = UIImage(named: currency.findFlagImage(currency.code))
	}

	func getCurrency() -> String {
		guard let name = currencyLabel.text else { return "" }
		return name
	}

	func didTappedHandler(code: String, name: String) {
		flagImage.image = UIImage(named: code)
		currencyLabel.text = name
	}

	func setupView() {
		currencyLabel.translatesAutoresizingMaskIntoConstraints = false
		flagImage.translatesAutoresizingMaskIntoConstraints = false
		addSubview(currencyLabel)
		addSubview(flagImage)
		addSubview(showMenuButton)
		NSLayoutConstraint.activate([
			flagImage.topAnchor.constraint(equalTo: topAnchor),
			flagImage.heightAnchor.constraint(equalToConstant: 18),
			flagImage.widthAnchor.constraint(equalToConstant: 28),
			currencyLabel.topAnchor.constraint(equalTo: topAnchor),
			currencyLabel.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 2),
			currencyLabel.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
			showMenuButton.topAnchor.constraint(equalTo: flagImage.topAnchor),
			showMenuButton.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 2),
			showMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			showMenuButton.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor)
		])
	}
}

