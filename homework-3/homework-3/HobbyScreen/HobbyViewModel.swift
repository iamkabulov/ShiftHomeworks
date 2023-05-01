//
//  HobbyViewModel.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 01.05.2023.
//

import Foundation

struct HobbyViewModel {
	let imageName: String
	let text: String
}

let myHobbies = [HobbyViewModel(imageName: "sailing",
								text: """
										Парусным спортом начал заниматься с 10 лет.
										Первой яхтой, на которой я ходил, был "Отпимист". Затем выступал на "Кадете" в качестве матроса.
										Во взрослой категории выступал на "Лазере".
										Становился чемпионом Узбекистана, Казахстана и Кыргызстана.
										Сейчас учусь ходить на парусной доске.
										"""),
				 HobbyViewModel(imageName: "manutd",
								text: """
										Люблю смотреть футбольные матчи с 2010 года. Болею за команду "Манчестер Юнайтед".
										Иногда с друзьями играю в FIFA.
										""")
]
