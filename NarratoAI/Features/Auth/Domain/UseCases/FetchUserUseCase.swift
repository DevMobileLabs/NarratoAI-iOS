//
//  FetchUserUseCase.swift
//  NarratoAI
//
//  Created by Kain Nguyen on 28/3/25.
//

import Foundation

protocol FetchUserUseCase {
    func execute(userId: UUID) -> User
}
