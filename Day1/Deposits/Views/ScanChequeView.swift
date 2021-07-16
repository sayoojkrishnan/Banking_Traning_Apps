//
//  ScanChequeView.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import SwiftUI

struct ScanChequeView : View {
    
    var viewModel : ScanChequeViewModel = ScanChequeViewModel()
    var didAddNewDeposit : ((DepositModel) -> Void)
    @State var description : String = ""
    @State var amount : String = ""
    @State var date : String = ""
    
    @State var showsAddedAlert = false
    var body: some View {
        
        VStack {
            
            GeometryReader { geo in
                Color.black.frame(width: geo.size.width, height: 300, alignment: .center)
            }
            
            VStack {
                
                TextField("Date",text : $date).padding(.bottom, 10)
                TextField("Amount", text : $amount).padding(.bottom, 10)
                TextField("Description", text: $description).padding(.bottom, 10)
                
                Button(action: {
                    let newDeposit = viewModel.deposit(amount: amount, chequeImagePath: nil, description: description, date: date)
                    
                    if let deposit = newDeposit {
                        didAddNewDeposit(deposit)
                        showsAddedAlert.toggle()
                    }
                    
                }, label: {
                    Text("Add")
                })
            }.alert(isPresented: $showsAddedAlert, content: {
                Alert(title: Text("Deposit Added"), dismissButton: .default(Text("Ok")))
            })
            
            
            
        }.padding()
        
    }
}

struct ScanChequeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanChequeView { depo in }
    }
}



