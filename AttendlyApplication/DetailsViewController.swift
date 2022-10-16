//
//  DetailsViewController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 10/09/2022.
//

import UIKit
import FirebaseFirestore

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var lecturerLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var WhatPressed: String = ""
    var stateAll = [String]()
    var  dateAll = [String]()
    var timeAll = [String]()
    var haveAll = [String]()
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    var email: String = ""
    var adv: String = ""
    var lecturerId : String?
  var haveExec = false
  //  var buttonTappedAction : ((UITableViewCell) -> Void)?
   // var buttonTappedAction : (() -> Void)? = nil

    var Takesection = ""
    
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("now your exucetion absent // shamma")
    
   
    
    
       let imageF = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2")]
    
       

      //  my.courseName.image = imageF[indexPath.row]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Course Details"
        Takesection = courseLabel.text!
        
       print("Takesection is it  ", Takesection )

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 60
        //
        let db = Firestore.firestore()
        Task {
         
            let t_snapshot = try await db.collection("studentsByCourse").whereField("nameC", isEqualTo: WhatPressed).getDocuments()
           
         //   let st = t_snapshot.documents.first?.data()["st"] as! String
            
       //     print("st is :" , st)
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").whereField("EmailStudent", isEqualTo: Global.shared.useremailshare).getDocuments()
                print(snp.documents.count)
            //      let st = t_snapshot.documents.first?.data()["st"] as! String
                
                guard let st  = doc.get("st") as? String else { continue }

                print("st is :" , st)
                
                
                for studentDoc in snp.documents {
                    
                    
                    guard let state  = studentDoc.get("State") as? String else { continue }

                    print("state of student/",state)
                    
                    guard let time  = studentDoc.get("time") as? String else { continue }

                    print("time of student/",time)
                    
                    guard let have  = studentDoc.get("have") as? String else { continue }

                    print("time of student/",have)
                    
                    
//                    if await self.checkEexcuction(email: email, collection: "studentsByCourse", field: "StudentEmail") {
//
//
//                        print("student exists")
//                  self.performSegue(withIdentifier: "gotoStudents", sender: self)
//                        Global.shared.useremailshare = email
//                        print("this is the email amani: " + email)
//                        print("this is the global amani: " + Global.shared.useremailshare)
//                        // students view
//                    }
                  
                    stateAll.append(state)
                    dateAll.append(st)
                    timeAll.append(time)
                    haveAll.append(have)
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        } //task
        
        
        //
        
        
        
        
        
        
        let text1 = NSMutableAttributedString()
        text1.append(NSAttributedString(string: "Lecturer: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text1.append(NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue])) 
      
        //  avlabel.attributedText = underlineAttribute‏
      //  avlabel.attributedText = underlineAttribute‏
        
        //
        
        let text2 = NSMutableAttributedString()
        text2.append(NSAttributedString(string: "Section: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20/255, green: 108/255, blue: 120/255, alpha: 2), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 29)]));
        text2.append(NSAttributedString(string: section, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 14/255, green: 145/255, blue: 161/255, alpha: 2)]))
        
        courseLabel.text = titleB
   
        
        sectionLabel.attributedText = text2

        
        lecturerLabel.attributedText = text1
        let tg = UITapGestureRecognizer(target: self, action: #selector(lecturerNameTapped(_:)))
               lecturerLabel.isUserInteractionEnabled = true
               lecturerLabel.addGestureRecognizer(tg)
        //
        // Do any additional setup after loading the view.
    }
    
    func checkEexcuction(email: String, collection: String, field: String) async -> Bool {
       // print("what??")
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
            print("COUNT ", snapshot.count)
            print("not added")
            return snapshot.count != 0
        } catch {
            print(error.localizedDescription)
            print("added")
            return false
        }
        
        //return false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        print("befor",stateAll.count)
        return stateAll.count
    }
    

    
    @objc func didTapCellButton(sender: UIButton) {
   
      
        let tag = sender.tag
        let dateispreesed = dateAll[tag]

        print("wiich is now press?? number of row",tag)
        print("wiich is now press?? dateispreesed",dateispreesed)
        
        let stude = storyboard?.instantiateViewController(withIdentifier: "FormVC") as! FormVC
        stude.Takesection = WhatPressed
        stude.datePreesed = dateispreesed
        print("whatpressed ???" , WhatPressed)
        navigationController?.pushViewController(stude, animated: true)
        
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let currentCell = tableView.cellForRow(at: indexPath)! as! TableViewhistoryStu
//          let datePreesed = currentCell.date.text!
//        print("datePreesed",datePreesed)
//
//        let stude = storyboard?.instantiateViewController(withIdentifier: "FormVC") as! FormVC
//        stude.Takesection = WhatPressed
//        stude.datePreesed = datePreesed
//       // print("whatpressed ???" , WhatPressed)
//        navigationController?.pushViewController(stude, animated: true)
//
//
//         // my.execution.setTitle(vv,for: .normal)
//       //   my.execution.addTarget(self, action: #selector(didTapCellButton(sender:)),for: .touchUpInside)
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "newc") as! TableViewhistoryStu
        
        my.execution.isHidden = true
        my.havePending.isHidden = true
        
        
       my.execution.tag = indexPath.row
    my.execution.addTarget(self, action: #selector(didTapCellButton(sender:)),for: .touchUpInside)

      //  my.state.text = stateAll[indexPath.row]
        if stateAll[indexPath.row] == "absent" && haveAll[indexPath.row] == "f"  {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
            my.execution.isHidden = false
        }
        
        else if stateAll[indexPath.row] == "absent" && haveAll[indexPath.row] == "t"  {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
            my.havePending.isHidden = false
        }
       else if stateAll[indexPath.row] == "late"  {
            my.state.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.state.text = stateAll[indexPath.row]
        }
        else if stateAll[indexPath.row] == "attend"  {
             my.state.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        
//        if haveAll[indexPath.row] == "t"  {
//            my.havePending.isHidden = false
//            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
////
//        }

        
      
        my.date.text = dateAll[indexPath.row]
        my.time.text = timeAll[indexPath.row]

       my.imageNumber.image = imageF[indexPath.row]
        return my
    }
    
    
    
    
    @objc func lecturerNameTapped(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "si_courseDetailToLecturerProfile", sender: nil)
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "si_courseDetailToLecturerProfile" {
            if let vc = segue.destination as? LecturerProfileVC {
                vc.lecturerID = lecturerId;
            }
        }
    }
    
    
    
}
