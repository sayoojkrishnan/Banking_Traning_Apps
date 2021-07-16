//
//  MakeDepositViewController.swift
//  BankingApp
//
//  Created by Sayooj Krishnan  on 15/07/21.
//

import UIKit

class MakeDepositViewController: UIViewController {
    
    @IBOutlet weak var chequeDescription : UITextField!
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var viewModel : DepositsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapDeposit(_ sender: UIBarButtonItem) {
        let amount = amount.text!
        let desc = chequeDescription.text!
        let date = datePicker.date
        
        
        if let status = viewModel?.deposit(
            amount: amount,
            chequeImagePath: nil,
            description: desc,
            date: date
        ) , status {
            showAlert(title: "Added")
        }else {
            showAlert(title: "Failed to add",hasFailedToDeposit: true)
        }
        
    }
    
    func showAlert(title : String , hasFailedToDeposit : Bool = false ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { clicked in
            if !hasFailedToDeposit {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
