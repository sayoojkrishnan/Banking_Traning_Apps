//
//  HomeTabBarController.swift
//  BankingApp
//
//  Created by Sayooj Krishnan  on 15/07/21.
//
import DepositsFramework
import UIKit

class HomeTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 2
        
        let deposit = DepositModuleBuilder.build()
        deposit.tabBarItem.title = "Deposit"
        deposit.tabBarItem.image = UIImage(systemName: "square.and.arrow.down.on.square")
        
        let zelle = Zelle()
        zelle.tabBarItem.title = "Zelle"
        zelle.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        
        let transfer = Transfer()
        transfer.tabBarItem.title = "Tranfer"
        transfer.tabBarItem.image = UIImage(systemName: "arrowshape.bounce.forward")
        
        let account = Account()
        account.tabBarItem.title = "Account"
        account.tabBarItem.image = UIImage(systemName: "house")
        
        let more = More()
        more.tabBarItem.title = "Account"
        more.tabBarItem.image = UIImage(systemName: "list.dash")
        
        viewControllers = [zelle,transfer,deposit,account,more]
        
    }
    
    
  
    
}


class Zelle : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

class Transfer : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

class Account : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
}

class More : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
