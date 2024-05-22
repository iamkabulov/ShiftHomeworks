//
//  ImagesListInteractor+Networking.swift
//  homework-7
//
//  Created by Кабулов Нурсултан Пернебаевич on 26.05.2023.
//

import UIKit

protocol IImagesListInteractorNetworking: AnyObject {
	func imageDownloaded(url: String, _ image: UIImage?)
	func imageDownloadFailed(url: String, with error: NetworkError)
}

final class ImagesListInteractorNetworking: NSObject {

	private var downloadTask: URLSessionDownloadTask?
	private var resumeDatas: [String: Data?] = [:]
	private var urlSession: URLSession!
	weak var delegate: IImagesListInteractorNetworking?

	override init() {
		super.init()
		let sessionConfig = URLSessionConfiguration.background(withIdentifier: "urlSessionId")
		sessionConfig.sessionSendsLaunchEvents = true
		urlSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
	}
	func getImageByUrl(_ url: String) {
		if resumeDatas.contains(where: { $0.key == url }) {
			delegate?.imageDownloadFailed(url: url, with: NetworkError.alreadyExist)
		} else {
			if let urlString = URL(string: url) {
				let urlReq = URLRequest(url: urlString)
				downloadTask = urlSession.downloadTask(with: urlReq)
				downloadTask?.resume()
			} else {
				delegate?.imageDownloadFailed(url: url, with: NetworkError.decodingError)
			}
		}
	}

	func pauseDownload(_ url: String) {
		downloadTask?.cancel(byProducingResumeData: { [weak self] resumeData in
			self?.resumeDatas[url] = resumeData
		})
	}

	func resumeDownload(_ url: String) {
		if let resumeData = resumeDatas[url], let resumeData = resumeData {
			downloadTask = urlSession.downloadTask(withResumeData: resumeData)
			self.resumeDatas[url] = nil
			downloadTask?.resume()
		}
	}
}

extension ImagesListInteractorNetworking: URLSessionDownloadDelegate, URLSessionTaskDelegate, URLSessionDelegate {
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		guard let originalRequest = downloadTask.originalRequest, let url = originalRequest.url?.absoluteString else {
			return
		}

		do {
			let imageData = try Data(contentsOf: location)
			guard let image = UIImage(data: imageData) else {
				delegate?.imageDownloadFailed(url: url, with: NetworkError.decodingError)
				return
			}
			delegate?.imageDownloaded(url: url, image)
		} catch {
			delegate?.imageDownloadFailed(url: url, with: NetworkError.decodingError)
		}
	}

	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		guard let url = task.originalRequest?.url?.absoluteString else {
			return
		}
		if let error = error {
			if let httpError = error as? URLError {
				let statusCode = httpError.code.rawValue
				if 300..<600 ~= statusCode {
					let httpErrorCode = NetworkError.statusCode(statusCode)
					delegate?.imageDownloadFailed(url: url, with: httpErrorCode)
				}
			} else {
				delegate?.imageDownloadFailed(url: url, with: NetworkError.serverError)
			}
		}
	}
}
