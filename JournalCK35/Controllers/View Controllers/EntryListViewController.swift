//
//  EntryListViewController.swift
//  JournalCK35
//
//  Created by Alex Lundquist on 8/17/20.
//

import UIKit

class EntryListViewController: UIViewController {
    
    @IBOutlet weak var entryTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        entryTableView.delegate = self
        entryTableView.dataSource = self
        DispatchQueue.main.async {
            EntryController.sharedInstance.fetchAllEntries { (result) in
                switch result {
                case .success(let entries):
                    guard let entries = entries else { return }
                    EntryController.sharedInstance.entries = entries
                    DispatchQueue.main.async {
                        self.entryTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        entryTableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Setting Custom Back Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back to Entries", style: .plain, target: nil, action: nil)
        if segue.identifier == "toDetailVC" {
            guard let indexPath = entryTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EntryDetailViewController else { return }
            let entryToSend = EntryController.sharedInstance.entries[indexPath.row]
            destinationVC.entry = entryToSend
        }
    } //End of Segue
} //End of Class


extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EntryController.sharedInstance.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entryTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.sharedInstance.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timeStamp.formateDate()
        return cell
    }
}
