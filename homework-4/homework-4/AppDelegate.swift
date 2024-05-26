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
		do {
			let footballPlayersModule = try FootballPlayersModuleBuilder()
				.router(router)
				.interactor(interactor)
				.build()
			window?.rootViewController = UINavigationController(rootViewController: footballPlayersModule)
		} catch {
			let vc = UIViewController()
			window?.rootViewController = vc
			let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			vc.present(alert, animated: true)
		}
		return true
	}
}

