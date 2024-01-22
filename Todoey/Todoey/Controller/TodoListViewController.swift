
import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    let realm = try! Realm()
    var item: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarConfig()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = item?[indexPath.row] {
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row)*0.4 / CGFloat(self.item!.count)) {
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todoItem = item?[indexPath.row] {
            do {
                try realm.write {
                    todoItem.done = !todoItem.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let actionAddItem = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving data,\(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:textField, queue: OperationQueue.main, using: { (notification) in
                actionAddItem.isEnabled = textField.text!.count > 0
                alertTextField.placeholder = "Add a value!"
            })
        }
        
        alert.addAction(actionAddItem)
        alert.addAction(cancelAction)
        actionAddItem.isEnabled = false
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func loadItems() {
        item = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemToDelete = self.item?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemToDelete)
                }
            } catch {
                print("Error deleting Item, \(error)")
            }
        }
    }
    
    //MARK: - NavigationBar Appearance
    
    func navBarConfig() {
        if let colourHex = selectedCategory?.colour {
            title = selectedCategory!.name
            
            if let navBarColour = UIColor(hexString: colourHex) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = navBarColour
                appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                appearance.shadowColor = nil
                
                navigationController?.navigationBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                
                searchBar.backgroundColor = navBarColour
                searchBar.searchTextField.backgroundColor = .white
            }
        }
    }
}

    //MARK: - SearchBar Delegate Methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        item = item?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
