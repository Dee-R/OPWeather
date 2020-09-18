import Foundation

struct City: Decodable {
    let id:Int
    let name: String
    let state:String
    let country:String
    let coord:[String:Double]
    
    enum DecodinError: Error {
        case missingFile
    }
    
}

extension Array where Element == City {
    init(filename: String) throws{
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw City.DecodinError.missingFile
        }
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self = try decoder.decode([City].self, from: data)
    }
}

/**
 coord =         {
 lat = "15.72377";
 lon = "42.995819";
 };
 country = YE;
 id = 77504;
 name = "Az Zuhrah";
 state = "";
 */

