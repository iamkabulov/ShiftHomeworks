//
//  SafeArray.swift
//  homework-2
//
//  Created by Кабулов Нурсултан Пернебаевич on 24.04.2023.
//

import Foundation

struct SafeArray<T> {
	private var elements: [T] = []
	private let semaphore = DispatchSemaphore(value: 1)
	
	var count: Int {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		return elements.count
	}

	var isEmpty: Bool {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		return elements.isEmpty
	}

	mutating func append(_ item: T) {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		self.elements.append(item)
	}

	mutating func remove(at index: Int) {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		self.elements.remove(at: index)
	}

	func subcsript(_ index: Int) -> T {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		return elements[index]
	}

	func contains<T: Equatable> (_ item: T) -> Bool {
		semaphore.wait()
		defer {
			semaphore.signal()
		}
		return elements.contains { item == $0 as? T }
	}
}

extension SafeArray: CustomStringConvertible {
	var description: String {
		"\(elements)"
	}
}
