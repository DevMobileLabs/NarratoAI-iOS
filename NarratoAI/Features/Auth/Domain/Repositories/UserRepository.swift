//
//  UserRepository.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Foundation

protocol UserRepository {
    func getUser(by id: UUID) -> User?
}
