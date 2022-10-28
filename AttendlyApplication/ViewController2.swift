//
//  ViewController2.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 01/04/1444 AH.
//

//this part is basically the fixed part of the table -AD

import UIKit
import FirebaseFirestore

class ViewController2: UIViewController {

//    var Sunday =  ["Sunday", "SWE444", "SWE444",  "" , "", "SWE482",  "", "", "", "SWE321"]
//    var Monday =  ["Monday", "", "",  "" , "", "",  "", "", "", ""]
//    var Tuesday =  ["Tuesday", "", "",  "SWE482" , "", "SWE482", "", "", "SWE321", ""]
//    var Wednesday =  ["Wednesday", "", "",  "" , "", "",  "", "", "", ""]
//    var Thursday =  ["Thursday", "SWE444", "SWE444",  "" , "", "SWE482",  "", "SWE321", "", ""]
    let colorArray = [ #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1),  #colorLiteral(red: 0.7701125145, green: 0.9381597638, blue: 1, alpha: 1),  #colorLiteral(red: 0.9619761109, green: 0.9262647629, blue: 0.6508037448, alpha: 1) ,  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1) ,  #colorLiteral(red: 0.8193834424, green: 0.8202515244, blue: 1, alpha: 1),  #colorLiteral(red: 1, green: 0.8212433457, blue: 0.7032110095, alpha: 1)]
 
    var Sunday =  ["Sunday", "", "",  "" , "", "",  "", "", "", ""]
    var Monday =  ["Monday", "", "",  "" , "", "",  "", "", "", ""]
    var Tuesday =  ["Tuesday", "", "",  "" , "", "", "", "", "", ""]
    var Wednesday =  ["Wednesday", "", "",  "" , "", "",  "", "", "", ""]
    var Thursday =  ["Thursday", "", "",  "" , "", "",  "", "", "", ""]
   
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    @IBOutlet weak var gridLayout: StickyGridCollectionViewLayout!
    {
        didSet {
            gridLayout.stickyRowsCount = 1
            gridLayout.stickyColumnsCount = 1
        }
    }
    
}


// MARK: - Collection view data source and delegate methods

extension ViewController2: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
print(indexPath)
        
        //HERE GET
    //    course()
        
       
        
    
        if (indexPath.elementsEqual([1, 0])){
            cell.titleLabel.text = "8:00"
        }
        else if (indexPath.elementsEqual([2, 0])){
            cell.titleLabel.text = "9:15"
        }
        else if (indexPath.elementsEqual([0, 0])){
            cell.titleLabel.text = ""
        }

        else if (indexPath.elementsEqual([3, 0])){
            cell.titleLabel.text = "10:30"
        }
        else if (indexPath.elementsEqual([4, 0])){
            cell.titleLabel.text = "11:45"
        }
        else if (indexPath.elementsEqual([5, 0])){
            cell.titleLabel.text = "12:50"
        }//days
        else if (indexPath.elementsEqual([6, 0])){
            cell.titleLabel.text = "1:30"
        }
        else if (indexPath.elementsEqual([7, 0])){
            cell.titleLabel.text = "2:45"
        }
        else if (indexPath.elementsEqual([8, 0])){
            cell.titleLabel.text = "3:50"
        }
        else if (indexPath.elementsEqual([9, 0])){
            cell.titleLabel.text = "4:45"
        }
        else if (indexPath.elementsEqual([0, 1])){
            cell.titleLabel.text = "Sun" // 9.15-10.20
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 2])){
            cell.titleLabel.text = "Mon"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 3])){
            cell.titleLabel.text = "Tue"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 4])){
            cell.titleLabel.text = "Wed"           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 5])){
            cell.titleLabel.text = "Thur"
           // cell.titleLabel.textAlignment = .left
            
        }
       /* else if (indexPath.elementsEqual([0, 6])){
            cell.titleLabel.text = "13:30-14:35"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 7])){
            cell.titleLabel.text = "14:45-15:50"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 8])){
            cell.titleLabel.text = "16:00-17:05"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 9])){
            cell.titleLabel.text = "17:15-18:20"
           // cell.titleLabel.textAlignment = .left
            
        }*/
        else{
            cell.titleLabel.text = "\(indexPath)"}
        
        cell.backgroundColor = gridLayout.isItemSticky(at: indexPath)  ? .groupTableViewBackground : .white
        if(cell.backgroundColor == .white){
            cell.backgroundColor =  #colorLiteral(red: 0.8953151844, green: 0.9132214881, blue: 0.9132214881, alpha: 1)
          cell.layer.borderWidth = 0.3
           cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel.font = cell.titleLabel.font.withSize(15)
           
        }
        else{
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.layer.borderWidth = 0.4
            cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel.font = cell.titleLabel.font.withSize(18)
            
        }
        
        
        for i in 1..<Sunday.count{
            if (indexPath.elementsEqual([i, 1]))
            { cell.titleLabel.text = Sunday[i]
                if(Sunday[i] == "SWE482"){
                   cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
               }
                else if(Sunday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Sunday[i] != "")
                {
                    cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
                
            }
        }
        for i in 1..<Monday.count{
            if (indexPath.elementsEqual([i, 2]))
            { cell.titleLabel.text = Monday[i]
                if(Monday[i] == "SWE482"){
                    cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
                }
                
                else if(Monday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
                    
}
               
           }
        }
        for i in 1..<Tuesday.count{
            if (indexPath.elementsEqual([i, 3]))
            { cell.titleLabel.text = Tuesday[i]
                if(Tuesday[i] == "SWE482"){
                    cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
                }
                else if(Tuesday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                else if(Tuesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
                

            }
        }
        for i in 1..<Wednesday.count{
            if (indexPath.elementsEqual([i, 4]))
            { cell.titleLabel.text = Wednesday[i]
                if(Wednesday[i] == "SWE482"){
                    cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
                }
                else if(Wednesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
                

            }
        }
        for i in 1..<Thursday.count{
            if (indexPath.elementsEqual([i, 5]))
            { cell.titleLabel.text = Thursday[i]
                if(Thursday[i] == "SWE482"){
                    cell.backgroundColor =  #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1)
                }
                else if(Thursday[i] == "SWE321"){
                   cell.backgroundColor =  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1)
               }
                 else if(Thursday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
            

            }
        }
        
        return cell
    }
   
    func course(){
        let db = Firestore.firestore()
        Task{
            let snapshot =  try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "400@student.ksu.edu.sa").getDocuments()
            
//            let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
//            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            
            guard let sectsChk = snapshot.documents.first?.get("Sections") as? [String] else { return }

            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            print("sectsChk",sectsChk)
            print("actualChk",actualChk)
            
              if((actualChk.count == 1 && actualChk[0] == "" ) || (sectsChk.count == 1 && sectsChk[0] == "" ) )
                {
                //    self.noC.text = "No courses \n registered!"
                }
                else{
                    for i in 0..<sectsChk.count {
                      
                        print("sectsChk is i ",sectsChk[i])
                      //..
                        let sectss = try await db.collection("Sections").whereField("section", isEqualTo: sectsChk[i]).getDocuments()
                       
                      //  let  section =  sectss.documents.first!.get("section") as! String
                       // print("section",section)
                        var cdate =  sectss.documents.first!.get("courseDate") as! [String: String]
                        print("cdate",cdate)
                        for (key,value) in cdate {

                            if key == "1"
                            {
                                //no 0
                                if value == "8:00"
                                {Sunday[1] = value}
                                else if value == "9:15"
                                {Sunday[2] = value}
                                else if value == "10:30"
                                {Sunday[3] = value}
                                else if value == "11:45"
                                {Sunday[4] = value}
                                else if value == "12:50"
                                {Sunday[5] = value}
                                else if value == "1:30"
                                {Sunday[6] = value}
                                else if value == "2:45"
                                {Sunday[7] = value}
                                else if value == "3:50"
                                {Sunday[8] = value}
                                else if value == "4:45"
                                {Sunday[9] = value}
                                else{}

                            }
                            else if  key == "2"
                            {
                                //no 0
                                if value == "8:00"
                                {Monday[1] = value}
                                else if value == "9:15"
                                {Monday[2] = value}
                                else if value == "10:30"
                                {Monday[3] = value}
                                else if value == "11:45"
                                {Monday[4] = value}
                                else if value == "12:50"
                                {Monday[5] = value}
                                else if value == "1:30"
                                {Monday[6] = value}
                                else if value == "2:45"
                                {Monday[7] = value}
                                else if value == "3:50"
                                {Monday[8] = value}
                                else if value == "4:45"
                                {Monday[9] = value}
                                else{}
                            }
                            else if  key == "3"
                            {
                                //no 0
                                if value == "8:00"
                                {Tuesday[1] = value}
                                else if value == "9:15"
                                {Tuesday[2] = value}
                                else if value == "10:30"
                                {Tuesday[3] = value}
                                else if value == "11:45"
                                {Tuesday[4] = value}
                                else if value == "12:50"
                                {Tuesday[5] = value}
                                else if value == "1:30"
                                {Tuesday[6] = value}
                                else if value == "2:45"
                                {Tuesday[7] = value}
                                else if value == "3:50"
                                {Tuesday[8] = value}
                                else if value == "4:45"
                                {Tuesday[9] = value}
                                else{}
                            }
                            else if  key == "4"
                            {
                                //no 0
                                if value == "8:00"
                                {Wednesday[1] = value}
                                else if value == "9:15"
                                {Wednesday[2] = value}
                                else if value == "10:30"
                                {Wednesday[3] = value}
                                else if value == "11:45"
                                {Wednesday[4] = value}
                                else if value == "12:50"
                                {Wednesday[5] = value}
                                else if value == "1:30"
                                {Wednesday[6] = value}
                                else if value == "2:45"
                                {Wednesday[7] = value}
                                else if value == "3:50"
                                {Wednesday[8] = value}
                                else if value == "4:45"
                                {Wednesday[9] = value}
                                else{}
                            }
                            else if  key == "5"
                            {
                                //no 0
                                if value == "8:00"
                                {Thursday[1] = value}
                                else if value == "9:15"
                                {Thursday[2] = value}
                                else if value == "10:30"
                                {Thursday[3] = value}
                                else if value == "11:45"
                                {Thursday[4] = value}
                                else if value == "12:50"
                                {Thursday[5] = value}
                                else if value == "1:30"
                                {Thursday[6] = value}
                                else if value == "2:45"
                                {Thursday[7] = value}
                                else if value == "3:50"
                                {Thursday[8] = value}
                                else if value == "4:45"
                                {Thursday[9] = value}
                                else{}
                            }
                        }
                    }
                }}
    }
    }


extension ViewController2: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 65, height: 50)
    }
  
}


