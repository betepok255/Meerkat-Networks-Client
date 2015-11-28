//
//  SingletonDB.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 28.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import Foundation

public class SingletonDB {
    public static let sharedInstance = SingletonDB()
    
    public var token = ""
    
    // User
    public var userName = "Username"
    public var userEmail = "email"
    
    private init() {}
}