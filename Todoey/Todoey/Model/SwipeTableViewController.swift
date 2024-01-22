
import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65.0
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        let editAction = SwipeAction(style: .destructive, title: "Edit") { (action, indexPath) in
            var textFieldCategory = UITextField()
            let alert = UIAlertController(title: "Edit Category", message: "", preferredStyle: .alert)
            
            let actionEditCategory = UIAlertAction(title: "Edit", style: .default) { (editAction) in
                self.editModel(at: indexPath, with: textFieldCategory)
            }
            let actionCancelEditCategory = UIAlertAction(title: "Cancel", style: .default) { (editAction) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addTextField { (alertTextField) in
                self.fillCategoryName(at: indexPath, with: alertTextField)
                textFieldCategory = alertTextField
            }
            
            alert.addAction(actionEditCategory)
            alert.addAction(actionCancelEditCategory)
            
            self.present(alert, animated: true, completion: nil)
        }

        deleteAction.image = UIImage(named: "delete-icon")
        editAction.image = UIImage(named: "edit-icon")
        editAction.backgroundColor = .gray

        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        //Update DataModel
    }
    func editModel(at indexPath: IndexPath, with textField: UITextField) {
        //Edit Category in DataModel
    }
    func fillCategoryName(at indexPath: IndexPath, with textField: UITextField) {
        //Fill the TextField with the current Category name
    }
}
