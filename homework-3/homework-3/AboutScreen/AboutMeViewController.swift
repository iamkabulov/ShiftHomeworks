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
		configureView()
		setupView()
		aboutMeView.setupData(AboutMeViewModel.defaultViewModel())
	}
}

private extension AboutMeViewController {
	func configureView() {
		view.backgroundColor = .systemGray5
	}

	func setupView() {
		aboutMeView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(aboutMeView)
		NSLayoutConstraint.activate([
			aboutMeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			aboutMeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			aboutMeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			aboutMeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
