//
//  ImagesEntity.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit


struct ImagesListEntity {
	let url: String
	var image: UIImage?
	var isLoaded: Bool {
		get {
			if image != nil {
				return true
			}
			else {
				return false
			}
		}
	}
	var isPaused: Bool?
	var isSaved: Bool?
}
