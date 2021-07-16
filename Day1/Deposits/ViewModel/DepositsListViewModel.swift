//
//  DepositsViewModel.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//


import Foundation

final class DepositsListViewModel  : ObservableObject {
    
    enum DepositViewState {
        case loading
        case failed(String)
        case success
    }
    
    @Published var total : Double = 0
    
    @Published var viewState : DepositViewState?
    
    @Published var deposits : [DepositViewModel] = []
    
    let depositService : DepositsServiceProtocol
    
    init(service : DepositsServiceProtocol = DepositService()) {
        self.depositService = service
    }
    
    func fetchDeposits() {
        viewState = .loading
        depositService.fetchDeposits { [weak self ] response  in
            switch response {
            case .success(let deposits) :
                self?.deposits = deposits.map({DepositViewModel(deposit: $0)})
                self?.total = deposits.reduce(0, { prev, model in
                    return prev + model.amount
                })
                self?.viewState = .success
            case .failure(let error) :
                self?.viewState = .failed(error.desciprtion)
            }
        }
    }
    
    func addNewDeposit(deposit : DepositModel) {
        deposits.append(DepositViewModel(deposit: deposit))
        total += deposit.amount
    }
}


struct DepositViewModel  : Identifiable {
    
    var id : String {
        deposit.id
    }
    
    let deposit : DepositModel
    
    var date : String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: deposit.date) {
            return dateFormatterPrint.string(from: date)
        }
        return "-"
    }
    
    var amount : String {
        return "$\(deposit.amount)"
    }
    
    var description : String {
        deposit.description
    }
    
    var chequePath : URL? {
        if let path = deposit.chequeImagePath {
            return URL(string: path)
        }
        return nil
    }
    
}
