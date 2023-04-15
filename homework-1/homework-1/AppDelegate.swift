//
//  AppDelegate.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 14.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemGray5
		window?.rootViewController = ViewController()

		return true
	}
}

