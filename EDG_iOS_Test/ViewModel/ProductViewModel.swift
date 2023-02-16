//
//  ProductViewModel.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 15/02/23.
//

import Foundation
import UIKit
import Alamofire

class ProductViewModel: NSObject{
    static let shared = ProductViewModel()
    var arrProducts = [Product]()
    
    func fetchProductList( completionHandler: @escaping  (_ model:ProductModel?, _ errorMsg:String?) -> (Void)){
        
        arrProducts.removeAll()
        
        AF.request(PRODUCT_LIST_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            
            switch response.result {
            case .success(let data):
                guard data != nil else{
                    completionHandler(nil,SOMETHING_WENT_WRONG)
                    return
                }
                guard let model = try? JSONDecoder().decode(ProductModel.self, from: data!) else{
                    completionHandler(nil,SOMETHING_WENT_WRONG)
                    return
                }
                self.arrProducts = model.products ?? [Product]()
                completionHandler(model,nil)
                
                break
                
            case .failure(let error):
                completionHandler(nil,error.localizedDescription)
                break
            }
        }
    }
}
