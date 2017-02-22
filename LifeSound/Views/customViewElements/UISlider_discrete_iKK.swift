//
//  UISlider_discrete_iKK.swift
//  iKK_Custom_UIElements
//
//  Created by Stephan Korner on 08.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import UIKit

// iKK-Custom: UISlider
//
// The user can set the following under the Attributes Inspector of Main.storyboard :
// - thumb-image (i.e. this is the image of the movable part of the Slider)
// - thumb-Highligted-image (i.e. when user presses thumb, it gets highlighted)
//
// URL: https://www.youtube.com/watch?v=86yf34Y24Uc
class UISlider_discrete_iKK: UISlider {
	
	var sectionNr: Int = 0
	var rowNr: Int = 0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	/* The answer is Interface Builder. When you drag an object onto a storyboard and configure it, Interface Builder serializes the state of that object on to disk, then deserialize it when the storyboard appears on screen. You need to tell Interface Builder how to do those. At the very least, if you don't add any new properties to your subclass, you can simply ask the superclass to do the packing and unpacking for you, hence the super.init(coder: aDecoder) call. */
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func draw(_ rect: CGRect) {
		
		self.setThumbImage(#imageLiteral(resourceName: "30ptSliderThumbNorm"), for: .normal)
		self.setThumbImage(#imageLiteral(resourceName: "30ptSliderThumbHigh"), for: .highlighted)
	}

}
