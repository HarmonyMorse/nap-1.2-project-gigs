//
//  GigsTableViewController.swift
//  gigs
//
//  Created by Harm on 5/5/23.
//

import UIKit

class GigsTableViewController: UITableViewController {

    let gigController = GigController()
    let dateFormatter = DateFormatter()
    
    var gigsLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if gigController.bearer?.token == nil {
//            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
//        }
        
        gigController.getGigs { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.gigController.gigs = success
                    self.tableView.reloadData()
                case .failure(let failure):
                    fatalError("SKJHEDKUSDHFLIUSHDF: \(failure)")
                }
            }
        }
        gigsLoaded = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gigController.gigs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gigsCell", for: indexPath)
        
//        var content = cell.defaultContentConfiguration()
//        content.text = gigController.gigs[indexPath.row].title
        cell.textLabel?.text = gigController.gigs[indexPath.row].title
        
        dateFormatter.dateStyle = .short
        
        let due = dateFormatter.string(from: gigController.gigs[indexPath.row].dueDate)
//        content.secondaryText = due
        cell.detailTextLabel?.text = due
        

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "LoginViewModalSegue" {
            // inject dependencies
            if let loginVC = segue.destination as? LoginViewController {
//                loginVC.apiController = apiController
                loginVC.gigController = gigController
            }
        } else if segue.identifier == "ShowGigFromAdd" {
            if let detailVC = segue.destination as? GigDetailViewController {
                detailVC.gigController = gigController
            }
        } else if segue.identifier == "ShowGigFromCell" {
            if let detailVC = segue.destination as? GigDetailViewController {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                let selectedGig = gigController.gigs[indexPath.row]
                detailVC.gigController = gigController
                detailVC.gig = selectedGig
            }
        }
    }
    
/*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "DetailSegue", let indexPath = tableView.indexPathForSelectedRow {
     let selectedGig = items[indexPath.row] // Assuming 'items' is your data source array
     if let detailViewController = segue.destination as? DetailViewController {
         detailViewController.gig = selectedGig
     }
 }
}
*/
}
