//
//  UIResponder.swift
//  homework-1
//
//  Created by Кабулов Нурсултан Пернебаевич on 16.04.2023.
//

import UIKit

extension UIResponder {

	private struct Static {
		static weak var responder: UIResponder?
	}

	static func currentFirst() -> UIResponder? {
		Static.responder = nil
		UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
		return Static.responder
	}

	@objc private func _trap() {
		Static.responder = self
	}
}
