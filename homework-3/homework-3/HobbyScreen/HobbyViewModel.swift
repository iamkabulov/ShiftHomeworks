//
//  HobbyViewModel.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 01.05.2023.
//

import UIKit

struct HobbyViewModel {
	let image: UIImage
	let text: String
	let buttonTitle: String

	static func defaultViewModels() -> [HobbyViewModel] {
		[HobbyViewModel(image: UIImage(named: "sailing") ?? UIImage(),
						text: """
   Парусным спортом начал заниматься с 10 лет.
   Первой яхтой, на которой я ходил, был "Отпимист". Затем выступал на "Кадете" в качестве матроса.
   Во взрослой категории выступал на "Лазере".
   Становился чемпионом Узбекистана, Казахстана и Кыргызстана.
   Сейчас учусь ходить на парусной доске.
   """,
						buttonTitle: "Про футбол"),
		 HobbyViewModel(image: UIImage(named: "manutd") ?? UIImage(),
						text: """
   Люблю смотреть футбольные матчи с 2010 года. Болею за команду "Манчестер Юнайтед".
   Иногда с друзьями играю в FIFA.
   """,
						buttonTitle: "Про парусный спорт")
		]
	}
}
