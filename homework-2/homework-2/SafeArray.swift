//
//  SafeArray.swift
//  homework-2
//
//  Created by Кабулов Нурсултан Пернебаевич on 24.04.2023.
//

import Foundation

struct SafeArray<T> {
	private var elements: [T] = []
	var count: Int {
		elements.count
	}

	var isEmpty: Bool {
		elements.isEmpty
	}

	mutating func append(_ item: T) {
		elements.append(item)
	}

	mutating func remove(at index: Int) {
		elements.remove(at: index)
	}

	func subcsript(_ index: Int) -> T {
		elements[index]
	}

	func contains<T: Equatable> (_ item: T) -> Bool {
		elements.contains { item == $0 as? T }
	}
}

extension SafeArray: CustomStringConvertible {
	var description: String {
		"\(elements)"
	}
}
