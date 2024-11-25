//
//  Repository.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation


enum RepositoryWebAccess {
	
	// sent to Interactor
	// To fetch all the repositories
	// example links:
	// https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1
	// https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc
	struct Request {
		let q: String
		let sort: String
		let page: Int?
		let order: String?
	}
	
	// sent to Presenter
	struct Response: Codable {
		let items: [RepositoryResponse]
		
		enum CodingKeys: String, CodingKey {
			case items
		}
		
		// sent to ViewController
		struct RepositoryResponse: Codable {
			let id: Int
			let name: String
			let fullName: String
			let htmlURL: String
			let description: String?
			let stargazersCount: Int
			let forksCount: Int
			let language: String?
			let owner: RepositoryResponseOwner
			
			enum CodingKeys: String, CodingKey {
				case id
				case name
				case fullName = "full_name"
				case htmlURL = "html_url"
				case description
				case stargazersCount = "stargazers_count"
				case forksCount = "forks_count"
				case language
				case owner
			}
			
			struct RepositoryResponseOwner: Codable {
				let login: String
				let id: Int
				let avatarURL: String
				
				enum CodingKeys: String, CodingKey {
					case login
					case id
					case avatarURL = "avatar_url"
				}
			}
		}
	}
}

// to be returned by Presenter
struct Repository {
	let ownerName: String
	let name: String
	let description: String?
	let stars: Int
	let forks: Int
	let language: String?
	let ownerAvatarURL: String
}

// PRESENTER
//weak var viewController: ViewController
//
//func convert(items: [RepositoryWebAccess.Response]) {
//	for item in items {
//		Repository(name: item., description: <#T##String?#>, stars: <#T##Int#>, forks: <#T##Int#>, language: <#T##String?#>, ownerAvatarURL: <#T##String#>)
//	}
//	
//	viewController.present(Repositories)
//}
