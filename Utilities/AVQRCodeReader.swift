//
//  AVQRCodeReader.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import AVFoundation

protocol CodeReader {
	func startReading(completion: @escaping (String) -> Void)
	func stopReading()
	var videoPreview: CALayer {get}
}

class AVQRCodeReader: NSObject {
	
	fileprivate(set) var videoPreview = CALayer()
	fileprivate var captureSession: AVCaptureSession?
	fileprivate var didRead: ((String) -> Void)?
	
	override init() {
		super.init()
		
		//Make sure the device can handle video
		guard let videoDevice = AVCaptureDevice.default(for: .video), let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
			return
		}
		
		//session
		captureSession = AVCaptureSession()
		
		//input
		captureSession?.addInput(deviceInput)
		
		//output
		let captureMetadataOutput = AVCaptureMetadataOutput()
		captureSession?.addOutput(captureMetadataOutput)
		captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
		//interprets qr codes only
		captureMetadataOutput.metadataObjectTypes = [.qr]
		
		//preview
		guard let captureSession = captureSession else { return }
		let captureVideoPreview = AVCaptureVideoPreviewLayer(session: captureSession)
		captureVideoPreview.videoGravity = .resizeAspectFill
		self.videoPreview = captureVideoPreview
	}
	
}

extension AVQRCodeReader: AVCaptureMetadataOutputObjectsDelegate {
	
	func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
						didOutput metadataObjects: [AVMetadataObject],
						from connection: AVCaptureConnection) {
		guard let readableCode = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
			let code = readableCode.stringValue else {
				return
		}
		
		//Vibrate the phone
		AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
		stopReading()
		
		didRead?(code)
	}
	
}

extension AVQRCodeReader: CodeReader {
	func startReading(completion: @escaping (String) -> Void) {
		self.didRead = completion
		captureSession?.startRunning()
	}
	func stopReading() {
		captureSession?.stopRunning()
	}
}
