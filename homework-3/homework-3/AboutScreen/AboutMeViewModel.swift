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
						   firstName: "Kabulov",
						   lastName: "Nursultan",
						   middleName: "Pernebayevich",
						   age: 25,
						   city: "KAZAKHSTAN. ASTANA",
						   degree: "ENU named after L.N.Gumilyov Automation and control",
						   additionalInfo: "Родился в 1998 году в Узбекистане. В 19 лет поступил в ЕНУ им Л.Н.Гумилева в Астану. Сейчас работаю тестировщиком мобильных приложении.")
