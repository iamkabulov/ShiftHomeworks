//
//  DeveloperSkillsViewModel.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 01.05.2023.
//

import UIKit

struct DeveloperSkillsViewModel {
	let languageIcon: UIImage
	let languageName: String
	let learningDuration: String
	let skills: String
	let wish: String

	static func defaultViewModel() -> DeveloperSkillsViewModel {
		return DeveloperSkillsViewModel(languageIcon: UIImage(systemName: "swift", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.orange])) ?? UIImage(),
										languageName: "Swift",
												 learningDuration: "Изучаю 1 год",
												 skills: """
														 \u{2022} Владею базовыми командами git. (pull, push, merge, rebase и тд.) \n
														 \u{2022} Пишу UI тесты (XCTest) \n
														 \u{2022} Использую паттерн MVC \n
														 \u{2022} Умею дебажить код \n
														 \u{2022} Владею snapKit \n
														 \u{2022} Знаю базовые компоненты UIKit \n

														 """,
												 wish: "На этом курсе хочу получить углубленные знания и практический опыт, а также начать карьеру в разработке")
	}
}
