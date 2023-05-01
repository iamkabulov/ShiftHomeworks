//
//  DeveloperSkillsViewModel.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 01.05.2023.
//

import Foundation

struct DeveloperSkillsViewModel {
	let languageIcon: String
	let languageName: String
	let learningDuration: Int
	let skills: String
	let wish: String
}

let developerSkillsModel = DeveloperSkillsViewModel(languageIcon: "swift",
													languageName: "Swift",
													learningDuration: 1,
													skills: """
															\u{2022} Владею базовыми командами git. (pull, push, merge, rebase и тд.) \n
															\u{2022} Пишу UI тесты (XCTest) \n
															\u{2022} Использую паттерн MVC \n
															\u{2022} Умею дебажить код \n
															\u{2022} Владею snapKit \n
															\u{2022} Знаю базовые компоненты UIKit \n

															""",
													wish: "На этом курсе хочу получить углубленные знания и практический опыт, а также начать карьеру в разработке")
