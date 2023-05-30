//
//  ImagesInteractor.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

enum NetworkError: Error {
	case alreadyExist
	case inValidURL
	case serverError
	case decodingError
	case statusCode(Int)
}

protocol IImagesListInteractor: AnyObject {
	func loadImageByLink(url: String)
	func pauseLoadImage(url: String)
	func resumeLoadImage(url: String)
}

final class ImagesListInteractor {
	private var network: ImagesListInteractorNetworking
	var presenter: IImageListPresenter?

	init() {
		self.network = ImagesListInteractorNetworking()
		self.network.delegate = self
	}
}

extension ImagesListInteractor: IImagesListInteractorNetworking {

	func imageDownloaded(url: String, _ image: UIImage?) {
		guard let image = image else { return }
		DispatchQueue.main.async {
			self.presenter?.showImage(url: url, image)
		}
	}

	func imageDownloadFailed(url: String, with error: NetworkError) {
		DispatchQueue.main.async {
			self.presenter?.showError(url: url, error)
		}
	}
}

extension ImagesListInteractor: IImagesListInteractor {
	func loadImageByLink(url: String) {
		self.network.getImageByUrl(url)
	}

	func pauseLoadImage(url: String) {
		print(url + " pause ")
		self.network.pauseDownload(url)
	}

	func resumeLoadImage(url: String) {
		print(url + " resume ")
		self.network.resumeDownload(url)
	}
}
