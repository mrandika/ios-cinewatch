//
//  File.swift
//
//
//  Created by Andika on 18/11/21.
//

import Foundation

extension String {
    func localized() -> String {
        return Bundle.module.localizedString(forKey: self, value: nil, table: nil)
    }
}
