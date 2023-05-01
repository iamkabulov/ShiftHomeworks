//
//  AboutMeViewController.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 27.04.2023.
//

import UIKit

class AboutMeViewController: UIViewController {

	private let aboutMeView = AboutMeView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		style()
		layout()
		aboutMeView.setupData(aboutMe)
		// Do any additional setup after loading the view.
	}


}

extension AboutMeViewController {
	func style() {
		view.backgroundColor = .systemGray5
		aboutMeView.translatesAutoresizingMaskIntoConstraints = false
	}

	func layout() {
		view.addSubview(aboutMeView)
		NSLayoutConstraint.activate([
			aboutMeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			aboutMeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			aboutMeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			aboutMeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
