//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit

class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
   
    
    var nameStudent = [String]()
    // @IBOutlet weak var courseLabel: UILabel!
   // @IBOutlet weak var sectionLabel: UILabel!
   // @IBOutlet weak var lecturerLabel: UILabel!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("now is try")
        print(nameStudent)
        tableview.delegate = self
        tableview.dataSource = self
        
        navigationController?.navigationItem.title = "ss"
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "cell")
        my?.textLabel?.text = nameStudent[indexPath.row]
        return my!
    }
    
    
}
