//
//  main.swift
//  homework-2
//
//  Created by Кабулов Нурсултан Пернебаевич on 24.04.2023.
//

import Foundation

var array = SafeArray<Int>()

let queue = DispatchQueue(label: "userQueue", attributes: .concurrent)

let task1 = {
	for i in 1...1000 {
		array.append(i)
	}
}

let task2 = {
	for i in 1001...2000 {
		array.append(i)
	}
}

queue.async(execute: task1)
queue.async(execute: task2)

queue.sync(flags: .barrier) {

	print(array.count)
}




