//
//  FilterViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 18/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
protocol filterDelegate {
    func setFilters (contents: [String])
}
class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var filters = [String]()
    var delegate: filterDelegate?
    let platforms = ["BRAK","PS4","PC","XBOX"]
    
    @IBOutlet weak var pricetag: UILabel!
    @IBOutlet weak var PriceSlider: UISlider!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platforms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return platforms[row]
    }

    @IBOutlet weak var platformPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        platformPicker.delegate = self
        platformPicker.dataSource = self
        PriceSlider.value = PriceSlider.maximumValue
        pricetag.text = String.init(format: "%.2f",PriceSlider?.value ?? -1)
    }
    
    @IBAction func AcceptFilter(_ sender: Any) {
        filters = [String]()
    filters.append(platforms[platformPicker.selectedRow(inComponent: 0)])
        filters.append(String.init(format: "%.2f",PriceSlider?.value ?? -1))
        delegate?.setFilters(contents: filters)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func priceChanged(_ sender: Any) {
        pricetag.text = String.init(format: "%.2f",PriceSlider?.value ?? -1)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
