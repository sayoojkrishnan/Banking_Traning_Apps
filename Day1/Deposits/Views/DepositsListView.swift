//
//  ContentView.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import SwiftUI

struct DepositsListView : View {
    
    @ObservedObject var viewModel =  DepositsListViewModel()
    
    var body: some View {
        NavigationView {
            
            switch viewModel.viewState {
            case .loading :
                Text("Loading...")
            case .success :
                
                ScrollView {
                    ForEach(viewModel.deposits) {
                        DepositsListTile(desposit: $0)
                    }.padding()
                    
                }
                .navigationBarTitle("Deposits : $\(viewModel.total.description)", displayMode: .large)
                .navigationBarItems(trailing: NavigationLink(destination: ScanChequeView(didAddNewDeposit: { newItem in
                    viewModel.addNewDeposit(deposit: newItem)
                })) {
                    Text("Deposit")
                })
                
            case .failed(let error) :
                Text(error)
                Button(action: {
                    viewModel.fetchDeposits()
                }, label: {
                    Text("Retry")
                })
            default :
                Text("")
            }
            
            
        }.onAppear{viewModel.fetchDeposits()}
        
    }
}

struct DepositsListView_Previews: PreviewProvider {
    static var previews: some View {
        DepositsListView()
    }
}
