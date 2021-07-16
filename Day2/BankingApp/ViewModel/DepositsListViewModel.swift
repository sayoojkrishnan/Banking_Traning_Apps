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
    
    enum Sections  : Int{
        case total = 0
        case deposits = 1
        
        static func sectionHeader(for section : Int) ->String {
            if section == 0 {
                return "Total"
            }
            return "Deposits"
        }
        
    }
    
    private var total : Double = 0
    
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
                self?.deposits = deposits.sorted(by: {$0.addedDate > $1.addedDate}).map({DepositViewModel(deposit: $0)})
                self?.total = deposits.reduce(0, { prev, model in
                    return prev + model.amount
                })
                self?.viewState = .success
            case .failure(let error) :
                self?.viewState = .failed(error.desciprtion)
            }
        }
    }
    
   
    
    
    func deposit(amount : String ,chequeImagePath : String?, description :String , date : Date) -> Bool? {
        
        guard let amount = Double(amount),!description.isEmpty  else {return false}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let addedDate = dateFormatter.string(from: date)
        
        let deposit =  DepositModel(
            id: UUID().uuidString,
            date: addedDate,
            amount: amount,
            description: description,
            chequeImagePath: chequeImagePath
        )
        
        deposits.append(DepositViewModel(deposit: deposit))
        deposits = deposits.sorted(by: {$0.addedDate > $1.addedDate})
        total += deposit.amount
        
        return true
    }
    
}


//MARK: Deposits list data source
extension DepositsListViewModel {
    
    func depositViewModelFor(indexPath : IndexPath ) ->DepositViewModel {
        deposits[indexPath.row]
    }
    
    var totalDeposits : String {
        return "$\(total.description)"
    }
    
    var numberOfSections : Int {
        return 2
    }
    
    func sectionHeaderTitle(for section : Int) -> String {
        return Sections.sectionHeader(for: section)
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        if section == 0 {
            return 1
        }
        return deposits.count
    }
    
}
