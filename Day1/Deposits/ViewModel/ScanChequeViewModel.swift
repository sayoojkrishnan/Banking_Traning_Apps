//
//  ScanChequeViewModel.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import Foundation

struct ScanChequeViewModel {
    
    
    func deposit(amount : String ,chequeImagePath : String?, description :String , date : String) -> DepositModel? {
        
        guard let amount = Double(amount) else {return nil}
        guard !description.isEmpty , !date.isEmpty else {return nil }
        
        return DepositModel(
            id: UUID().uuidString,
            date: date,
            amount: amount,
            description: description,
            chequeImagePath: chequeImagePath
        )
        
    }
}
