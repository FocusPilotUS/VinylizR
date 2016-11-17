//
//  Constants.swift
//  VinylizR
//
//  Created by Nathan Turner on 11/16/16.
//  Copyright © 2016 Nathan Turner. All rights reserved.
//

import Foundation

struct Consumer {
    /// created in Discogs
    let key = "xsszRwwaPblmFEsqIXQD"
    let secret = "rebTAyLNdeXeRESJlnvjVrFcZYpHSpNY"
}

struct BaseURL {
    let requestToken = "https://api.discogs.com/oauth/request_token"
    let authorize = "https://www.discogs.com/oauth/authorize"
    let accessToken = "https://api.discogs.com/oauth/access_token"
}
