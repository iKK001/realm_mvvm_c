//
//  MVVMCListViewController.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCBalancesViewController: UIViewController {
	
	@IBOutlet weak var label1Outlet: UILabel!
	@IBOutlet weak var label2Outlet: UILabel!
	
   var viewModel: BalancesViewModel? {
		willSet {
			viewModel?.viewDelegate = nil
		}
		didSet {
			viewModel?.viewDelegate = self
			refreshDisplay()
		}
	}
    
   var isLoaded: Bool = false
	
   func refreshDisplay()
   {
		if let viewModel = viewModel , isLoaded {
			self.label1Outlet.text = viewModel.entryAtIndex(0)?.category
			print("\(viewModel.entryAtIndex(0)?.idx)")
			if let entry = viewModel.entryAtIndex(0)?.idx {
				self.label2Outlet.text = "\(entry)"
			}
		} else {
            
		}
	}
    
	override func viewDidLoad()
	{
		super.viewDidLoad()
        
		isLoaded = true
		refreshDisplay();
	}
    
}

extension MVVMCBalancesViewController: BalancesViewModelViewDelegate
{
	func entriesDidChange(viewModel: BalancesViewModel)
	{
		
	}
}
