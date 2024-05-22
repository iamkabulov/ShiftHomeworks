//
//  AppDelegate.swift
//  homework-4
//
//  Created by Кабулов Нурсултан Пернебаевич on 07.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		let interactor = FootballPlayerInteractor()
		let router = FootballPlayersRouter()
		let presenter = FootballPlayerPresenter(interactor: interactor, router: router)
		let vc = FootballPlayersViewController(presenter: presenter)
		window?.rootViewController = UINavigationController(rootViewController: vc)

		return true
	}
}

