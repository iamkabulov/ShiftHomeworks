//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 15.06.2023.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		let mainVC = MainViewController()
		window?.rootViewController = mainVC

		return true
	}
}

