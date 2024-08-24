//
//  Created by Chen on 8/24/24.
//

import SwiftUI

struct ImageSearchView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    @State private var searchText = ""

    private let gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            Text("Here are the recent uploads from Flickr taged \(searchText)")
                .onChange(of: searchText) { newValue in
                    viewModel.getImageData(from: newValue)
                }
                .navigationTitle("Images Search")
            if let images = viewModel.images {
                ScrollView {
                    if images.isEmpty && !searchText.isEmpty {
                        Text("No Search Found")
                            .bold()
                            .frame(alignment: .center)
                            .padding()
                    }
                    LazyVGrid(columns: gridItems) {
                        ForEach(images, id: \.self) { imageData in
                            AsyncImage(url: URL(string: imageData.imageURL)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Text("There's something wrong with the services, please try again later.")
                    .bold()
                    .padding()
            }
        }
        .searchable(text: $searchText)
    }
}

struct ImageSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSearchView()
    }
}
