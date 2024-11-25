//
//  RepositoryPresenter.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

class RepositoryPresenter: RepositoryPresenterProtocol {
	
	weak var repositoryViewController: RepositoryDisplayer?
	
	init(repositoryViewController: RepositoryDisplayer) {
		self.repositoryViewController = repositoryViewController
	}
	
	func convertRepositoryResponseToViewModel(response: RepositoryWebAccess.Response?) {
		guard let response = response else { return }
		
		let repositories: [Repository] = response.items.map { repo in
			return Repository(ownerName: repo.owner.login,
									name: repo.name,
									description: repo.description,
									  stars: repo.stargazersCount,
									  forks: repo.forksCount,
									  language: repo.language,
									  ownerAvatarURL: repo.owner.avatarURL)
		}
		
		repositoryViewController?.repositories = repositories
		repositoryViewController?.displayRepositories()
	}
	
}
