//
//  Created by Chen on 8/24/24.
//

struct SearchDataResponse: Decodable {
    let items: [Item]

    struct Item: Decodable {
        let media: [String : String]
        let title: String
        let author: String
        let description: String
        let published: String
    }
}

struct ImageDataModel: Decodable, Hashable {
    let imageURL: String
    let imageDetails: ImageDetails

    struct ImageDetails: Decodable, Hashable {
        let imageURL: String
        let title: String
        let description: String
        let author: String
        let date: String
    }
}
