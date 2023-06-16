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
	func reload()
	var currencyTappedHandler: ((String) -> Void)? { get set }
}

final class CurrencyListView: UITableView
{
	private var model = [Currency]()
	private var isLoaded = true
	private let tableView = UITableView()
	var currencyTappedHandler: ((String) -> Void)?

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		configureTableView()
		setupTableView()
		self.model = [Currency(code: "EUR", name: "Euro"),
					  Currency(code: "UZB", name: "So'm Lek"),
					  Currency(code: "EUR", name: "Euro"),
					  Currency(code: "UZB", name: "So'm Lek"),
					  Currency(code: "EUR", name: "Euro"),
					  Currency(code: "UZB", name: "So'm Lek"),
					  Currency(code: "EUR", name: "Euro"),
					  Currency(code: "UZB", name: "So'm Lek"),
					  Currency(code: "EUR", name: "Euro"),
					  Currency(code: "UZB", name: "So'm Lek"),]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - ICurrencyListView
extension CurrencyListView: ICurrencyListView
{
	func reload() {
		self.tableView.reloadData()
	}

	func showCurrencies(_ model: [Currency]) {
		self.isLoaded = true
		self.model = model
		self.reload()
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
			cell.setCurrency(code: code, name: name)
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
//		guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyCellView else { return }
		let code = model[indexPath.item].code
		currencyTappedHandler?(code)
	}
}

