//
//  RealmService.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/9/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import RealmSwift

final class RealmService {
	
	private let realm: Realm!
	private var notificationToken: NotificationToken?
	
	init(realm: Realm = try! Realm()) {
		self.realm = realm
	}
	
	func observeDatabaseChanged(completion: @escaping () -> Void) {
		notificationToken = realm.observe { notification, realm in
			completion()
		}
	}
	
	func add(object: Object, update: Bool = false) {
		do {
			try realm.write {
				realm.add(object, update: update)
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
	
	func delete(object: Object) {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			Log.error("Cannot delete data from Realm")
		}
	}
	
	func deleteAll() {
		do {
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			Log.error("Cannot delete all data from Realm")
		}
	}
	
	deinit {
		notificationToken?.invalidate()
	}
	
}
