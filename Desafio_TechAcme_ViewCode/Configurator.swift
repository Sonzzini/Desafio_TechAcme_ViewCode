//
//  Configurator.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

class Configurator {
	static func configureRepositoryViewController() -> RepositoryViewController {
		let viewController = RepositoryViewController()
		
		let presenter = RepositoryPresenter(repositoryViewController: viewController)
		let interactor = RepositoryInteractor(presenter: presenter)
		
		viewController.repositoryInteractor = interactor
		
		return viewController
	}
	
	static func configurePullRequestViewController(with repository: Repository) -> PullRequestViewController {
		let viewController = PullRequestViewController(repository: repository)
		
		let presenter = PullRequestPresenter(pullRequestViewController: viewController)
		let interactor = PullRequestInteractor(presenter: presenter)
		
		viewController.pullRequestInteractor = interactor
		
		return viewController
	}
}

