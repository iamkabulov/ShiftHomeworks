//
//  CurrencyListView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit

protocol ICurrencyListView: AnyObject
{
	func showCurrencies(_ model: [Currency])
	func turnOnCurries(_ model: [Currency])
	func reload()
	var currencyTappedHandler: ((Currency) -> Void)? { get set }
	var addCurrencyHandler: ((String, String) -> Void)? { get set }
	var removeCurrencyHandler: ((String, String) -> Void)? { get set }
}

final class CurrencyListView: UITableView
{
	private var model = [Currency]()
	private var toggleOnCurries = [Currency]()
	private var isLoaded = false
	private let tableView = UITableView()
	var currencyTappedHandler: ((Currency) -> Void)?
	var addCurrencyHandler: ((String, String) -> Void)?
	var removeCurrencyHandler: ((String, String) -> Void)?

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		configureTableView()
		setupTableView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - ICurrencyListView
extension CurrencyListView: ICurrencyListView
{
	func turnOnCurries(_ model: [Currency]) {
		self.toggleOnCurries = model
	}

	func reload() {
		self.tableView.reloadData()
	}

	func showCurrencies(_ model: [Currency]) {
		self.isLoaded = true
		self.model = model
	}


	func setupTableView() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(tableView)

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func configureTableView() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = CurrencyCellView.rowHeight
		self.tableView.register(CurrencyCellView.self, forCellReuseIdentifier: CurrencyCellView.reuseId)
		self.tableView.register(CurrencyLoadingCellView.self, forCellReuseIdentifier: CurrencyLoadingCellView.reuseId)
	}
}

//MARK: - UITableViewDataSource
extension CurrencyListView: UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isLoaded {
			return model.count
		}
		return 11
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let loadingCell = tableView.dequeueReusableCell(withIdentifier: CurrencyLoadingCellView.reuseId, for: indexPath) as? CurrencyLoadingCellView

		guard let loadingCell = loadingCell else { return UITableViewCell() }


		if isLoaded {
			let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCellView.reuseId, for: indexPath) as? CurrencyCellView
			guard let cell = cell else { return loadingCell }
			let code = model[indexPath.item].code
			let name = model[indexPath.item].name

			// Наверное нужно смаппить и сделать новый лист тогда будет проще
			//TODO: - Кажется тут есть баг что при скроле он включает тоггл
			var _ = toggleOnCurries.contains { currency in
				if currency.code == code && currency.name == name {
					cell.setCurrency(code: code, name: name, isOn: true)
					return true
				}
				cell.setCurrency(code: code, name: name, isOn: false)
				return false
			}

			cell.addCurrency = { code, name in
				self.addCurrencyHandler?(code, name)
			}
			cell.removeCurrency = { code, name in
				self.removeCurrencyHandler?(code, name)
			}

			guard !toggleOnCurries.isEmpty else {
				cell.setCurrency(code: code, name: name, isOn: false)
				return cell
			}
			return cell
		}
		return loadingCell
	}
}

//MARK: - UITableViewDelegate
extension CurrencyListView: UITableViewDelegate
{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard tableView.cellForRow(at: indexPath) is CurrencyCellView else { return }
		let code = model[indexPath.item]
		currencyTappedHandler?(code)
	}
}

