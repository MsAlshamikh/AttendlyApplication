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
    
    var section: String = ""
    var titleB: String = ""
    var name: String = ""
    var email: String = ""
    var adv: String = ""
    var lecturerId : String?
    
    @IBAction func whenPress(_ sender: UIButton) {
        print("now your exucetion absent // shamma")
    }
    
    
    
       let imageF = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2"),UIImage(named: "2")]
    
       

      //  my.courseName.image = imageF[indexPath.row]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("here course is ", WhatPressed)

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
                    
                    
                    stateAll.append(state)
                    dateAll.append(st)
                    timeAll.append(time)
                    self.tableView.reloadData()
                }
  //history here.
                
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
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        print("befor",stateAll.count)
        return stateAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my = tableView.dequeueReusableCell(withIdentifier: "newc") as! TableViewhistoryStu
        
        my.execution.isHidden = true
        
      //  my.state.text = stateAll[indexPath.row]
        if stateAll[indexPath.row] == "absent" {
            my.state.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            my.state.text = stateAll[indexPath.row]
            my.execution.isHidden = false
        }
       else if stateAll[indexPath.row] == "late" {
            my.state.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            my.state.text = stateAll[indexPath.row]
        }
        else if stateAll[indexPath.row] == "attend" {
             my.state.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
             my.state.text = stateAll[indexPath.row]
         }
        
        
      
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
