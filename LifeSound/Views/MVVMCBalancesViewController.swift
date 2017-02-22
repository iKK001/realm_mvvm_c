//
//  MVVMCListViewController.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit

class MVVMCBalancesViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var historyView: UIView!
	@IBOutlet weak var historyPickerView: CustomBalanceHistoryPickerView!
	
	var pickerDataSource = ["White", "Red", "Green", "Blue"]
	
   var viewModel: BalancesViewModel? {
		willSet {
			self.viewModel?.viewDelegate = nil
		}
		didSet {
			self.viewModel?.viewDelegate = self
			self.refreshDisplay()
		}
	}
    
   var isLoaded: Bool = false
	
   func refreshDisplay()
   {
		if let viewModel = viewModel , isLoaded {
			self.title = viewModel.title
		} else {
			self.title = ""
		}
	}
    
	override func viewDidLoad()
	{
		super.viewDidLoad()
				
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.historyPickerView.dataSource = self;
		self.historyPickerView.delegate = self;
		
		self.isLoaded = true
		self.refreshDisplay();
	}
    
}

extension MVVMCBalancesViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		
		if let viewModel = self.viewModel {
			return viewModel.numberOfSectionsFromEntries
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return self.viewModel?.sectionsTitlesFromEntries[section]
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if let viewModel = self.viewModel {
			return viewModel.numberOfRowsInSectionFromEntries(section)
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! CustomBalanceEntryTableViewCell

		// cell can't be selected
		cell.selectionStyle = .none
		cell.entrySliderDataEntry = self.viewModel?.entryAtSectionAndRow(indexPath.section, indexPath.row)
		cell.mySlider.sectionNr = indexPath.section
		cell.mySlider.rowNr = indexPath.row

		cell.cellDelegate = self

		return cell
	}
	
// selection of cell not used	
//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//	{
//		viewModel?.useEntryAtIndex((indexPath as NSIndexPath).row)
//	}
}

extension MVVMCBalancesViewController: BalancesViewModelCellDelegate {
	
	func didSliderValueChanged(_ sectionNr: Int, _ rowNr: Int, value: Float) {
		
		self.viewModel?.updateViewModelAtIndex(sectionNr, rowNr, value)
	}
}

extension MVVMCBalancesViewController: BalancesViewModelViewDelegate {
	
	func entriesWereAdded(viewModel: BalancesViewModel)
	{
		print("new entries in model")
	}
}

//MARK: - UIPickerView extension
extension MVVMCBalancesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	
	//MARK: UIPickerViewDataSource methods
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.pickerDataSource.count;
	}
	
	//MARK: - UIPickerViewDelegate methods
//	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//	}
//	
//	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return self.pickerDataSource[row]
	}
	
//	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//	}
//	
//	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if(row == 0) {
			self.view.backgroundColor = UIColor.white
		}
		else if(row == 1) {
			self.view.backgroundColor = UIColor.red
		}
		else if(row == 2) {
			self.view.backgroundColor =  UIColor.green
		}
		else {
			self.view.backgroundColor = UIColor.blue
		}
	}
	
}
