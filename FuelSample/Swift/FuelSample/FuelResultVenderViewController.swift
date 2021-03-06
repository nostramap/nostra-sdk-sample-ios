//
//  FuelResultViewController.swift
//  FuelSample
//
//  Copyright © 2559 Globtech. All rights reserved.
//

import UIKit
import NOSTRASDK

class FuelResultVendorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var adminLevel1: String?;
    var adminLevel2: String?;
    
    var lat: Double?;
    var lon: Double?;
    
    var results: [NTFuelResult]?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var param: NTFuelParameter! = nil;
        
        if adminLevel1 != nil && adminLevel2 != nil {
            param = NTFuelParameter(adminLevel1: adminLevel1!, adminLevel2: adminLevel2!);
        }
        else {
            param = NTFuelParameter(lat: lat!, lon: lon!);
        }
        
        do {
            let resultSet = try NTFuelService.execute(param);
            results = resultSet.results;
        }
        catch let error as NSError {
            print("error: \(error.description)");
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "priceSegue" {
            let priceViewController = segue.destination as? FuelResultPriceViewController;
            let result = sender as! NTFuelResult;
            priceViewController?.title = result.brandName_L;
            priceViewController?.result = result
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results![indexPath.row];
        
        self.performSegue(withIdentifier: "priceSegue", sender: result);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        let result = results![indexPath.row];
        
        cell?.textLabel?.text = result.brandName_L;
        
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results != nil ? (results?.count)! : 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
}
