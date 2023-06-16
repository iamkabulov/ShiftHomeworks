////
////  MainViewController.swift
////  FinalProject
////
////  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
////
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

		let currencyListModuleBuilder = ModuleBuilder<CurrencyListViewController, CurrencyListInteractor, CurrencyListPresenter, CurrencyListRouter>()

		let currencyListModule = currencyListModuleBuilder.setView(listViewController)
								 .setInteractor(listInteractor)
								 .setPresenter(listPresenter)
								 .setRouter(listRouter)
								 .buildModule()

		let moneyVC = ConverterViewController()
		let moreVC = UIViewController()

		listViewController.setTabBarImage(imageName: "list.dash")
		moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right")
		moreVC.setTabBarImage(imageName: "ellipsis.circle")

		guard let currencyListModule = currencyListModule else { return }
		let currencyList = UINavigationController(rootViewController: currencyListModule as? UIViewController ?? UIViewController())
		let moneyNC = UINavigationController(rootViewController: moneyVC)
		let moreNC = UINavigationController(rootViewController: moreVC)

		currencyList.navigationBar.barTintColor = .red
		hideNavigationBarLine(currencyList.navigationBar)

		let tabList = [currencyList, moneyNC, moreNC]
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
