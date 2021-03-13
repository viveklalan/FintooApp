//
//  SettingVC.swift
//  FintooApp
//
//  Created by Jai Mataji on 09/03/21.
//

import UIKit
import DropDown

class SettingVC: UIViewController {
    
    @IBOutlet weak var settingMenuTabs: UICollectionView!
    @IBOutlet weak var settingTabs: UICollectionView!
    //For Radius
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var optionCountLable: UILabel!
    @IBOutlet weak var optionCountBackgroundView: UIView!
    @IBOutlet weak var formContentView: UIView!
    
    var settingMenuTabsData = [(name:"Your Info", image: "art1"), (name:"Know you better", image: "art2"), (name:"Know your risk", image: "art1"), (name:"Your family", image: "art2")]
    
    var settingTabsVC = ["YourInfoVC", "DashboardVC", "DashboardVC", "DashboardVC"]
    
    var first: UIViewController!
    var selectedIndex = IndexPath(row: 0, section: 0)
    
    let moreOptionsDropDown = DropDown()
    @IBOutlet weak var moreOptionMenuBUtton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreOptionsDropDown.anchorView = moreOptionMenuBUtton
        moreOptionsDropDown.dataSource = ["Option 1","Option 2","Option 3","Option 4"]
        
        messageBackgroundView.addRadius(brRadius: 25.0)
        messageCountLabel.addRadius(brRadius: 10)
        optionCountLable.addRadius(brRadius: 10.0)
        optionCountBackgroundView.addRadius(brRadius: 8.0)
        formContentView.addRadius(brRadius: 16.0)
    }
    
    @IBAction func moreOptionsClicked(_ sender: Any) {
        moreOptionsDropDown.show()
        moreOptionsDropDown.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        }
    }
    
    @IBAction func chatButtonClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "BotChatVC")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}


//MARK: Collection View Delegate Datasource

extension SettingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == settingMenuTabs{
            return settingMenuTabsData.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == settingMenuTabs{
            let data = settingMenuTabsData[indexPath.row]
            let cell = settingMenuTabs.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SettingTabCell
            cell.headingLabel.text = data.name
            cell.imageView.image = UIImage(named: data.image)
            
            cell.addRadius(brRadius: 8.0)
            cell.backgroundColor = UIColor(red: 234/255, green: 203/255, blue: 197/255, alpha: 1)
            cell.imageView.alpha = 0.5
            if selectedIndex == indexPath{
                cell.backgroundColor = UIColor(red: 236/255, green: 128/255, blue: 107/255, alpha: 1)
                cell.imageView.alpha = 1
            }
            return cell
        }
        else{
            let cell = settingTabs.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            for addedView: UIView in cell.subviews {
                addedView.removeFromSuperview()
            }
            self.first = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "\(settingTabsVC[selectedIndex.row])")
            self.first.view?.frame = CGRect(x: 0, y: 0, width: formContentView.frame.width, height: formContentView.frame.height)
            self.addChild(self.first)
            cell.addSubview(self.first.view)
            self.first.didMove(toParent: self)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == settingMenuTabs{
            selectedIndex = indexPath
            settingMenuTabs.reloadData()
            settingTabs.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == settingMenuTabs{
            let cellSize:CGSize = CGSize(width: 80, height: 80)
            return cellSize
        }else{
            let cellSize:CGSize = CGSize(width: self.formContentView.frame.width, height: self.formContentView.frame.height)
            return cellSize
        }
    }
}

//MARK: Settingtab cell
class SettingTabCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
}
