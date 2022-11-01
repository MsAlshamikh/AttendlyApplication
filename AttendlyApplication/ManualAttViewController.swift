//
//  ManualAttViewController.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import Firebase
import UIKit
import SwiftUI

class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource ,UIPickerViewDelegate , UIPickerViewDataSource {
    
    // @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var nameCourse: UILabel!
    
    @IBOutlet weak var cuurentDate: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var nameStudent = [String]()
    @IBOutlet weak var noStudentsFoundLabel: UILabel!
    
    var filterName : [String]!
    var picker :String = ""
    
    //  var emailStudent = [String]()
    var stateSt = [String]()
    var emailSt = [String]()
    
    var idstudent = [String]()
    var serialNumber = [String]()
    
    var v: String = ""
    var networking: Bool = false
    
    let StudentStatus = ["absent" , "late" , "attend"]
    var whatPick = "attend"
    
//@IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // Data structure to hold student information for the Table View
    var tableData = [(String, String, String, String)]()
    var filteredTableData = [(String, String, String, String)]()
    
    let db = Firestore.firestore()
    
    let refreshControl = UIRefreshControl()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Attend Manually"
        
        searchBar.delegate = self
        
        pickerView.isHidden = true
        
        nameStudent.enumerated().forEach { index, name in
            tableData.append((name, idstudent[index], stateSt[index], serialNumber[index]))
        }
        self.filteredTableData = tableData
        
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
                    guard let SerialNum = studentDoc.get("SerialNum") as? String else { continue }
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
                    serialNumber.append(SerialNum)
                    // serialNumber.append(ser)
                }
                tableData = []
                nameStudent.enumerated().forEach { index, name in
                    tableData.append((name, idstudent[index], stateSt[index], serialNumber[index]))
                }
                self.filteredTableData = tableData
                
                self.refreshControl.endRefreshing()
                self.tableview.reloadData()
            }
            
        }
        
    }
    
    @IBAction func AttendPress(_ sender: UIButton) {
    }
    
    var selectedEmail = ""
    var selectedrow = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath)
   
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable

        pickerView.isHidden = false

        
      tableView.deselectRow(at: indexPath, animated: true)
//        let state = stateSt[indexPath.row]
        
        pickerView.delegate = self
        pickerView.dataSource = self
    
        
        selectedEmail = emailSt[indexPath.row]
        selectedrow = indexPath.row
        
        
            
//
//            let date = Date()
//            let calunder = Calendar.current
//            let day = calunder.component(.day , from: date)
//            let month = calunder.component(.month , from: date)
//            let year = calunder.component(.year , from: date)
//            let thed = "\(day)-\(month)-\(year)"
//            Task {
//
//            //    let db = Firestore.firestore()
//
//                networking = true
//                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
//
//                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
//
//                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "attend"], merge: true)
//
//                print("done")
//                stateSt[indexPath.row] = "attend"
//           //     my.AttendToabsent.isHidden = false
//
//
//                tableView.reloadData()
//            //  cell.backgroundColor = UIColor.black
//                networking = false
//            }
//        }
//
//        //
//
//        if state == "attend"  {
//
//            if networking {
//                return
//            }
//            let email = emailSt[indexPath.row]
//
//
//
//            let date = Date()
//            let calunder = Calendar.current
//            let day = calunder.component(.day , from: date)
//            let month = calunder.component(.month , from: date)
//            let year = calunder.component(.year , from: date)
//            let thed = "\(day)-\(month)-\(year)"
//            Task {
//
//            //    let db = Firestore.firestore()
//
//                networking = true
//                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
//
//                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
//
//                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
//
//                print("done")
//
//                stateSt[indexPath.row] = "absent"
//
//
//                tableView.reloadData()
//            //  cell.backgroundColor = UIColor.black
//                networking = false
//            }
//
        
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
        /// Return the list after filtering
        noStudentsFoundLabel.isHidden = !(filteredTableData.count == 0)
        return filteredTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("s")
        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
        
        //  my.AttendToabsent.isHidden = true
        // Pull values from data structure
        let (name, id, state, serialNumber) = filteredTableData[indexPath.row]
        
        my.state.text =  name
        my.serialN.text = serialNumber // serialNumber[indexPath.row]
        my.name.text = stateSt[indexPath.row]
        //        if (stateSt[] == "attend"){
        //
        //        }
        // Use value from data structure
        if stateSt[indexPath.row] == "attend"   {
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
            my.name.textColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            //    my.AttendToabsent.isHidden = true
        }
        else if stateSt[indexPath.row] == "excused"   {
            my.name.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        
        
        // my.backgroundColor = stateSt[indexPath.row] == "attend" ? .red :
//        my.name.text = state
//        my.name.text = stateSt[indexPath.row]
        my.idStudent.text = id//  idstudent[indexPath.row]
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
    
    
    @IBAction func unwind(segue: UIStoryboardSegue ){
        
    }
    

 func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
 }

 func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
     return StudentStatus.count
 }

 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  
     return StudentStatus[row]
 }
 

//        func selectedTitleForComponent(component: Int) -> String? {
//            let row = selectedRowInComponent(component)
//            return dataSource.pickerView(pickerView, titleForRow:row, forComponent:component)
//        }
//

 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    
     
     whatPick = StudentStatus[row]
     pickerView.resignFirstResponder()
     pickerView.isHidden = true
     print("#9")
     print("whatPick" , whatPick)
     
     let date = Date()
     let calunder = Calendar.current
     let day = calunder.component(.day , from: date)
     let month = calunder.component(.month , from: date)
     let year = calunder.component(.year , from: date)
     let thed = "\(day)-\(month)-\(year)"

    Task {

        
        print("whatPick" , "-\(whatPick)-" )
        print("#1")
        picker = "\(pickerView)"

      
        
        print(picker , "picker before")
        
        
        
        
         guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }

         guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments().documents.first?.documentID else { return }

        try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": whatPick], merge: true)
        
         let DocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments()

        guard let state  = DocID.documents.first?.get("State") as? String else { return }
        
        

        print("whatPick" , "-\(whatPick)-" )
        
     

        print("#2")

         print("done")
        stateSt[selectedrow] = state
        DispatchQueue.main.async {
        self.tableview.reloadData()
        }
        print("#3")

     }


 }
 

}


// Setup searchbar delegate
extension ManualAttViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            self.filteredTableData = tableData
            tableview.reloadData()
        } else {
            let filteredStudents = self.tableData.filter { (studentName, studentId, stateSt, serialNumber) in
                return studentName.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) || studentId.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces)) ||
                serialNumber.lowercased().contains(query.lowercased().trimmingCharacters(in: .whitespaces))
            }
            
            self.filteredTableData = filteredStudents
            self.tableview.reloadData()
        }
    }
}
// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//import Firebase
//import UIKit
//import SwiftUI
//
//class ManualAttViewController: UIViewController,UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate ,UIPickerViewDelegate , UIPickerViewDataSource {
//
//   // @IBOutlet weak var search: UISearchBar!
//
//    @IBOutlet weak var tableview: UITableView!
//
//    @IBOutlet weak var nameCourse: UILabel!
//
//    @IBOutlet weak var cuurentDate: UILabel!
//
//    var nameStudent = [String]()
//
//    var filterName : [String]!
//    var picker :String = ""
//
//  //  var emailStudent = [String]()
//    var stateSt = [String]()
//    var emailSt = [String]()
//
//    var idstudent = [String]()
//    var serialNumber = [String]()
//
//    var v: String = ""
//    var networking: Bool = false
//
//    let StudentStatus = ["absent" , "late" , "attend"]
//    //var pickerView = UIPickerView()
////    @IBOutlet weak var pickerView: UIPickerView!
//    var whatPick = "attend"
//
//    @IBOutlet weak var pickerView: UIPickerView!
//    let db = Firestore.firestore()
//
//    let refreshControl = UIRefreshControl()
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
//
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Attend Manually"
//
////        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
//
//
//        pickerView.isHidden = true
//        filterName = nameStudent
//
//        //search.delegate = self
//     //  nostudent.isHidden = true
//       // self.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.339857161, green: 0.69448632, blue: 0.8468429446, alpha: 1)
//        print("what pressed is ")
//        print(v)
//        print("name of student")
//        print(nameStudent)
//        if ( nameStudent.count == 0 )
//        {
//      //      nostudent.isHidden = false
//
//            print("no student")
//        }
//        tableview.delegate = self
//        tableview.dataSource = self
//        //tableview.rowHeight = UITableView.automaticDimension
//        tableview.estimatedRowHeight = 50
//        tableview.rowHeight = 50
//       // navigationController?.navigationItem.title = "ss"
//
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//           tableview.addSubview(refreshControl)
//
//
//
//     let text1 = NSMutableAttributedString()
//       text1.append(NSAttributedString(string: ""
//                                  ));
//        text1.append(NSAttributedString(string: v));
//      //  nameSection.attributedText = text1
//
//        let currentDateTime = Date()
//        let formaater = DateFormatter()
//        formaater.timeStyle = .medium
//        formaater.dateStyle = .long
//        let dataTimeString = formaater.string(from: currentDateTime)
//
//        nameCourse.text = v
//
//    cuurentDate.text = dataTimeString
//    }
//
//    @objc func refresh(_ sender: AnyObject) {
//        let date = Date()
//        let calunder = Calendar.current
//        let day = calunder.component(.day , from: date)
//        let month = calunder.component(.month , from: date)
//        let year = calunder.component(.year , from: date)
//        let thed = "\(day)-\(month)-\(year)"
//        print(thed)
//       // let v =   sender.titleLabel?.text
//
//       // print(v!)
//        Task
//        {
//
//            let t_snapshot = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments()
//
//            let currentTime = getCurrentTime()
//            print(currentTime)
//            let currentTimeSplit = currentTime.split(separator: ":")
//            let timeHourct = currentTimeSplit[0]
//            //let timeMinct = Int(currentTimeSplit[1])
//          //  let timeMinct2 = Int(timeMinct ?? 0)
//            print("hour current",timeHourct )
//
//            let endTimeF = t_snapshot.documents.first?.data()["endTime"] as! String
//
//
//        print(t_snapshot.documents.count)
////            var studentArry = [String]()  //name
////            var stateArray = [String]()
////            var emailArray = [String]()
////            var idArray = [String]()
////            var seArray = [String]()
//            for doc in t_snapshot.documents {
//               let documentID = doc.documentID
//                  let snp = try await db.collection("studentsByCourse").document(documentID).collection("students").getDocuments()
//
//
//
//                print("here")
//                print(snp.documents.count)
//                print(snp.documents)
//
//                nameStudent.removeAll()
//                stateSt.removeAll()
//                emailSt.removeAll()
//                serialNumber.removeAll()
//                idstudent.removeAll()
//                for studentDoc in snp.documents {
//                    guard let state  = studentDoc.get("State") as? String else { continue }
//                    guard let email  = studentDoc.get("EmailStudent") as? String else { continue }
//                    guard let name  = studentDoc.get("name") as? String else { continue }
//                    guard let id = studentDoc.get("id") as? String else { continue }
//                   // guard let ser = studentDoc.get("SerialNum") as? String else { continue }
//
//                    print("name of student/",name)
//                    print("state of student/",state)
//                    print("email of student/",email)
//                    print("id of student/",id)
//                    print("serial N of student/",id)
//
//
//
//                  nameStudent.append(name)
//                   stateSt.append(state)
//                    emailSt.append(email)
//                   idstudent.append(id)
//                  // serialNumber.append(ser)
//                    self.refreshControl.endRefreshing()
//                    self.tableview.reloadData()
//
//
//                }
//
//
//
//
//            }
//
//        }
//
//    }
//
//    @IBAction func AttendPress(_ sender: UIButton) {
//    }
//    var selectedEmail = ""
//    var selectedrow = 0
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
//
//        print(indexPath)
//        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
//
//        pickerView.isHidden = false
//
//
//
//        tableView.deselectRow(at: indexPath, animated: true)
////        let state = stateSt[indexPath.row]
//
//     pickerView.delegate = self
//     pickerView.dataSource = self
//
//        let email = emailSt[indexPath.row]
//
//        selectedEmail = emailSt[indexPath.row]
//        selectedrow = indexPath.row
////                    let date = Date()
////                    let calunder = Calendar.current
////                    let day = calunder.component(.day , from: date)
////                    let month = calunder.component(.month , from: date)
////                    let year = calunder.component(.year , from: date)
////                    let thed = "\(day)-\(month)-\(year)"
////
////                   Task {
////
////
////                       print("whatPick" , "-\(whatPick)-" )
////                       print("#1")
////                       picker = "\(pickerView)"
////                     //  pickerView
////
////
////
////                       print(picker , "picker before")
////
////
////
////
////                        guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                        guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                       try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": whatPick], merge: true)
////
////                        let DocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments()
////
////                       guard let state  = DocID.documents.first?.get("State") as? String else { return }
////
////
////
////                       print("whatPick" , "-\(whatPick)-" )
////
////
////
////                       print("#2")
////
////                        print("done")
////                       stateSt[indexPath.row] = state
////                       tableView.reloadData()
////                       print("#3")
////
////                    }
//
//
//
//
//
//// absent
//////
////        if state == "absent" {
////
////            if networking {
////                return
////            }
////            let email = emailSt[indexPath.row]
////
////
////
////            let date = Date()
////            let calunder = Calendar.current
////            let day = calunder.component(.day , from: date)
////            let month = calunder.component(.month , from: date)
////            let year = calunder.component(.year , from: date)
////            let thed = "\(day)-\(month)-\(year)"
////            Task {
////
////            //    let db = Firestore.firestore()
////
////                networking = true
////                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "attend"], merge: true)
////
////                print("done")
////                stateSt[indexPath.row] = "attend"
////           //     my.AttendToabsent.isHidden = false
////
////
////                tableView.reloadData()
////            //  cell.backgroundColor = UIColor.black
////                networking = false
////            }
////        }
//
//
//
//        // ###################
//
////        if state == "attend"  {
////
////            if networking {
////                return
////            }
////            let email = emailSt[indexPath.row]
////
////
////
////            let date = Date()
////            let calunder = Calendar.current
////            let day = calunder.component(.day , from: date)
////            let month = calunder.component(.month , from: date)
////            let year = calunder.component(.year , from: date)
////            let thed = "\(day)-\(month)-\(year)"
////            Task {
////
////            //    let db = Firestore.firestore()
////
////                networking = true
////                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
////
////                print("done")
////
////                stateSt[indexPath.row] = "absent"
////
////
////                tableView.reloadData()
////            //  cell.backgroundColor = UIColor.black
////                networking = false
////            }
////        }
//
//
//
//        // ###################
//
//
//    //  attend  - late
////        if state == "attend"  {
////
////            if networking {
////                return
////            }
////            let email = emailSt[indexPath.row]
////
////
////
////            let date = Date()
////            let calunder = Calendar.current
////            let day = calunder.component(.day , from: date)
////            let month = calunder.component(.month , from: date)
////            let year = calunder.component(.year , from: date)
////            let thed = "\(day)-\(month)-\(year)"
////            Task {
////
////            //    let db = Firestore.firestore()
////
////                networking = true
////                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "late"], merge: true)
////
////                print("done")
////
////                stateSt[indexPath.row] = "late"
////
////
////                tableView.reloadData()
////            //  cell.backgroundColor = UIColor.black
////                networking = false
////            }
////        }
////
////        if state == "late"  {
////
////            if networking {
////                return
////            }
////            let email = emailSt[indexPath.row]
////
////
////
////            let date = Date()
////            let calunder = Calendar.current
////            let day = calunder.component(.day , from: date)
////            let month = calunder.component(.month , from: date)
////            let year = calunder.component(.year , from: date)
////            let thed = "\(day)-\(month)-\(year)"
////            Task {
////
////            //    let db = Firestore.firestore()
////
////                networking = true
////                guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////                guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: email).getDocuments().documents.first?.documentID else { return }
////
////                try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": "absent"], merge: true)
////
////                print("done")
////
////                stateSt[indexPath.row] = "absent"
////
////
////                tableView.reloadData()
////            //  cell.backgroundColor = UIColor.black
////                networking = false
////            }
////        }
//
//
//    }
//
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//       // let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
//        if let my = tableView.cellForRow(at: indexPath) as? customAttendTable {
//        //    my.AttendToabsent.isHidden = true
//            print("is didselct???")
//                }
//        print("???")
//      //  my.AttendToabsent.isHidden = true
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("enter")
//        return filterName.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    print("s")
//        let my = tableView.dequeueReusableCell(withIdentifier: "cll") as! customAttendTable
//
//      //  my.AttendToabsent.isHidden = true
//
//        my.state.text =  nameStudent[indexPath.row]
//
////        if (stateSt[] == "attend"){
////
////        }
//
//        if stateSt[indexPath.row] == "attend"   {
//            my.name.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//         //   my.AttendToabsent.isHidden = true
//        }
//        else if stateSt[indexPath.row] == "late" {
//            my.name.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//
//        }
//        else if stateSt[indexPath.row] == "absent" {
//
//            my.name.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//      //      my.AttendToabsent.isHidden = false
//        }
//        else if stateSt[indexPath.row] == "pending" {
//            my.name.textColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        //    my.AttendToabsent.isHidden = true
//        }
//        else if stateSt[indexPath.row] == "excused"   {
//            my.name.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//         }
//
//
//       // my.backgroundColor = stateSt[indexPath.row] == "attend" ? .red :
//        my.name.text = stateSt[indexPath.row]
//        my.idStudent.text = idstudent[indexPath.row]
//       // my.serialNnumber.text = serialNumber[indexPath.row]
//        my.img.image = UIImage(named: "girl2" )
//
//
//
//
//
//
//
//
//
//        return my
//    }
//
//    func getCurrentTime() -> String{
//
//        let formater = DateFormatter()
//
//        formater.dateFormat = "HH:mm"
//        let dateString =  formater.string(from: Date())
//        print("after formating")
//        print(dateString)
//        return dateString
//
//        }
//
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//////        filterName = []
//////        if searchText == "" {
//////            filterName = nameStudent
//////        }
//////        else{
//////        for name in nameStudent{
//////            if name.lowercased().contains(searchText.lowercased()){
//////                print("yee")
//////                filterName.append(name)
//////            }
//////        }
//////        }
////        filterName = searchText.isEmpty ? nameStudent : nameStudent.filter({(dataString: String) -> Bool in
////                // If dataItem matches the searchText, return true to include it
////                return dataString.range(of: searchText, options: .caseInsensitive) != nil
////            })
////
////
////        self.tableview.reloadData()
////    }
//
//
//    @IBAction func unwind(segue: UIStoryboardSegue ){
//
//    }
//
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return StudentStatus.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return StudentStatus[row]
//    }
//
//
////        func selectedTitleForComponent(component: Int) -> String? {
////            let row = selectedRowInComponent(component)
////            return dataSource.pickerView(pickerView, titleForRow:row, forComponent:component)
////        }
////
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        print("#7")
////        let chosen = pickerView.selectedRow(inComponent: 0)
////        if(chosen == 0 ){
////            print("is absent")
////            whatPick = "absent"
////        }
////        else if(chosen == 1 ){
////            print("is late")
////            whatPick = "late"
////        }
////        else if(chosen == 2){
////            print("is attend")
////            whatPick = "attend"
////        }
////        print(chosen , "picker after")
////
//
//        print("#8")
//
////        picker = "\( pickerView)"
//     //  pickerView
////       print(picker , "picker after")
////        my.state.text = StudentStatus[row]
//
//        whatPick = StudentStatus[row]
////        pickerView.reloadAllComponents()
//        pickerView.resignFirstResponder()
//        pickerView.isHidden = true
//        print("#9")
//        print("whatPick" , whatPick)
//
//        let date = Date()
//        let calunder = Calendar.current
//        let day = calunder.component(.day , from: date)
//        let month = calunder.component(.month , from: date)
//        let year = calunder.component(.year , from: date)
//        let thed = "\(day)-\(month)-\(year)"
//
//       Task {
//
//
//           print("whatPick" , "-\(whatPick)-" )
//           print("#1")
//           picker = "\(pickerView)"
//         //  pickerView
//
//
//
//           print(picker , "picker before")
//
//
//
//
//            guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
//
//            guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments().documents.first?.documentID else { return }
//
//           try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": whatPick], merge: true)
//
//            let DocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments()
//
//           guard let state  = DocID.documents.first?.get("State") as? String else { return }
//
//
//
//           print("whatPick" , "-\(whatPick)-" )
//
//
//
//           print("#2")
//
//            print("done")
//           stateSt[selectedrow] = state
//           DispatchQueue.main.async {
//               self.tableview.reloadData()
//           }
//           print("#3")
//
//        }
//
//
//    }
//
//}
//
////extension ManualAttViewController: UIPickerViewDelegate , UIPickerViewDataSource {
////
////    func numberOfComponents(in pickerView: UIPickerView) -> Int {
////        return 1
////    }
////
////    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////
////        return StudentStatus.count
////    }
////
////    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////
////        return StudentStatus[row]
////    }
////
////
//////        func selectedTitleForComponent(component: Int) -> String? {
//////            let row = selectedRowInComponent(component)
//////            return dataSource.pickerView(pickerView, titleForRow:row, forComponent:component)
//////        }
//////
////
////    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////
////        print("#7")
//////        let chosen = pickerView.selectedRow(inComponent: 0)
//////        if(chosen == 0 ){
//////            print("is absent")
//////            whatPick = "absent"
//////        }
//////        else if(chosen == 1 ){
//////            print("is late")
//////            whatPick = "late"
//////        }
//////        else if(chosen == 2){
//////            print("is attend")
//////            whatPick = "attend"
//////        }
//////        print(chosen , "picker after")
//////
////
////        print("#8")
////
//////        picker = "\( pickerView)"
////     //  pickerView
//////       print(picker , "picker after")
//////        my.state.text = StudentStatus[row]
////
////        whatPick = StudentStatus[row]
//////        pickerView.reloadAllComponents()
////        pickerView.resignFirstResponder()
////        pickerView.isHidden = true
////        print("#9")
////        print("whatPick" , whatPick)
////
////        let date = Date()
////        let calunder = Calendar.current
////        let day = calunder.component(.day , from: date)
////        let month = calunder.component(.month , from: date)
////        let year = calunder.component(.year , from: date)
////        let thed = "\(day)-\(month)-\(year)"
////
////       Task {
////
////
////           print("whatPick" , "-\(whatPick)-" )
////           print("#1")
////           picker = "\(pickerView)"
////         //  pickerView
////
////
////
////           print(picker , "picker before")
////
////
////
////
////            guard let sectionDocID = try await db.collection("studentsByCourse").whereField("courseN", isEqualTo: v).whereField("st", isEqualTo: thed).getDocuments().documents.first?.documentID else { return }
////
////            guard let studentDocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments().documents.first?.documentID else { return }
////
////           try await db.collection("studentsByCourse").document(sectionDocID).collection("students").document(studentDocID).setData(["State": whatPick], merge: true)
////
////            let DocID = try await db.collection("studentsByCourse").document(sectionDocID).collection("students").whereField("EmailStudent", isEqualTo: selectedEmail).getDocuments()
////
////           guard let state  = DocID.documents.first?.get("State") as? String else { return }
////
////
////
////           print("whatPick" , "-\(whatPick)-" )
////
////
////
////           print("#2")
////
////            print("done")
////           stateSt[selectedrow] = state
////           tableView.reloadData()
////           print("#3")
////
////        }
////
////
////    }
////}

