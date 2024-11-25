//
//  PullRequestModel.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation


enum PullRequestWebAccess {
	
	// example link:
	// https://api.github.com/repos/vsouza/awesome-ios/pulls?state=closed
	struct Request {
		let owner: String
		let repository: String
		let state: String
	}
	
	struct Response: Codable {
		let items: [PullRequestResponse]
		
		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			items = try container.decode([PullRequestResponse].self)
		}
		
		struct PullRequestResponse: Codable {
			let title: String
			let user: PullRequestOwner
			let body: String?
			let createdAt: Date
			let closedAt: Date?
			
			enum CodingKeys: String, CodingKey {
				case title
				case user
				case body
				case createdAt = "created_at"
				case closedAt = "closed_at"
			}
			
			struct PullRequestOwner: Codable {
				let login: String
				let avatarURL: String
				
				enum CodingKeys: String, CodingKey {
					case login
					case avatarURL = "avatar_url"
				}
			}
		}

	}
}

// To be returned by Presenter
struct PullRequest {
	let authorName: String
	let authorAvatarURL: String
	let title: String
	let body: String?
	let createdAt: Date
	let closedAt: Date?
}
