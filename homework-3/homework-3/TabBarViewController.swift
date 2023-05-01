//
//  TabBarViewController.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 27.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setupTabBar()
		setupViews()

	}

	private func setupViews() {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let aboutMe = AboutMeViewController()
		let devSkills = DeveloperSkillsViewController()
		let myHobbies = storyBoard.instantiateViewController(withIdentifier: "storyboardId")

		aboutMe.setTabBarImage(imageName: "person.fill", title: "About me")
		devSkills.setTabBarImage(imageName: "medal.fill", title: "Dev skills")
		myHobbies.setTabBarImage(imageName: "figure.sailing", title: "Hobby")

		let tabList = [aboutMe, devSkills, myHobbies]
		viewControllers = tabList
	}

	private func setupTabBar() {
		tabBar.isTranslucent = false
	}
}

extension UIViewController {

	func setTabBarImage(imageName: String, title: String) {
		let configuration = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: imageName, withConfiguration: configuration)
		tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
	}
}
