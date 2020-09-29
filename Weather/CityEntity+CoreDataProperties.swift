//
//  CityEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Eddy R on 29/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var cp: String?

}
