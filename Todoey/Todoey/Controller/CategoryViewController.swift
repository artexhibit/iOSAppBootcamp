
import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var category: Results<Category>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.tableHeaderView = UIView()
    }
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let actionAddCategory = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create category"
            textField = alertTextField
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:textField, queue: OperationQueue.main, using: { (notification) in
                actionAddCategory.isEnabled = textField.text!.count > 0
            })
        }
        
        alert.addAction(actionAddCategory)
        alert.addAction(cancelAction)
        actionAddCategory.isEnabled = false
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = category?[indexPath.row] {
            cell.textLabel?.text = category.name
            if let categoryColour = UIColor(hexString: category.colour) {
                cell.backgroundColor = categoryColour
                cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            }
        }
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        category = realm.objects(Category.self)
        tableView.reloadData()
    }

    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = self.category?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete.items)
                    self.realm.delete(categoryToDelete)
                }
            } catch {
                print("Error deleting the category, \(error)")
            }
        }
        navBarConfig()
    }
    
    //MARK: - Fill Current Category name into UITextField
    
    override func fillCategoryName(at indexPath: IndexPath, with textField: UITextField) {
        if let text = self.category?[indexPath.row].name {
            textField.text = text
        }
    }
    
    //MARK: - Edit Data from Swipe
    
    override func editModel(at indexPath: IndexPath, with textField: UITextField) {
        if let newCategoryName = textField.text {
            do {
                try self.realm.write {
                    self.category?[indexPath.row].name = newCategoryName
                    tableView.reloadData()
                }
            } catch {
                print("Error editing the category, \(error)")
            }
        }
    }
    
    //MARK: - NavigationBar Appearance
    
    func navBarConfig() {
        if let navBarColour = UIColor(hexString: category![0].colour) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navBarColour
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
            appearance.shadowColor = nil
            
            navigationController?.navigationBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

