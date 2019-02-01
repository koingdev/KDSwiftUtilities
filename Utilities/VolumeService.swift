//
//  VolumeService.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/01.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import MediaPlayer

final class VolumeService {
	
	private lazy var volumeView = MPVolumeView()
	private let maxVolume: Float = 1.0
	private(set) var defaultVolume: Float!
	private var isProgrammaticallyChange = false
	private var isDeviceActive = false
	
	func setDeviceActive(_ isActive: Bool) {
		isDeviceActive = isActive
	}
	
	init() {
		
		do {
			// First initialize default volume
			try AVAudioSession.sharedInstance().setActive(true)
			defaultVolume = AVAudioSession.sharedInstance().outputVolume
		} catch {
			dPrint("Cannot activates App’s audio session")
		}
		
		// Update default volume on change
		NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil, queue: OperationQueue.main) { [weak self] notification in
			guard let self = self else { return }
			guard let volume = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float else {
				dPrint("Cannot read volume value")
				return
			}
			// Device is active ?
			if self.isDeviceActive {
				// To prevent user can decrease the volume while using the App
				self.setVolumeToMax()
				return
			}
			
			if self.isProgrammaticallyChange {
				self.isProgrammaticallyChange.toggle()
			} else { // User press volume button ?
				self.defaultVolume = volume
				dPrint("Default volume is \(volume)")
			}
		}
	}
	
	deinit {
		do {
			try AVAudioSession.sharedInstance().setActive(false)
		} catch {
			dPrint("Cannot deactivates App’s audio session")
		}
		NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: Programmatically change volume
	
	func setVolume(to volume: Float) {
		isProgrammaticallyChange = true
		
		guard let slider = self.volumeView.subviews.filter({ $0 is UISlider }).first as? UISlider else { return }
		let hiddenView = UIView(frame: CGRect(x: -1000, y: 0, width: 0, height: 0))
		UIApplication.shared.keyWindow?.addSubview(hiddenView)
		hiddenView.addSubview(self.volumeView)
		
		Queue.runAfter(0.5) {
			slider.value = volume
			
			Queue.runAfter(1) {
				self.volumeView.removeFromSuperview()
				hiddenView.removeFromSuperview()
			}
		}
	}
	
	func setVolumeToDefault() {
		setVolume(to: defaultVolume)
	}
	
	func setVolumeToMax() {
		setVolume(to: maxVolume)
	}
	
}
