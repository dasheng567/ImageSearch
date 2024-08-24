//
//  Created by Chen on 8/24/24.
//

import SwiftUI

struct ImageSearchView: View {
    // Adding observable properties
    @StateObject private var viewModel = ImageSearchViewModel()
    @State private var searchText = ""

    // Setup three columns for the grid view
    private let gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            // Add introduction label
            Text(Constants.ImageSearch.uploadsSearched + searchText)
                .onChange(of: searchText) { newValue in
                    viewModel.getImageData(from: newValue)
                }
                .navigationTitle(Constants.ImageSearch.imagesSearch)

            // Optional binding to safely display images
            if let images = viewModel.images {
                // Make screen scrollable
                ScrollView {
                    // Inform user no data found
                    if images.isEmpty && !searchText.isEmpty {
                        Text(Constants.ImageSearch.noResultFound)
                            .bold()
                            .frame(alignment: .center)
                            .padding()
                    }
                    // Add grid view to display images
                    LazyVGrid(columns: gridItems) {
                        ForEach(images, id: \.self) { imageData in
                            // Add navigation to the images
                            NavigationLink(destination: ImageDetailsView(detailsModel: imageData.imageDetails)) {
                                // Dislay image
                                AsyncImage(url: URL(string: imageData.imageURL)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()          // Add progress indicator
                                }
                            }
                        }
                        .padding()
                    }
                }
            } else {
                // Display error information when services are down
                Text(Constants.ImageSearch.sevicesDown)
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
