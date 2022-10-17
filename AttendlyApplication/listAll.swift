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
    var sectionName = ""
    var SingleEmail: String = ""
    var SingleName: String = ""
    
    let db = Firestore.firestore()
    
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
        sectionName = nameSection.text!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
                let currentCell = tableView.cellForRow(at: indexPath)! as! customTableviewControolerTableViewCell   // THE SOLUTION
                let v = currentCell.idStu!.text!
                print("is preeesed", v)
        
        Task{
               let snapshot = try await db.collection("Unistudent").whereField("studentID", isEqualTo: v).getDocuments()
               guard let EmailStu = snapshot.documents.first?.get("StudentEmail") as? String else { return }
               guard let NameStu = snapshot.documents.first?.get("Fullname") as? String else { return }
               
            
               let stude = storyboard?.instantiateViewController(withIdentifier: "StudentVC") as! StudentVC
        
               print("Email  ssssss" , EmailStu )
//            let text1 = NSMutableAttributedString()
//            text1.append(NSAttributedString(string: "id: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
//            text1.append(NSAttributedString(string: v, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
//
////            let text2 = NSMutableAttributedString()
////            text2.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
////            text2.append(NSAttributedString(string: sectionName, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
//
//            let text3 = NSMutableAttributedString()
//            text3.append(NSAttributedString(string: "name: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
//            text3.append(NSAttributedString(string: NameStu, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
//
//            let text4 = NSMutableAttributedString()
//            text4.append(NSAttributedString(string: "email: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
//            text4.append(NSAttributedString(string: EmailStu, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue]))
            
              var arrAll = NameStu.split(separator: "-")
               print("TRRRRYYY SPLLLIITTT", arrAll)
               stude.v = v // id student
               stude.sectionName = sectionName
//               stude.SingleName = NameStu
//               stude.SingleEmail = EmailStu
            stude.FullEmail = EmailStu 
            stude.SingleName = String(arrAll[0])
            stude.SingleEmail = String(arrAll[1])
            
               print("here course is ", sectionName)
       
        
        navigationController?.pushViewController(stude, animated: true)
        }
    
    }
    

    
}
