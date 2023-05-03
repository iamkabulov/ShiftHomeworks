//
//  DeveloperSkillsViewController.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 27.04.2023.
//

import UIKit

class DeveloperSkillsViewController: UIViewController {

	private let skillsView = DeveloperSkillsView()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		setupView()
		skillsView.setupData(model: DeveloperSkillsViewModel.defaultViewModel())
	}
}

private extension DeveloperSkillsViewController {
	func configureView() {
		view.backgroundColor = .systemGray5
	}

	func setupView() {
		skillsView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(skillsView)
		NSLayoutConstraint.activate([
			skillsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			skillsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
