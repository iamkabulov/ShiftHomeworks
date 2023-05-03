//
//  ViewController.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 27.04.2023.
//

import UIKit

class HobbyViewController: UIViewController {

	@IBOutlet weak var hobbyImageView: UIImageView!

	@IBOutlet weak var hobbyTextView: UITextView!

	@IBOutlet weak var changeButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupData(hobby: HobbyViewModel.defaultViewModels()[0])
	}

	func setupData(hobby: HobbyViewModel) {
		hobbyImageView.image = hobby.image
		hobbyTextView.text = hobby.text
		changeButton.setTitle(hobby.buttonTitle, for: .normal)
	}


	@IBAction func buttonPressed(_ sender: UIButton) {
		if changeButton.currentTitle == "Про футбол" {
			setupData(hobby: HobbyViewModel.defaultViewModels()[1])
		} else {
			setupData(hobby: HobbyViewModel.defaultViewModels()[0])
		}
	}
}

