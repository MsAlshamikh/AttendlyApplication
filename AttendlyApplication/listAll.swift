//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit

class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nostudent: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
   
    @IBOutlet weak var currrentsectionpressed: UILabel!
    
    var nameStudent = [String]()
    var v: String = ""
    
    // @IBOutlet weak var courseLabel: UILabel!
   // @IBOutlet weak var sectionLabel: UILabel!
   // @IBOutlet weak var lecturerLabel: UILabel!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nostudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
            nostudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
            self.nostudent.text = "No Student Registered Yet "
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        
        
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: ""
                                        ));
        text1.append(NSAttributedString(string: v));
      currrentsectionpressed.attributedText = text1
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let my = tableView.dequeueReusableCell(withIdentifier: "cell")
        my?.textLabel?.text = nameStudent[indexPath.row]
     //   my?.imageView?.image = UIImage(named: "Att")
        
        my?.imageView?.image = UIImage(named: "girl")
        my?.textLabel?.text! += "                 "
          
          
       my?.textLabel?.text! += "0 %"
   //     my?.textLabel?.font = UIFont (name: my?.textLabel?.font.fontName , size:15)) // Change the font size as per your requirement

    //my?.textLabel!.font = UIFont(name: (my?.textLabel.font.fontName)! ?? );, size:15) // Change the font size as per your requirement

        return my!
    }
    
    
}
