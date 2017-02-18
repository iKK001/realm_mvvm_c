//
//  ListCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit
import RealmSwift

protocol BalancesCoordinatorDelegate: class
{
    func balancesCoordinatorDidFinish(BalancesCoordinator: BalancesCoordinator)
}

class BalancesCoordinator: Coordinator
{
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    weak var delegate: BalancesCoordinatorDelegate?
    var window: UIWindow
    var BalancesViewController: MVVMCBalancesViewController?
    
    func start()
    {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        BalancesViewController = storyboard.instantiateViewController(withIdentifier: "Balances") as? MVVMCBalancesViewController
        
        guard let BalancesViewController = BalancesViewController else { return }
        
        let viewModel =  MVVMCBalancesViewModel()
        viewModel.model = MVVMCBalancesModel()
        viewModel.coordinatorDelegate = self
        BalancesViewController.viewModel = viewModel
        window.rootViewController = BalancesViewController
    }
}

extension BalancesCoordinator: BalancesViewModelCoordinatorDelegate
{
    func balancesViewModelDidSelectData(_ viewModel: BalancesViewModel, data: DataEntry)
    {

    }
}


