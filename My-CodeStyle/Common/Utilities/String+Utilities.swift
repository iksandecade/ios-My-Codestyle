//
//  String+Utilities.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit

extension String {
    static func trim(_ str: String?) -> String {
        return (str ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - As Number
extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func trimCountryCodeIfAny() -> String {
        return self.replacingOccurrences(of: "+62", with: "")
    }
}

// MARK: - Size
extension String {
    var size: CGSize {
        return size()
    }
    
    public func size(usingFont font: UIFont?) -> CGSize {
        let _font = font ?? UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: _font]
        return self.size(withAttributes: attributes)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
