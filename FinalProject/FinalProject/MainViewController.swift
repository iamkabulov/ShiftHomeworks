////
////  MainViewController.swift
////  FinalProject
////
////  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
////
//
//import UIKit
//
//class MainViewController: UITabBarController {
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		setupViews()
//		setupTabBar()
//
//	}
//
//	private func setupViews() {
//		let interactor = CurrencyListInteractor()
//		let router = CurrencyListRouter()
//		let presenter = CurrencyListPresenter(router: router)
//		interactor.presenter = presenter
//		let currencyListVC = CurrencyListViewController(presenter: presenter)
//
//		let moneyVC = UIViewController()
//		let moreVC = UIViewController()
//
//		currencyListVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
//		moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move money")
//		moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
//
//		let summaryNC = UINavigationController(rootViewController: currencyListVC)
//		let moneyNC = UINavigationController(rootViewController: moneyVC)
//		let moreNC = UINavigationController(rootViewController: moreVC)
//
//		summaryNC.navigationBar.barTintColor = .red
//		hideNavigationBarLine(summaryNC.navigationBar)
//
//		let tabList = [moneyNC, summaryNC, moreNC]
//
//		viewControllers = tabList
//	}
//
//	private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
//			let img = UIImage()
//			navigationBar.shadowImage = img
//			navigationBar.setBackgroundImage(img, for: .default)
//			navigationBar.isTranslucent = false
//		}
//
//	private func setupTabBar() {
//		tabBar.tintColor = .blue
//		tabBar.isTranslucent = false
//	}
//}
