//
//  subtotal.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 11/25/24.
//

struct costCalculator {
    static func calculateSubtotal(laborRate: Double, laborHours: Double, partPrices: [Double]) -> Double {
        let laborCost = laborRate * laborHours
        let partsCost = partPrices.reduce(0, +)
        return laborCost + partsCost
    }
}
