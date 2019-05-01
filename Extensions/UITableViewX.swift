//
//  UITableViewX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
}

public extension UITableView {
    
    public func dequeueReusableCell<CellClass: UITableViewCell> (of class: CellClass.Type,
                                                                 for indexPath: IndexPath,
                                                                 configure: (CellClass) -> Void) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.identifier, for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
            return typedCell
        }
        return cell
    }
	
	enum TableViewAction {
		case insert, delete, reload
	}
	
	public func performAction(_ action: TableViewAction, at indexPath: IndexPath) {
		DispatchQueue.main.async {
			self.beginUpdates()
			switch action {
			case .insert:
				self.insertRows(at: [indexPath], with: .fade)
			case .delete:
				self.deleteRows(at: [indexPath], with: .fade)
			case .reload:
				self.reloadRows(at: [indexPath], with: .fade)
			}
			self.endUpdates()
		}
	}
    
}
