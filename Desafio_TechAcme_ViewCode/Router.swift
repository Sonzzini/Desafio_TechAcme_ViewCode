//
//  Router.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation
import UIKit

class Router {
	private weak var navigationController: UINavigationController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func navigateToRepositoryDetail(repository: Repository) {
		let detailVC = Configurator.configurePullRequestViewController(with: repository)
		navigationController?.pushViewController(detailVC, animated: true)
	}
}

