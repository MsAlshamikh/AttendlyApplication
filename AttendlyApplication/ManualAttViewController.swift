//
//  ManualAttViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import Firebase
import UIKit

class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var nameCourse: UILabel!
    
    @IBOutlet weak var cuurentDate: UILabel!
    
    var nameStudent = [String]()
  //  var emailStudent = [String]()
    var stateSt = [String]()
    var emailSt = [String]()
    
    var idstudent = [String]()
    var serialNumber = [String]()
    
    var v: String = ""
    var networking: Bool = false
    
    
    let db = Firestore.firestore()
    
    let refreshControl = UIRefreshControl()
    
    
    
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
        }
        tableview.delegate = self
        tableview.dataSource = self
        //tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = 50
       // navigationController?.navigationItem.title = "ss"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableview.addSubview(refreshControl)
        
        
        
     let text1 = NSMutableAttributedString()
       text1.append(NSAttributedString(string: ""
                                  ));
        text1.append(NSAttributedString(string: v));
      //  nameSection.attributedText = text1
        
        let currentDateTime = Date()
        let formaater = DateFormatter()
        formaater.timeStyle = .medium
        formaater.dateStyle = .long
        let dataTimeString = formaater.string(from: currentDateTime)
        
        nameCourse.text = v
        
    cuurentDate.text = dataTimeString
    }
    
    @objc func refresh(_ sender: AnyObject) {
        let date = Date()
        let calunder = Calendar.current
        let day = calunder.component(.day , from: date)
        let month = calunder.component(.month , from: date)
        let year = calunder.component(.year , from: date)
        let thed = "\(day)-\(month)-\(year)"
        print(thed)
       // let v =   sender.titleLabel?.text
        
       // print(v!)
        Task
        {
         
            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments()
           
            let currentTime = getCurrentTime()
            print(currentTime)
            let currentTimeSplit = currentTime.split(separator: ":")
            let timeHourct = currentTimeSplit[0]
            //let timeMinct = Int(currentTimeSplit[1])
          //  let timeMinct2 = Int(timeMinct ?? 0)
            print("hour current",timeHourct )
            
            let endTimeF = t_snapshot.documents.first?.data()["endTime"] as! String
            
           
        print(t_snapshot.documents.count)
//            var studentArry = [String]()  //name
//            var stateArray = [String]()
//            var emailArray = [String]()
//            var idArray = [String]()
//            var seArray = [String]()
            for doc in t_snapshot.documents {
               let documentID = doc.documentID
                  let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
            
               
                
                print("here")
                print(snp.documents.count)
                print(snp.documents)
                
                nameStudent.removeAll()
                stateSt.removeAll()
                emailSt.removeAll()
                serialNumber.removeAll()
                idstudent.removeAll()
                for studentDoc in snp.documents {
                    guard let state  = studentDoc.get("State") as? String else { continue }
                    guard let email  = studentDoc.get("EmailStudent") as? String else { continue }
                    guard let name  = studentDoc.get("name") as? String else { continue }
                    guard let id = studentDoc.get("id") as? String else { continue }
                    guard let ser = studentDoc.get("SerialNum") as? String else { continue }
                    
                    print("name of student/",name)
                    print("state of student/",state)
                    print("email of student/",email)
                    print("id of student/",id)
                    print("serial N of student/",id)
                    

                    
                  nameStudent.append(name)
                   stateSt.append(state)
                    emailSt.append(email)
                   idstudent.append(id)
                   serialNumber.append(ser)
                    self.refreshControl.endRefreshing()
                    self.tableview.reloadData()
                    
                    
                }
                        
                
        
            
            }
            
        }
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//    Task{
//      do{
//           try await db.collection("studentsByCourse").addSnapshotListener { snapshot, error in
//                    if let error = error {
//                        print("error")
//                        return
//                    }
//                    for document in snapshot!.documents{
//                        print("doc: \(document.data())")
//                        let documentID = document.documentID
//                        let snp = await self.db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
//
//
//
//                         print("here")
//                         print(snp.documents.count)
//                         print(snp.documents)
//
//                         for studentDoc in snp.documents {
//                             guard let state  = studentDoc.get("State") as? String else { continue }
//                             guard let email  = studentDoc.get("EmailStudent") as? String else { continue }
//                             guard let name  = studentDoc.get("name") as? String else { continue }
//                             guard let id = studentDoc.get("id") as? String else { continue }
//                             guard let ser = studentDoc.get("SerialNum") as? String else { continue }
//
//                             print("name of student/",name)
//                             print("state of student/",state)
//                             print("email of student/",email)
//                             print("id of student/",id)
//                             print("serial N of student/",id)
//
//
//                             studentArry.append(name)
//                             stateArray.append(state)
//                             emailArray.append(email)
//                             idArray.append(id)
//                             seArray.append(ser)
//
//                    }
//                }  //for
//    }
//        //}
//      } catch{
//          print("error is ")
//      }
//    }
//    } //fun
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
        let state = stateSt[indexPath.row]
        
    
        
        if state == "absent" {
            
            if networking {
                return
            }
            let email = emailSt[indexPath.row]
            
            
            
            let date = Date()
            let calunder = Calendar.current
            let day = calunder.component(.day , from: date)
            let month = calunder.component(.month , from: date)
            let year = calunder.component(.year , from: date)
            let thed = "\(day)-\(month)-\(year)"
            Task {
               
            //    let db = Firestore.firestore()
                
                networking = true
                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
                
                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
                
                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "attend"], merge: true)
                
                print("done")
                stateSt[indexPath.row] = "attend"
                tableView.reloadData()
            //  cell.backgroundColor = UIColor.black
                networking = false
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return nameStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
        
        

        my.state.text =  nameStudent[indexPath.row]
        
//        if (stateSt[] == "attend"){
//
//        }

        if stateSt[indexPath.row] == "attend" {
                 my.backgroundColor = #colorLiteral(red: 0.5591548681, green: 0.6860862374, blue: 0.4911993146, alpha: 1)               }
        else if stateSt[indexPath.row] == "late" {
            my.backgroundColor = #colorLiteral(red: 0.975443542, green: 0.8380891085, blue: 0.5318054557, alpha: 1)
               
        }
        else if stateSt[indexPath.row] == "absent" {
            my.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.462745098, blue: 0.3843137255, alpha: 1)
        }
        else if stateSt[indexPath.row] == "pending" {
            my.backgroundColor =  #colorLiteral(red: 0.6745098039, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
        }

       // my.backgroundColor = stateSt[indexPath.row] == "attend" ? .red :
        my.name.text = stateSt[indexPath.row]
        my.idStudent.text = idstudent[indexPath.row]
        my.serialNnumber.text = serialNumber[indexPath.row]
        
        
    
        
      

        
    

        return my
    }
    
    func getCurrentTime() -> String{

        let formater = DateFormatter()

        formater.dateFormat = "HH:mm"
        let dateString =  formater.string(from: Date())
        print("after formating")
        print(dateString)
        return dateString

        }
    
    @IBAction func unwind(segue: UIStoryboardSegue ){
        
    }
    
}
