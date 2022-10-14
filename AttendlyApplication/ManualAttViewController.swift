//
//  ManualAttViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import Firebase
import UIKit

class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {

   // @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var nameCourse: UILabel!
    
    @IBOutlet weak var cuurentDate: UILabel!
    
    var nameStudent = [String]()
   
    var filterName : [String]!
    
    
  //  var emailStudent = [String]()
    var stateSt = [String]()
    var emailSt = [String]()
    
    var idstudent = [String]()
    var serialNumber = [String]()
    
    var v: String = ""
    var networking: Bool = false
    
    
    let db = Firestore.firestore()
    
    let refreshControl = UIRefreshControl()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Attend Manually"
        
        
        filterName = nameStudent
        
        //search.delegate = self
     //  nostudent.isHidden = true
       // self.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.339857161, green: 0.69448632, blue: 0.8468429446, alpha: 1)
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
                   // guard let ser = studentDoc.get("SerialNum") as? String else { continue }
                    
                    print("name of student/",name)
                    print("state of student/",state)
                    print("email of student/",email)
                    print("id of student/",id)
                    print("serial N of student/",id)
                    

                    
                  nameStudent.append(name)
                   stateSt.append(state)
                    emailSt.append(email)
                   idstudent.append(id)
                  // serialNumber.append(ser)
                    self.refreshControl.endRefreshing()
                    self.tableview.reloadData()
                    
                    
                }
                        
                
        
            
            }
            
        }
        
    }
    
    @IBAction func AttendPress(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath)
   
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable

        
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
           //     my.AttendToabsent.isHidden = false
                
              
                tableView.reloadData()
            //  cell.backgroundColor = UIColor.black
                networking = false
            }
        }
        
        //
        
        if state == "attend"  {
            
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
                
                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
                
                print("done")
              
                stateSt[indexPath.row] = "absent"
                
              
                tableView.reloadData()
            //  cell.backgroundColor = UIColor.black
                networking = false
            }
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       // let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
        if let my = tableView.cellForRow(at: indexPath) as? customAttendTable {
        //    my.AttendToabsent.isHidden = true
            print("is didselct???")
                }
        print("???")
      //  my.AttendToabsent.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("enter")
        return filterName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
        
      //  my.AttendToabsent.isHidden = true

        my.state.text =  nameStudent[indexPath.row]
        
//        if (stateSt[] == "attend"){
//
//        }

        if stateSt[indexPath.row] == "attend" {
            my.name.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         //   my.AttendToabsent.isHidden = true
        }
        else if stateSt[indexPath.row] == "late" {
            my.name.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
               
        }
        else if stateSt[indexPath.row] == "absent" {
            
            my.name.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      //      my.AttendToabsent.isHidden = false
        }
        else if stateSt[indexPath.row] == "pending" {
            my.name.textColor =  #colorLiteral(red: 0.6745098039, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
        //    my.AttendToabsent.isHidden = true
        }

       // my.backgroundColor = stateSt[indexPath.row] == "attend" ? .red :
        my.name.text = stateSt[indexPath.row]
        my.idStudent.text = idstudent[indexPath.row]
       // my.serialNnumber.text = serialNumber[indexPath.row]
        my.img.image = UIImage(named: "girl2" )
        
     
    
        
      

        
    

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
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        filterName = []
////        if searchText == "" {
////            filterName = nameStudent
////        }
////        else{
////        for name in nameStudent{
////            if name.lowercased().contains(searchText.lowercased()){
////                print("yee")
////                filterName.append(name)
////            }
////        }
////        }
//        filterName = searchText.isEmpty ? nameStudent : nameStudent.filter({(dataString: String) -> Bool in
//                // If dataItem matches the searchText, return true to include it
//                return dataString.range(of: searchText, options: .caseInsensitive) != nil
//            })
//
//
//        self.tableview.reloadData()
//    }
    
    
    
}
