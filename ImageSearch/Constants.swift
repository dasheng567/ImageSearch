//
//  Created by Chen Big on 8/24/24.
//

struct Constants {
    static let dataURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    struct ImageSearch {
        static let uploadsSearched = "Here are the recent uploads from Flickr taged "
        static let imagesSearch = "Images Search"
        static let noResultFound = "No Results Found"
        static let sevicesDown = "There's something wrong with the services, please try again later."
        static let failFetchData = "Failed to fetch images: "
        static let dateNotValid = "Date not Valid"
    }

    struct ImageDetails {
        static let title = "Title"
        static let description = "Description"
        static let moreInformation = "More Information"
        static let author = "Author"
        static let publishedDate = "Published Date"
        static let imageDetails = "Image Details"
    }
}
