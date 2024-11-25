//
//  RepositoryInteractor.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

class RepositoryInteractor: BusinessRepository {
	
	var presenter: RepositoryPresenterProtocol?
	var worker: RepositoryWorker
	
	var repositoryResponse: RepositoryWebAccess.Response?
	
	init(presenter: RepositoryPresenterProtocol, worker: RepositoryWorker = RepositoryWorker()) {
		self.presenter = presenter
		self.worker = worker
	}
	
	func startFetchingRepositories(request: RepositoryWebAccess.Request) {
		Task {
			self.repositoryResponse = try await self.worker.fetchRepositories(request: request)
			self.presenter?.convertRepositoryResponseToViewModel(response: self.repositoryResponse)
		}
	}
	
}

