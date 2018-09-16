//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by David Cate on 9/16/18.
//  Copyright © 2018 David Cate. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // Deleting Files
    // Add Two Outlets
    
    @IBOutlet weak var titleLabel: UILabel! // Existing Label for PRototype cell
    
    @IBOutlet weak var selectionImage: UIImageView! // Image View to display selection status when in edit mode.
    
    // Not labeled as private
    // Since we'll need to acces from View Controller class
    
    // Deleting and Selection Image
    // Add a Bool to determine if in editing mode or not
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing // Now when cell is set to editing the selection image is shown and when is not set to editing it is hidden
        }
    }
    
    // With info above, we can toggle between a checked and unchecked version
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
    
}
