//
//  MainViewController.swift
//  Test Window View
//
//  Created by Robert Pugh on 2020-01-21.
//  Copyright © 2020 Robert Pugh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	static let styles: [UIStatusBarStyle] = [.darkContent, .lightContent]
	
	var styleIndex = 0
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return Self.styles[styleIndex % Self.styles.count]
	}
	
	private func updateStyle() {
		styleIndex += 1
		
		setNeedsStatusBarAppearanceUpdate()
	}
	
	private var timer: Timer?
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if timer == nil {
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
				self.updateStyle()
			}
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		if let timer = timer {
			timer.invalidate()
			self.timer = nil
		}
	}
	
	var overlayWindow: UIWindow?
	
	@IBAction func showOverlayWindow() {
		let window = UIWindow(frame: UIScreen.main.bounds)
		
		window.tintColor = UIApplication.shared.windows.first?.tintColor
		window.windowLevel = UIWindow.Level.statusBar
		
		window.isHidden = false
		
		let overlayViewController = storyboard!.instantiateViewController(identifier: "Overlay") as! OverlayViewController
		overlayViewController.onDismiss = { [weak self] in
			self?.overlayWindow = nil
		}
		
		overlayViewController.modalPresentationStyle = .overFullScreen
		
		window.rootViewController = overlayViewController
		
		overlayWindow = window
	}
	
}

