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
															\u{2022} Базовые команды git. (pull, push, merge, rebase и тд.) \n
															\u{2022} Писать UI тесты (XCTest) \n
															\u{2022} Работать в команде \n
															\u{2022} Паттерн MVC \n
															\u{2022} Дебажить код \n
															""",
													wish: "Получение практического опыта, а также развитие карьеры")
