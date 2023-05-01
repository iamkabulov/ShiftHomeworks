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
		configureChangeButton()
		setData(hobby: myHobbies[0])
	}

	func setData(hobby: HobbyViewModel) {
		hobbyImageView.image = UIImage(named: hobby.imageName)
		hobbyTextView.text = hobby.text
	}

	func configureChangeButton() {
		changeButton.setTitle("Про футбол", for: .normal)
	}

	@IBAction func buttonPressed(_ sender: UIButton) {
		if hobbyImageView.image == UIImage(named: "sailing") {
			setData(hobby: myHobbies[1])
			changeButton.setTitle("Про парусный спорт", for: .normal)
		} else {
			setData(hobby: myHobbies[0])
			changeButton.setTitle("Про футбол", for: .normal)
		}
//		print("buttonPressed")
	}

}

