//
//  RealmService.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/9/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import RealmSwift

protocol RealmOperation {
	
	var realm: Realm { get }
	var notificationToken: NotificationToken? { get set }
	
	func observeDatabaseChanged(completion: @escaping () -> Void)
	func write(object: Object, completion: () -> Void)
	func updateBlock(completion: () -> Void)
	func delete(object: Object, completion: () -> Void)
}

final class RealmService: RealmOperation {
	
	lazy var realm = try! Realm()
	var notificationToken: NotificationToken?
	
	func observeDatabaseChanged(completion: @escaping () -> Void) {
		notificationToken = realm.observe { notification, realm in
			completion()
		}
	}
	
	func write(object: Object, completion: () -> Void) {
		do {
			try realm.write {
				realm.add(object, update: false)
				completion()
			}
		} catch {
			Log.error("Cannot write data to Realm")
		}
	}
	
	func updateBlock(completion: () -> Void) {
		do {
			try realm.write {
				completion()
			}
		} catch {
			Log.error("Cannot update data to Realm")
		}
	}
	
	func delete(object: Object, completion: () -> Void) {
		do {
			try realm.write {
				realm.delete(object)
				completion()
			}
		} catch {
			Log.error("Cannot delete data from Realm")
			completion()
		}
	}
	
	deinit {
		notificationToken?.invalidate()
	}
	
}
