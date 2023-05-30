//
//  ViewController.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

protocol IImagesListViewController: AnyObject {
	var seachButtonTapped: ((String) -> Void)? { get set }
	func present(vc: UIViewController, animated: Bool, completion: (() -> Void)?)
}

final class ImagesListViewController: UIViewController {

	var seachButtonTapped: ((String) -> Void)?
	private let search = UISearchController()
	private let tableView = ImagesListView(frame: .zero, style: .plain)
	private var presenter: ImagesListPresenter
	

	init(presenter: ImagesListPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = self.tableView
		self.search.searchBar.delegate = self
		self.navigationItem.searchController = self.search
		search.searchBar.text = "https://img3.akspic.ru/crops/3/4/4/3/7/173443/173443-besplatnyj_minimalist-ubuntu-minimalizm-tsvetnoy-linkin_park-7680x4320.jpg"

//		"https://img3.akspic.ru/crops/3/4/4/3/7/173443/173443-besplatnyj_minimalist-ubuntu-minimalizm-tsvetnoy-linkin_park-7680x4320.jpg"
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(tableView: self.tableView, viewController: self)
	}
}

extension ImagesListViewController: UISearchBarDelegate, IImagesListViewController {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let url = searchBar.text else { return }
		seachButtonTapped?(url)
	}

	func present(vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
		self.present(vc, animated: animated, completion: completion)
	}
}

