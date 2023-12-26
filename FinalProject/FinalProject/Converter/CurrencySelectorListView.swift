//
//  CurrencySelectorListView.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//
//

//import UIKit
//
//protocol ICurrencySelectorListView: AnyObject
//{
//	func showCurrencies(_ model: [CurrencyRate])
//	func reload()
//	var currencyTappedHandler: ((String) -> Void)? { get set }
//}
//
//final class CurrencySelectorListView: UITableView
//{
//	private var model = [CurrencyRate]()
//	private let tableView = UITableView()
//	var currencyTappedHandler: ((String) -> Void)?
//
//	override init(frame: CGRect, style: UITableView.Style) {
//		super.init(frame: frame, style: style)
//		configureTableView()
//		setupTableView()
//		self.model = [CurrencyRate(code: "USD", rate: 1)]
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//}
//
////MARK: - ICurrencyListView
//extension CurrencySelectorListView: ICurrencySelectorListView
//{
//	func reload() {
//		self.tableView.reloadData()
//	}
//
//	func showCurrencies(_ model: [CurrencyRate]) {
//		self.model = model
//		self.reload()
//	}
//
//
//	func setupTableView() {
//		self.tableView.translatesAutoresizingMaskIntoConstraints = false
//		addSubview(tableView)
//
//		NSLayoutConstraint.activate([
//			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//		])
//	}
//
//	func configureTableView() {
//		self.tableView.delegate = self
//		self.tableView.dataSource = self
//		self.tableView.rowHeight = 40
//		self.tableView.register(CurrencySelectorCellView.self, forCellReuseIdentifier: CurrencySelectorCellView.reuseId)
//	}
//}
//
////MARK: - UITableViewDataSource
//extension CurrencySelectorListView: UITableViewDataSource
//{
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return model.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectorCellView.reuseId, for: indexPath) as? CurrencySelectorCellView
//		guard let cell = cell else { return UITableViewCell() }
////		let code = model[indexPath.item].code
////		let name = model[indexPath.item].rate
////		cell.setCurrency(code: code, name: name)
//		return cell
//	}
//}
//
////MARK: - UITableViewDelegate
//extension CurrencySelectorListView: UITableViewDelegate
//{
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		tableView.deselectRow(at: indexPath, animated: true)
////		guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyCellView else { return }
////		`let code = model[indexPath.item].code
////		currencyTappedHandler?(code)`
//	}
//}
//
//
