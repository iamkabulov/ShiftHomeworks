//
//  CurrencyCellView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit

protocol ICurrencyCellView: AnyObject
{
	var removeCurrency: ((_ code: String, _ name: String) -> Void)? { get set }
	var addCurrency: ((_ code: String, _ name: String) -> Void)? { get set }
	func setCurrency(code: String, name: String)
}


final class CurrencyCellView: UITableViewCell
{
	static let reuseId = "cellId"
	static let rowHeight: CGFloat = 60

	private enum Metrics {
		static let height: CGFloat = 32
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 2
			static let medium: CGFloat = 8
		}
	}

	lazy private var code: UILabel = {
		let code = UILabel()
		code.textColor = .black
		return code
	}()

	lazy private var name: UILabel = {
		let name = UILabel()
		name.textColor = .systemGray2
		name.font = .preferredFont(forTextStyle: .caption1)
		return name
	}()

	lazy private var flagImage: UIImageView = {
		let flagImage = UIImageView()
		flagImage.contentMode = .scaleToFill
		return flagImage
	}()

	lazy private var toggle: UISwitch = {
		let toggle = UISwitch()
		toggle.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
		return toggle
	}()

	var addCurrency: ((_ code: String, _ name: String) -> Void)?
	var removeCurrency: ((_ code: String, _ name: String) -> Void)?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupCell()
		backgroundColor = .systemGray6

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - ICurrencyCellView
extension CurrencyCellView: ICurrencyCellView
{
	func setCurrency(code: String, name: String) {
		self.code.text = code
		self.name.text = name
		let countryCode = findFlagImage(code)
		guard let countryCode = countryCode else { return self.flagImage.image = UIImage(named: "xx") }
		self.flagImage.image = UIImage(named: countryCode)
		
	}

	func setToggleOn() {
		toggle.isOn = true
	}

	func findFlagImage(_ currencyCode: String) -> String? {
		let locale = Locale.availableIdentifiers
				.compactMap { Locale(identifier: $0) }
				.first { $0.currency?.identifier == currencyCode }
		let countryCode = locale?.language.region?.identifier.lowercased()
		return countryCode
	}

	@objc func switchValueDidChange(_ sender: UISwitch!) {
		guard let code = self.code.text, let name = self.name.text else { return }
		if (sender.isOn) {
			addCurrency?(code, name)
			print(code + " SWITCH ON")
		}
		else {
			removeCurrency?(code, name)
			print(code + " SWITCH OFF")
		}
	}

	func setupCell() {
		code.translatesAutoresizingMaskIntoConstraints = false
		name.translatesAutoresizingMaskIntoConstraints = false
		flagImage.translatesAutoresizingMaskIntoConstraints = false
		toggle.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(flagImage)
		contentView.addSubview(code)
		contentView.addSubview(name)
		contentView.addSubview(toggle)
		NSLayoutConstraint.activate([
			flagImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			flagImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			flagImage.heightAnchor.constraint(equalToConstant: Metrics.height),
			flagImage.widthAnchor.constraint(equalToConstant: Metrics.width),
			code.topAnchor.constraint(equalTo: flagImage.topAnchor),
			code.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: Metrics.Spacing.medium),
			name.bottomAnchor.constraint(equalTo: flagImage.bottomAnchor),
			name.leadingAnchor.constraint(equalTo: code.leadingAnchor),
			toggle.centerYAnchor.constraint(equalTo: centerYAnchor),
			toggle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium)
		])
	}
}
