
import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let actionAddCategory = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
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
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
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
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving category, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching categories, \(error)")
        }
        tableView.reloadData()
    }
}
