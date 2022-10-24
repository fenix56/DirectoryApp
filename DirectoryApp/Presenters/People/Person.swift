//
//  Person.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

class Person {
    let personId: Int
    let firstName, lastName: String
    let email, jobTitle, favColour: String
    let createdAt: String
    let avatarImageURL: URL?
    
    init(personId: Int, firstName: String, lastName: String, email: String, jobTitle: String, favColour: String, createdAt: String, avatarImageURL: URL? = nil) {
        self.personId = personId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.jobTitle = jobTitle
        self.favColour = favColour
        self.createdAt = createdAt
        self.avatarImageURL = avatarImageURL
    }
}
