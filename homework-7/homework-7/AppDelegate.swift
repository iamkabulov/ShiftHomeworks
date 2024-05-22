//
//  AppDelegate.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		let router = ImagesListRouter()
		let interactor = ImagesListInteractor()
		let presenter = ImagesListPresenter(router: router)
		presenter.interactor = interactor
		interactor.presenter = presenter
		let vc = ImagesListViewController(presenter: presenter)
		let nav = UINavigationController(rootViewController: vc)
		nav.navigationBar.prefersLargeTitles = true
		window?.rootViewController = nav

		return true
	}
}

