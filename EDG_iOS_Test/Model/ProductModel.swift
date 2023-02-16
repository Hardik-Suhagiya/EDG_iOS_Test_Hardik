//
//  ProductModel.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 15/02/23.
//

import Foundation
import UIKit

// MARK: - Welcome
class ProductModel: Codable {
    let products: [Product]?

    init(products: [Product]?) {
        self.products = products
    }
}

// MARK: - Product
class Product: Codable {
    let citrusID, title, id: String?
    let imageURL: String?
    let price: [Price]?
    let brand: String?
    let badges: [String]?
    let ratingCount: Double?
    let messages: Messages?
    let isAddToCartEnable: Bool?
    let addToCartButtonText: AddToCartButtonText?
    let isInTrolley, isInWishlist: Bool?
    let purchaseTypes: [PurchaseTypeElement]?
    let isFindMeEnable: Bool?
    let saleUnitPrice: Double?
    let totalReviewCount: Int?
    let isDeliveryOnly, isDirectFromSupplier: Bool?

    enum CodingKeys: String, CodingKey {
        case citrusID = "citrusId"
        case title, id, imageURL, price, brand, badges, ratingCount, messages, isAddToCartEnable, addToCartButtonText, isInTrolley, isInWishlist, purchaseTypes, isFindMeEnable, saleUnitPrice, totalReviewCount, isDeliveryOnly, isDirectFromSupplier
    }

    init(citrusID: String?, title: String?, id: String?, imageURL: String?, price: [Price]?, brand: String?, badges: [String]?, ratingCount: Double?, messages: Messages?, isAddToCartEnable: Bool?, addToCartButtonText: AddToCartButtonText?, isInTrolley: Bool?, isInWishlist: Bool?, purchaseTypes: [PurchaseTypeElement]?, isFindMeEnable: Bool?, saleUnitPrice: Double?, totalReviewCount: Int?, isDeliveryOnly: Bool?, isDirectFromSupplier: Bool?) {
        self.citrusID = citrusID
        self.title = title
        self.id = id
        self.imageURL = imageURL
        self.price = price
        self.brand = brand
        self.badges = badges
        self.ratingCount = ratingCount
        self.messages = messages
        self.isAddToCartEnable = isAddToCartEnable
        self.addToCartButtonText = addToCartButtonText
        self.isInTrolley = isInTrolley
        self.isInWishlist = isInWishlist
        self.purchaseTypes = purchaseTypes
        self.isFindMeEnable = isFindMeEnable
        self.saleUnitPrice = saleUnitPrice
        self.totalReviewCount = totalReviewCount
        self.isDeliveryOnly = isDeliveryOnly
        self.isDirectFromSupplier = isDirectFromSupplier
    }
}

enum AddToCartButtonText: String, Codable {
    case addToCart = "Add to cart"
    case editQuantity = "Edit quantity"
}

// MARK: - Messages
class Messages: Codable {
    let secondaryMessage: String?
    let sash: Sash?
    let promotionalMessage: String?

    init(secondaryMessage: String?, sash: Sash?, promotionalMessage: String?) {
        self.secondaryMessage = secondaryMessage
        self.sash = sash
        self.promotionalMessage = promotionalMessage
    }
}

// MARK: - Sash
class Sash: Codable {

    init() {
    }
}

// MARK: - Price
class Price: Codable {
    let message: Message?
    let value: Double?
    let isOfferPrice: Bool?

    init(message: Message?, value: Double?, isOfferPrice: Bool?) {
        self.message = message
        self.value = value
        self.isOfferPrice = isOfferPrice
    }
}

enum Message: String, Codable {
    case inAnySix = "in any six"
    case perBottle = "per bottle"
}

// MARK: - PurchaseTypeElement
class PurchaseTypeElement: Codable {
    let purchaseType: PurchaseTypeEnum?
    let displayName: DisplayName?
    let unitPrice: Double?
    let minQtyLimit, maxQtyLimit, cartQty: Int?

    init(purchaseType: PurchaseTypeEnum?, displayName: DisplayName?, unitPrice: Double?, minQtyLimit: Int?, maxQtyLimit: Int?, cartQty: Int?) {
        self.purchaseType = purchaseType
        self.displayName = displayName
        self.unitPrice = unitPrice
        self.minQtyLimit = minQtyLimit
        self.maxQtyLimit = maxQtyLimit
        self.cartQty = cartQty
    }
}

enum DisplayName: String, Codable {
    case case6 = "case (6)"
    case each = "each"
    case perBottle = "per bottle"
    case perCaseOf6 = "per case of 6"
}

enum PurchaseTypeEnum: String, Codable {
    case bottle = "Bottle"
    case purchaseTypeCase = "Case"
}
