//
//  AppCoordinator.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit



class AppCoordinator: Coordinator
{
    fileprivate let AUTHENTICATION_KEY: String  = "Authentication"
    fileprivate let LIST_KEY: String  = "Balances"

    var window: UIWindow
    var coordinators = [String:Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        if isLoggedIn {
            showBalances()
        } else {
            showAuthentication()
        }
    }
}



extension AppCoordinator: AuthenticationCoordinatorDelegate
{
    var isLoggedIn: Bool {
        return true;
    }
    
    func showAuthentication()
    {
        let authenticationCoordinator = AuthenticationCoordinator(window: window)
        coordinators[AUTHENTICATION_KEY] = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator: AuthenticationCoordinator)
    {
        coordinators[AUTHENTICATION_KEY] = nil
        showBalances()
    }
}


extension AppCoordinator: BalancesCoordinatorDelegate
{
    func showBalances()
    {
        let balanceCoordinator = BalancesCoordinator(window: window)
        coordinators[LIST_KEY] = balanceCoordinator
        balanceCoordinator.delegate = self
        balanceCoordinator.start()
    }
    
    func balancesCoordinatorDidFinish(BalancesCoordinator: BalancesCoordinator)
    {
        coordinators[LIST_KEY] = nil
    }
}

