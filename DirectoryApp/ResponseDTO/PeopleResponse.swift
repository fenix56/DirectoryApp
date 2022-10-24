//
//  PeopleResponse.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

// MARK: - PeopleResponse
struct PeopleResponse: Decodable {
    let createdAt, firstName, lastName: String
    let avatar: String
    let email, jobtitle, favouriteColor: String
    let id: String
}

typealias People = [PeopleResponse]

extension People {
    func toEntity() -> [Person] {
        return self.map {
            .init(personId: Int($0.id)!, firstName: $0.firstName, lastName: $0.lastName,
                  email: $0.email, jobTitle: $0.jobtitle, favColour: $0.favouriteColor,
                  createdAt: $0.createdAt, avatarImageURL: URL(string: $0.avatar))
        }
    }
}
