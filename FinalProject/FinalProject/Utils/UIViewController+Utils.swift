//
//  UIViewController+Utils.swift
//  FinalProject
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.06.2023.
//

import UIKit

extension UIViewController {

	func setStatusBar() {
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithTransparentBackground()
		navBarAppearance.backgroundColor = .systemGray3
		UINavigationBar.appearance().standardAppearance = navBarAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
	}

	func setTabBarImage(imageName: String) {
		let configuration = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: imageName, withConfiguration: configuration)
		tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
	}
}
