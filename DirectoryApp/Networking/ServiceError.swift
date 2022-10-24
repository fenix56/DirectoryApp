//
//  ServiceError.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest, dataNotFound, parsingError, networkNotReachable
    
}
