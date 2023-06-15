//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		let interactor = CurrencyListInteractor()
		let router = CurrencyListRouter()
		let presenter = CurrencyListPresenter()
		let viewController = CurrencyListViewController()

		let moduleBuilder = ModuleBuilder<CurrencyListViewController, CurrencyListInteractor, CurrencyListPresenter, CurrencyListRouter>()
		let module = moduleBuilder.setView(viewController)
								 .setInteractor(interactor)
								 .setPresenter(presenter)
								 .setRouter(router)
								 .buildModule()
		guard let module = module as? UIViewController else { return true }
		window?.rootViewController = UINavigationController(rootViewController: module)

		return true
	}
}

