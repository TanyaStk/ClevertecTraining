//
//  StringExtension.swift
//  ClevertecTraining
//
//  Created by Tanya Samastroyenka on 08.12.2022.
//

import Foundation

extension String {
    func localized(_ lang: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
