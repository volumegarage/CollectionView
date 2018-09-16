//
//  ViewController.swift
//  CollectionView
//
//  Created by David Cate on 9/15/18.
//  Copyright © 2018 David Cate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    
    // DELETING - NEED TO DISABLE ADD BUTTON AND CREATE OUTLET TO CONTROL THE BOTTON
    @IBOutlet private weak var addButton: UIBarButtonItem?
    
    // CUSTOMIZING COLLECTION VIEWS
    // Step 3
    // Create an IBOutlet to refer to collection view from the Storyboard
    @IBOutlet private weak var collectionView: UICollectionView!
    // Hook up inside main storyboard control drag yellow circle onto connect outlet
    // Now you can refer to this from anywhere in the CollectionView
    
    
    

    

    
    // Step 2
    // Set a variable with an array of strings
    var collectionData = ["1 🏆", "2 🐸", "3 🍩","4 😸","5 🤡","6 👾","7 👻","8 🙆🏼‍♀️","9 🎸","10 ☠︎","11 🐯", "12 💩" ]
    
    // Setup Action item for Delete Button
    @IBAction func deleteSelected() {
        // Remove only selected cells for deletion
        // Find index path for all cells selected for deletion
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items {
                collectionData.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
            navigationController?.isToolbarHidden = true // Hides tool bar after deletion.
        }
    }
    
    // Setup Add Item
    @IBAction func addItem() {
        collectionView.performBatchUpdates({
            for _ in 0..<2 {
                let text = "\(collectionData.count + 1) 🐱"
                collectionData.append(text)
                let index = IndexPath(row: collectionData.count - 1, section: 0)
                collectionView.insertItems(at: [index])
            }
        }, completion: nil)
    }
    
    @objc func refresh() {
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Tell CollectionView how many rows to have.
        
        let width = (view.frame.size.width - 20) / 3 // Substracts spacing
        // width of frame size divided by 3
        
        // Set item size - store reference to underlying layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        // This CollectionFlowLayout has item size property
        // Now we haev item size...
        layout.itemSize = CGSize(width: width, height: width)
        
        // Refresh Control
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refresh
        // Edit
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Hide toolbar on initial load
        navigationController?.isToolbarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let dest = segue.destination as? DetailViewController,
                let index = sender as? IndexPath {
                dest.selection = collectionData[index.row]
            }
        }
    }
    
    // DELETING ITEMS - OVERRIDE THE SETEDITING FUNCTION TO SET EDITING MODE
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // Set up Editing Toolbar on bottom
//        navigationController?.isToolbarHidden = false
        deleteButton.isEnabled = editing
        addButton?.isEnabled = !editing // Disables Add Item Button when editing
        
        // DELETE ITEMS - Allow multiple cell selection
        collectionView.allowsMultipleSelection = editing
        
        // DELETING ITEMS - Grab all visible cells and select visible properties to current state.
        
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
        
        if !editing {
            navigationController?.isToolbarHidden = true // Hide tool bar
        }
        
    }
    // Calls Set Editing for SuperClass
    
 
    
}

// Step One for Adding Collection View
// Add Extension for Delegate and Data Source

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Show how many items to display in array
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create instance of cell to display data you want
        // Create cell instance and return it.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        // Finally - use collection data to populate the cell data with some text.
//        if let label = cell.viewWithTag(100) as? UILabel {
            cell.titleLabel.text = collectionData[indexPath.row]
//        }
        
        // Set the cell property
        cell.isEditing = isEditing
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let text = collectionData[indexPath.row]
//        print("Selected: \(text)")
        
        // Perform Segue ONLY if in Editing Mode
        
        if !isEditing {
            performSegue(withIdentifier: "DetailSegue", sender: indexPath)
        } else {
            navigationController?.isToolbarHidden = false // Showing Toolbar at bottom
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems,
                selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }
    
    
}

