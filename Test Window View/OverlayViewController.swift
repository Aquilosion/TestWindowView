//
//  OverlayViewController.swift
//  Test Window View
//
//  Created by Robert Pugh on 2020-01-21.
//  Copyright © 2020 Robert Pugh. All rights reserved.
//

import UIKit

final class OverlayViewController: UIViewController {
	
	var proxy: UIViewController?
	
	required init?(coder: NSCoder) {
		self.proxy = UIApplication.shared.delegate?.window??.rootViewController
		
		super.init(coder: coder)
	}
	
	override var childForStatusBarStyle: UIViewController? {
		return proxy?.childForStatusBarStyle ?? proxy
	}
	
	override var childForStatusBarHidden: UIViewController? {
		return proxy?.childForStatusBarHidden ?? proxy
	}
	
	var onDismiss: (() -> ())?
	
	@IBAction func dismiss() {
		onDismiss?()
	}
	
}
