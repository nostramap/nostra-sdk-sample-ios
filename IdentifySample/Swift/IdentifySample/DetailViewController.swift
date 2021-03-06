//
//  DetailViewController.swift
//  IdentifySample
//
//  Copyright © 2559 Globtech. All rights reserved.
//

import UIKit
import NOSTRASDK

class DetailViewController: UIViewController {

    
    var idenResult: NTIdentifyResult?;
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let param = NTExtraContentParameter(nostraId: idenResult!.nostraId);
            let result = try NTExtraContentService.execute(param)
            
            
            if result.travel != nil && result.travel.count > 0 {
                let travel = result.travel.first;
                
                lblName.text = travel?.name;
                lblInfo.text = travel?.attraction1_L;
                lblDetail.text = travel?.history_L;
                
                if travel?.picture1 != nil && travel?.picture1 != "" {
                    do {
                        let url = URL(string: (travel?.picture1)!);
                        let data = try Data(contentsOf: url!);
                        let image = UIImage(data: data);
                        imageView.image = image;
                    }
                    catch{
                        
                    }
                    
                }
                
            }
            else if result.food != nil && result.food.count > 0 {
                let food = result.food.first;
                
                lblName.text = food?.name;
                lblInfo.text = food?.foodType1_L;
                lblDetail.text = food?.entertainmentService_L;
                
                if food?.picture1 != nil && food?.picture1 != "" {
                    
                    do {
                        let url = URL(string: (food?.picture1)!);
                        let data = try Data(contentsOf: url!);
                        let image = UIImage(data: data);
                        imageView.image = image;
                    }
                    catch{
                        
                    }
                }
            }
            else {
                
                let alertController = UIAlertController(title: "Extra content is not Found", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                    _ = self.navigationController?.popViewController(animated: true);
                }));
                
                self.present(alertController, animated: true, completion: nil);
                
                
            }
            
        }
        catch {
            
        }
        
    }
}
