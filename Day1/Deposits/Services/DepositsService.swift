//
//  DepositsService.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import Foundation


protocol DepositsServiceProtocol  {
    func fetchDeposits(response : @escaping ((Result<[DepositModel],DepositError>) -> Void) )
}

final class DepositService : DepositsServiceProtocol {
    
    func fetchDeposits(response: @escaping ((Result<[DepositModel], DepositError>) -> Void)) {
        let deposits = MockDeposits.list
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            response(.success(deposits))
        }
    }
    
}
