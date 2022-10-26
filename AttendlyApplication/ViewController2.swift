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

    var Sunday =  ["Sunday", "SWE444", "SWE444",  "" , "", "Cloud482",  "", "", "", ""]
    var Monday =  ["Monday", "", "",  "" , "", "",  "", "", "", ""]
    var Tuesday =  ["Tuesday", "", "",  "Cloud482" , "", "Cloud482", "", "", "", ""]
    var Wednesday =  ["Wednesday", "", "",  "" , "", "",  "", "", "", ""]
    var Thursday =  ["Thursday", "SWE444", "SWE444",  "" , "", "Cloud482",  "", "", "", ""]
    let colorArray = [ #colorLiteral(red: 0.9827464223, green: 0.8374974728, blue: 0.9789015651, alpha: 1),  #colorLiteral(red: 0.7701125145, green: 0.9381597638, blue: 1, alpha: 1),  #colorLiteral(red: 0.9619761109, green: 0.9262647629, blue: 0.6508037448, alpha: 1) ,  #colorLiteral(red: 0.7984707952, green: 0.9665120244, blue: 0.6857665181, alpha: 1) ,  #colorLiteral(red: 0.8193834424, green: 0.8202515244, blue: 1, alpha: 1),  #colorLiteral(red: 1, green: 0.8212433457, blue: 0.7032110095, alpha: 1)]
    
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
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
print(indexPath)
        if (indexPath.elementsEqual([1, 0])){
            cell.titleLabel.text = "Sunday"
        }
        else if (indexPath.elementsEqual([2, 0])){
            cell.titleLabel.text = "Monday"
        }
        else if (indexPath.elementsEqual([0, 0])){
            cell.titleLabel.text = ""
        }

        else if (indexPath.elementsEqual([3, 0])){
            cell.titleLabel.text = "Tuesday"
        }
        else if (indexPath.elementsEqual([4, 0])){
            cell.titleLabel.text = "Wednesday"
        }
        else if (indexPath.elementsEqual([5, 0])){
            cell.titleLabel.text = "Thursday"
        }
        else if (indexPath.elementsEqual([0, 1])){
            cell.titleLabel.text = "8:00-9:05" // 9.15-10.20
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 2])){
            cell.titleLabel.text = "9:15-10:20"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 3])){
            cell.titleLabel.text = "10:30-11:35"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 4])){
            cell.titleLabel.text = "11:45-12:50"           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 5])){
            cell.titleLabel.text = "12:50-13:30"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 6])){
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
            
        }
        else{
            cell.titleLabel.text = "\(indexPath)"}
        cell.backgroundColor = gridLayout.isItemSticky(at: indexPath)  ? .groupTableViewBackground : .white
        if(cell.backgroundColor == .white){
            cell.backgroundColor =  #colorLiteral(red: 0.8953151844, green: 0.9132214881, blue: 0.9132214881, alpha: 1)
          cell.layer.borderWidth = 0.3
           cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel.font = cell.titleLabel.font.withSize(18)
           
        }
        else{
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.layer.borderWidth = 0.4
            cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.titleLabel.font = cell.titleLabel.font.withSize(20)
            
        }
        for i in 1..<Sunday.count{
            if (indexPath.elementsEqual([1, i]))
            { cell.titleLabel.text = Sunday[i]
                if(Sunday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
            }
        }
        for i in 1..<Monday.count{
            if (indexPath.elementsEqual([2, i]))
            { cell.titleLabel.text = Monday[i]
                if(Monday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}
           }
        }
        for i in 1..<Tuesday.count{
            if (indexPath.elementsEqual([3, i]))
            { cell.titleLabel.text = Tuesday[i]
                if(Tuesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

            }
        }
        for i in 1..<Wednesday.count{
            if (indexPath.elementsEqual([4, i]))
            { cell.titleLabel.text = Wednesday[i]
                if(Wednesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

            }
        }
        for i in 1..<Thursday.count{
            if (indexPath.elementsEqual([5, i]))
            { cell.titleLabel.text = Thursday[i]
                if(Thursday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.6223602891, green: 0.7846285701, blue: 0.8139474988, alpha: 1)
}

            }
        }
        course()
        return cell
    }
   
    func course(){
        let db = Firestore.firestore()
        Task{
            let snapshot =  try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo: "400@student.ksu.edu.sa").getDocuments()
            
            let actualChk = snapshot.documents.first!.get("courses") as! [String]
            let sectsChk = snapshot.documents.first!.get("Sections") as! [String]
            
              if((actualChk.count == 1 && actualChk[0] == "" ) || (sectsChk.count == 1 && sectsChk[0] == "" ) )
                {
                //    self.noC.text = "No courses \n registered!"
                }
                else{
                    for i in 0..<sectsChk.count {
                      //..
                        let sectss = try await db.collection("studentsByCourse").whereField("tag", isEqualTo: sectsChk[i]).getDocuments()
                        
                            //get day
                        
                        guard let start = sectss.documents.first?.get("startTime") as? String else { return }
                        
                        if  start.elementsEqual("9:20")
                        {
                            //add to array for that day in known index
                            //ex: Sunday[2] = start
                        
                        }
                        //else  if for all time
                        
                        //done :)
                        
                        
                        print("sects",sectsChk.count)
                        print("START",start)
                  //      let time  = sectss.documents.get("startTime") as  [String]
                        
                        
//
                    
                        
                    }
                }
                
    }
        }
    }


extension ViewController2: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
  
}


