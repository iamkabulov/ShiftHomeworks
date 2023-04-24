//
//  SafeArray.swift
//  homework-2
//
//  Created by Кабулов Нурсултан Пернебаевич on 24.04.2023.
//

import Foundation

struct SafeArray {
	private var elements: [String] = []
	var count: Int {
		elements.count
	}

	var isEmpty: Bool {
		elements.isEmpty
	}

	mutating func append(_ item: String) {
		elements.append(item)
	}

	mutating func remove(at index: Int) {
		elements.remove(at: index)
	}

	func subcsript(_ index: Int) -> String {
		elements[index]
	}

	func contains(_ item: String) -> Bool {
		elements.contains(item)
	}
}

extension SafeArray: CustomStringConvertible {
	var description: String {
		"\(elements)"
	}
}
