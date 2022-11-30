//
//  Ext+TableView.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

extension UITableView {
    func sizeHeaderToFit(insets: CGFloat) {
        guard let headerView = tableHeaderView else { return }
        
        let newHeight = headerView.systemLayoutSizeFitting(CGSize(width: frame.width, height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        var frame = headerView.frame
        
        // avoids infinite loop!
        if newHeight.height != frame.height {
            frame.size.height = newHeight.height + insets
            headerView.frame = frame
            tableHeaderView = headerView
        }
    }
    
    func sizeFooterToFit() {
        guard let footerView = tableFooterView else { return }
        
        let newHeight = footerView.systemLayoutSizeFitting(CGSize(width: frame.width, height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        var frame = footerView.frame
        
        // avoids infinite loop!
        if newHeight.height != frame.height {
            frame.size.height = newHeight.height
            footerView.frame = frame
            tableFooterView = footerView
        }
    }
}
