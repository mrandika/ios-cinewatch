//
//  File.swift
//  
//
//  Created by Andika on 18/11/21.
//

import Foundation

public final class MockedData {
    public static let movieJSON: URL = Bundle.module.url(forResource: "movie", withExtension: "json")!
    public static let movieCastsJSON: URL = Bundle.module.url(forResource: "casts", withExtension: "json")!
}
