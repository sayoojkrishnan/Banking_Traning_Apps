//
//  ViewController.swift
//  BankingApp
//
//  Created by Sayooj Krishnan  on 15/07/21.
//

import Combine
import UIKit

class DespoitsViewController : UIViewController {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var bag = Set<AnyCancellable>()
    private var viewModel = DepositsListViewModel()
    
    @IBOutlet weak var depositsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depositsTableView.delegate = self
        depositsTableView.dataSource = self
        depositsTableView.isHidden = true
        viewModel.fetchDeposits()
        bind()
    }
    
    private func bind() {
        
        viewModel.$deposits
            .receive(on: RunLoop.main)
            .sink { [weak self]_ in
                self?.depositsTableView.reloadData()
            }.store(in: &bag)
        
        viewModel.$viewState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .loading :
                    self?.spinner.startAnimating()
                case .failed(let error) :
                    self?.spinner.stopAnimating()
                   
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                        self?.viewModel.fetchDeposits()
                    }))
                    self?.present(alert, animated: true, completion: nil)
                case .success :
                    self?.spinner.stopAnimating()
                    self?.depositsTableView.isHidden = false
                default :
                    break
                }
            }.store(in: &bag)
    }
    
    
    @IBAction func didTapAddDeposit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "scanChequeVC", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scanChequeVC" {
            if  let destination = segue.destination as? MakeDepositViewController {
                destination.viewModel = viewModel
            }
        }
    }
}

extension DespoitsViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sectionHeaderTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DepositListTotalCell", for: indexPath) as! DepositListTotalCell
            cell.totalDeposits.text = viewModel.totalDeposits
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DepositsListCell", for: indexPath) as! DepositsListCell
            cell.depositViewModel = viewModel.depositViewModelFor(indexPath: indexPath)
            return cell
        }
        
    }
    
    
}

class DepositsListCell : UITableViewCell {
    
    var depositViewModel : DepositViewModel? {
        didSet {
            amountLabel.text = depositViewModel?.amount
            descriptionLabel.text = depositViewModel?.description
            dateLabel.text = depositViewModel?.date
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

class DepositListTotalCell : UITableViewCell {
    @IBOutlet weak var totalDeposits: UILabel!
}

