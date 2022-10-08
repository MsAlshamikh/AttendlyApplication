//
//  listAll.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 25/02/1444 AH.
//

import UIKit
import FirebaseFirestore
class listAll: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var nostudent: UILabel!
    //@IBOutlet weak var tableview: UITableView!
    
   // @IBOutlet weak var nostudent: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet weak var nameSection: UILabel!
    
    @IBOutlet weak var zeroStudent: UILabel!
    
    
    var nameStudent = [String]()
    var emailStudent = [String]()
    var idStudent = [String]()
    var v: String = ""
    
     var percentagestu = [String]()
    
    var doubles = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     zeroStudent.isHidden = true

        print("what pressed is ")
        print(v)
        print("name of student")
        print(nameStudent)
        if ( nameStudent.count == 0 )
        {
        zeroStudent.isHidden = false
            print("no student")
            
         //   self.noC.text = "No courses \n registered!"
          self.zeroStudent.text = "No Student Registered Yet "
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
        nameSection.attributedText = text1
       
        // let d = Int(date.split(separator: "-")[0])!
        
      //  var spliting = percentagestu.split(separator: "%")
        
        doubles = percentagestu.compactMap(Double.init)
        print("doubles ",doubles )
        
      print("[percentage]",percentagestu)
        
        
       // var converDou = Double(percentagestu)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableviewControolerTableViewCell
      
        
        
        my.nostudent.text = nameStudent[indexPath.row]
        my.idStu.text = idStudent[indexPath.row]
        my.person.image = UIImage(named: "girl" )
        
        if doubles[indexPath.row]  >= 20 {    // less than or eqaul to 0
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
       else if doubles[indexPath.row]  >= 10 {    // less than or eqaul to 0
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
       else if doubles[indexPath.row] >= 0 {   //less than  or equal 7
            my.currrentsectionpressed.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            my.currrentsectionpressed.text = ""+String ( percentagestu[indexPath.row] + "%" ) }
        
        
       let emails = emailStudent[indexPath.row]
        
    
        print("befor task")
        print(emails)

        return my
    }
    

    
}
