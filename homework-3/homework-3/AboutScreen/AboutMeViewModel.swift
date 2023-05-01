//
//  AboutMe.swift
//  homework-3
//
//  Created by Кабулов Нурсултан Пернебаевич on 29.04.2023.
//

import UIKit

struct AboutMeViewModel {
	let imageName: String
	let firstName: String
	let lastName: String
	let middleName: String
	let age: Int
	let city: String
	let degree: String
	let additionalInfo: String
}

let aboutMe = AboutMeViewModel(imageName: "me",
						   firstName: "Кабулов",
						   lastName: "Нурсултан",
						   middleName: "Пернебаевич",
						   age: 25,
						   city: "Казахстан. Астана",
						   degree: "ЕНУ им Л.Н.Гумилева. Автоматизация и управление",
						   additionalInfo: "Родился в 1998 году в Узбекистане. В 19 лет поступил в ЕНУ им Л.Н.Гумилева в Астане. Сейчас работаю тестировщиком мобильных приложений.")
