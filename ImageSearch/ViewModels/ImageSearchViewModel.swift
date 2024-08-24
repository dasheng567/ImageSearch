//
//  Created by Chen on 8/24/24.
//

import SwiftUI
import Combine

final class ImageSearchViewModel: ObservableObject {
    @Published var images: [ImageDataModel]? = []

    private var cancellable: AnyCancellable?

    private var dataURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    func getImageData(from tag: String) {
        if tag.isEmpty {
            images = []
            return
        }
        guard let url = URL(string: dataURL + tag) else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SearchDataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.images = nil
                    print("Failed to fetch images: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.images = self?.transformData(response: response)
            })
    }

    func cancel() {
        cancellable?.cancel()
    }

    private func transformData(response: SearchDataResponse) -> [ImageDataModel] {
        var images = [ImageDataModel]()
        response.items.forEach {
            images.append(ImageDataModel(imageURL: $0.media.values.first ?? "",
                                         imageDetails: ImageDataModel.ImageDetails(imageURL: $0.media.values.first ?? "",
                                                                                   title: $0.title,
                                                                                   description: $0.description,
                                                                                   author: $0.author,
                                                                                   date: $0.published)))
        }
        return images
    }
}
