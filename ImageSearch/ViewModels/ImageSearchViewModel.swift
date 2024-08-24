//
//  Created by Chen on 8/24/24.
//

import SwiftUI
import Combine

final class ImageSearchViewModel: ObservableObject {
    // make observable property to parse data after changed
    @Published var images: [ImageDataModel]? = []

    private var cancellable: AnyCancellable?

    private var dataURL = Constants.dataURL

    func getImageData(from tag: String) {
        if tag.isEmpty {
            images = []                     // empty the search result when there is no inputs
            return
        }
        guard let url = URL(string: dataURL + tag) else { return }      // Optional Binding for safely using url
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SearchDataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break                   // Nothing if successfully finished
                case .failure(let error):
                    self?.images = nil      // Display Error in Main screen if failed to fetch the data
                    print(Constants.ImageSearch.failFetchData + "\(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.images = self?.transformData(response: response)  // Transform the BE data to needed data model
            })
    }

    // Cancel ongoing task if needed.
    func cancel() {
        cancellable?.cancel()
    }

    private func transformData(response: SearchDataResponse) -> [ImageDataModel] {
        var images = [ImageDataModel]()

        // Feed image details data to the array
        response.items.forEach {
            images.append(ImageDataModel(imageURL: $0.media.values.first ?? "",  // Add default value to unwrap optional
                                         imageDetails: ImageDataModel.ImageDetails(imageURL: $0.media.values.first ?? "",
                                                                                   title: $0.title,
                                                                                   description: $0.description,
                                                                                   author: $0.author,
                                                                                   date: formattedDate(from: $0.published))))
        }
        return images
    }

    private func formattedDate(from isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()

        // Check if date is valid
        if let date = isoFormatter.date(from: isoDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium   // Choose the desired date style
            dateFormatter.timeStyle = .short    // Choose the desired time style
            return dateFormatter.string(from: date)
        }
        return Constants.ImageSearch.dateNotValid
    }
}
