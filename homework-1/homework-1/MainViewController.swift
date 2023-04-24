//
//  MainViewController.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.04.2023.
//

import UIKit

class MainViewController: UITabBarController {
	let addViewController = AddScreenViewController()
	let listViewController = ListScreenViewController()

	override func viewDidLoad() {
		super.viewDidLoad()
		style()
	}

	func style() {
		addViewController.tabBarItem = UITabBarItem(title: "Новое авто", image: UIImage(systemName: "car.fill"), tag: 0)
		listViewController.tabBarItem = UITabBarItem(title: "Список авто", image: UIImage(systemName: "list.dash"), tag: 1)

		let addNavigationController = UINavigationController(rootViewController: addViewController)
		let listNavigationController = UINavigationController(rootViewController: listViewController)


		let tabList = [listNavigationController, addNavigationController]
		tabBar.backgroundColor = .systemGray6
		tabBar.tintColor = .black
		tabBar.isTranslucent = false
		viewControllers = tabList
	}
}

