//
//  Outage.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import Foundation

struct Outage: Codable {
    let KesintiTarihi, Aciklama, IlceAdi: String
    let MahalleID: [Int]
    let Mahalleler, Tip, ArizaGiderilmeTarihi: String
    let IlceID: Int
    let Birim: String
    let ArizaID: Int
    let ArizaDurumu, GuncellemeTarihi: String
    let ArizaTipID: Int
    let KayitTarihi, KesintiSuresi, Ongoru: String
    
}
