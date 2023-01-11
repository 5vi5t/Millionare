//
//  NestedTableView.swift
//  Millionare
//
//  Created by Константин on 02.01.2023.
//

import UIKit

class NestedTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
