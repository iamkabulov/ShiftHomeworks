//
//  MainViewController.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

class MainViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupTabBar()

	}

	private func setupViews() {
		let listInteractor = CurrencyListInteractor()
		let listRouter = CurrencyListRouter()
		let listPresenter = CurrencyListPresenter()
		let listViewController = CurrencyListViewController()

		let currencyListBuilder = ModuleBuilder<CurrencyListViewController, CurrencyListInteractor, CurrencyListPresenter, CurrencyListRouter>()

		let currencyListModule = currencyListBuilder.setView(listViewController)
								 .setInteractor(listInteractor)
								 .setPresenter(listPresenter)
								 .setRouter(listRouter)
								 .buildModule()

		let converterBuilder = ModuleBuilder<ConverterViewController, ConverterInteractor, ConverterPresenter, ConverterRouter>()

		let converterInteractor = ConverterInteractor()
		let converterRouter = ConverterRouter()
		let converterPresenter = ConverterPresenter()
		let converterViewController = ConverterViewController(code: nil)

		let moneyVC = converterBuilder.setView(converterViewController)
			.setInteractor(converterInteractor)
			.setPresenter(converterPresenter)
			.setRouter(converterRouter)
			.buildModule()

		let moreVC = UIViewController()

		listViewController.setTabBarImage(imageName: "list.dash")
		converterViewController.setTabBarImage(imageName: "arrow.left.arrow.right")
		moreVC.setTabBarImage(imageName: "ellipsis.circle")

		guard let currencyListModule = currencyListModule else { return }
		let currencyList = UINavigationController(rootViewController: currencyListModule as? UIViewController ?? UIViewController())
		let moneyNC = UINavigationController(rootViewController: moneyVC as? UIViewController ?? UIViewController())
		let moreNC = UINavigationController(rootViewController: moreVC)

		currencyList.navigationBar.barTintColor = .red
		hideNavigationBarLine(currencyList.navigationBar)

		let tabList = [moneyNC, currencyList, moreNC]
		view.backgroundColor = .systemBackground
		viewControllers = tabList
	}

	private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
			let img = UIImage()
			navigationBar.shadowImage = img
			navigationBar.setBackgroundImage(img, for: .default)
			navigationBar.isTranslucent = false
		}

	private func setupTabBar() {
		tabBar.tintColor = .blue
		tabBar.isTranslucent = false
	}
}
