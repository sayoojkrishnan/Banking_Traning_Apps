//
//  DepositsListTile.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import SwiftUI

struct DepositsListTile : View {
    
    let desposit : DepositViewModel
    
    var body: some View {
        
        LazyVStack(alignment : .leading) {
            
            HStack {
                Text(desposit.date)
                Spacer()
                Text(desposit.amount).fontWeight(.bold)
            }.padding(.bottom, 10)
            
            Text(desposit.description)
                .font(.body)
                .foregroundColor(.gray)
            
        }
        .padding(.top, 15)
    }
}
