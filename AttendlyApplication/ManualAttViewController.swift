//
//  ManualAttViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import UIKit

class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableview: UITableView!
    
    
    var nameStudent = [String]()
  //  var emailStudent = [String]()
    var stateSt = [String]()
    var v: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //  nostudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
      //      nostudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
       //     self.nostudent.text = "No Student Registered Yet "
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
      //  nameSection.attributedText = text1
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
      //  my?.textLabel?.text = nameStudent[indexPath.row]
    //my?.imageView?.image = UIImage(named: "girl")
        
        
//        my.nostudent.text = nameStudent[indexPath.row]
//        my.idStu.text = idStudent[indexPath.row]
//        my.person.image = UIImage(named: "girl" )
        my.state.text =  nameStudent[indexPath.row]
        my.name.text = stateSt[indexPath.row]
      //  my.currrentsectionpressed.text = percentage
        //emailStudent[indexPath.row] the array of emails go to the function to calclate
        
        
        
   //     my.currrentsectionpressed.text = //this for you shamma
        
        
    
        
      

        
    

        return my
    }
    
    
}
