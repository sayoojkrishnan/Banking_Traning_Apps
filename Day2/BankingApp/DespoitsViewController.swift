//
//  ViewController.swift
//  BankingApp
//
//  Created by Sayooj Krishnan  on 15/07/21.
//

import UIKit

class DespoitsViewController : UIViewController {
    
    private var viewModel = DepositsListViewModel()
    @IBOutlet weak var depositsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        depositsTableView.delegate = self
        depositsTableView.dataSource = self
    }
    
    
}

extension DespoitsViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
    
}
