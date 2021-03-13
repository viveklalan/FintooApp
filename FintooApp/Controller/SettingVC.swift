//
//  SettingVC.swift
//  FintooApp
//
//  Created by Jai Mataji on 09/03/21.
//

import UIKit
import SkyFloatingLabelTextField

class SettingVC: UIViewController {

    @IBOutlet weak var settingTabs: UICollectionView!
    
    @IBOutlet weak var investmentForTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var fixedLabel: UILabel!
    @IBOutlet weak var equityTypeSwitch: UISwitch!
    @IBOutlet weak var variableLabel: UILabel!
    @IBOutlet weak var dateOfPurchaseTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var noOfUnitsTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var purchasePriceTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var addMoreButton: UIButton!
    
    //ForCircle
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var optionCountLable: UILabel!
    @IBOutlet weak var optionCountBackgroundView: UIView!
    
    @IBOutlet weak var formContentView: UIView!
    
    var settingtabsData = [(name:"Your Info", image: "art1"), (name:"Know you better", image: "art2"), (name:"Know your risk", image: "art1"), (name:"Your family", image: "art2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addMoreButton.addRadius(brRadius: 8)
        
        messageBackgroundView.addRadius(brRadius: 25.0)
        messageCountLabel.addRadius(brRadius: 10)
        
        optionCountLable.addRadius(brRadius: 10.0)
        optionCountBackgroundView.addRadius(brRadius: 8.0)
        formContentView.addRadius(brRadius: 16.0)
    }
    
    @IBAction func investmentForClicked(_ sender: Any) {
    }
    
    @IBAction func equityTypeSwitchClicked(_ sender: Any) {
    }
    
    @IBAction func addMoreClicked(_ sender: Any) {
    }
    
    
    @IBAction func moreOptionsClicked(_ sender: Any) {
        
    }
    
    @IBAction func chatButtonClicked(_ sender: Any) {
        
            let vc = UIStoryboard.init(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "BotChatVC")
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: false)
    }
    
    var selectedIndex = IndexPath(row: 0, section: 0)
}


//MARK: Collection View Delegate Datasource

extension SettingVC: UICollectionViewDelegate, UICollectionViewDataSource{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        settingtabsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = settingtabsData[indexPath.row]
        let cell = settingTabs.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SettingTabCell
        
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
    
    
}

//MARK: Settingtab cell
class SettingTabCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
}
