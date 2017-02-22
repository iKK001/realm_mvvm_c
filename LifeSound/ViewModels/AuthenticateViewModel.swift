//
//  AuthenticateViewModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//


import Foundation


protocol AuthenticateViewModelViewDelegate: class
{
    func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
    func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
}


protocol AuthenticateViewModelCoordinatorDelegate: class
{
    func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel)
}


protocol AuthenticateViewModel
{
    var model: AuthenticateModel? { get set }
    var viewDelegate: AuthenticateViewModelViewDelegate? { get set }
    var coordinatorDelegate: AuthenticateViewModelCoordinatorDelegate? { get set}
    
    // Email and Password
    var email: String {get set}
    var password: String {get set}
    
    // Submit
    var canSubmit: Bool { get }
    func submit()
    
    // Errors
    var errorMessage: String { get }
}

