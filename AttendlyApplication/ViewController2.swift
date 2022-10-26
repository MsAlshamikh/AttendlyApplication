//
//  ViewController2.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 01/04/1444 AH.
//

//this part is basically the fixed part of the table -AD

import UIKit

class ViewController2: UIViewController {

    var Sunday =  ["Sunday", "swe444", "",  "" , "", "csc111",  "", "", "slm108", ""]
    var Monday =  ["Monday", "csc111", "",  "" , "", "csc111",  "", "", "slm108", ""]
    var Tuesday =  ["Tuesday", "", "",  "csc111" , "", "csc111", "", "", "slm108", ""]
    var Wednesday =  ["Wednesday", "swe444", "",  "" , "", "csc111",  "", "", "slm108", ""]
    var Thursday =  ["Thursday", "slm108", "",  "" , "", "csc111",  "", "", "slm108", ""]
    
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
            cell.titleLabel.text = "8:00 - 9:05" // 9.15-10.20
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 2])){
            cell.titleLabel.text = "9:15 - 10:20"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 3])){
            cell.titleLabel.text = "10:15 - 11:35"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 4])){
            cell.titleLabel.text = "11:45 - 12:50"           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 5])){
            cell.titleLabel.text = "12:50 - 13:30"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 6])){
            cell.titleLabel.text = "13:30 - 14:35"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 7])){
            cell.titleLabel.text = "14:45 - 15:50"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 8])){
            cell.titleLabel.text = "15:50 - 16:30"
           // cell.titleLabel.textAlignment = .left
            
        }
        else if (indexPath.elementsEqual([0, 9])){
            cell.titleLabel.text = "16:30 - 17:35" 
           // cell.titleLabel.textAlignment = .left
            
        }
        else{
            cell.titleLabel.text = "\(indexPath)"}
        cell.backgroundColor = gridLayout.isItemSticky(at: indexPath)  ? .groupTableViewBackground : .white
        if(cell.backgroundColor == .white){
            cell.backgroundColor =  #colorLiteral(red: 0.8768938184, green: 0.8879328966, blue: 0.8877387047, alpha: 1)
          cell.layer.borderWidth = 0.3
            cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           
        }
        else{
            cell.backgroundColor = #colorLiteral(red: 0.05053991079, green: 0.5733678937, blue: 0.6324701905, alpha: 1)
            cell.layer.borderWidth = 0.4
            cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.titleLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        for i in 1..<Sunday.count{
            if (indexPath.elementsEqual([1, i]))
            { cell.titleLabel.text = Sunday[i]
                if(Sunday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)}
            }
        }
        for i in 1..<Monday.count{
            if (indexPath.elementsEqual([2, i]))
            { cell.titleLabel.text = Monday[i]
                if(Monday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)}
           }
        }
        for i in 1..<Tuesday.count{
            if (indexPath.elementsEqual([3, i]))
            { cell.titleLabel.text = Tuesday[i]
                if(Tuesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)}

            }
        }
        for i in 1..<Wednesday.count{
            if (indexPath.elementsEqual([4, i]))
            { cell.titleLabel.text = Wednesday[i]
                if(Wednesday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)}

            }
        }
        for i in 1..<Thursday.count{
            if (indexPath.elementsEqual([5, i]))
            { cell.titleLabel.text = Thursday[i]
                if(Thursday[i] != "")
                {cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)}

            }
        }
        return cell
    }
   
  
}

extension ViewController2: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}


