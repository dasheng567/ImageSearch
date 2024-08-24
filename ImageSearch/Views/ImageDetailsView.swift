//
//  Created by Chen on 8/24/24.
//

import SwiftUI

struct ImageDetailsView: View {
    let detailsModel: ImageDataModel.ImageDetails

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Display Image
                    AsyncImage(url: URL(string: detailsModel.imageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }

                    Spacer(minLength: 16.0)

                    // Display the title of the image
                    HStack {
                        Text(Constants.ImageDetails.title)
                            .fontWeight(.bold)
                            .frame(width: 150, alignment: .leading)
                        Text(detailsModel.title)
                    }

                    Spacer(minLength: 16.0)

                    // Display the information link of the image
                    HStack {
                        Text(Constants.ImageDetails.description)
                            .fontWeight(.bold)
                            .frame(width: 150, alignment: .leading)
                        NavigationLink(destination: ImageWebView(htmlContent: detailsModel.description)) {
                            Text(Constants.ImageDetails.moreInformation)
                        }

                    }

                    Spacer(minLength: 16.0)

                    // Display the author of the image
                    HStack {
                        Text(Constants.ImageDetails.author)
                            .fontWeight(.bold)
                            .frame(width: 150, alignment: .leading)
                        Text(detailsModel.author)
                    }

                    Spacer(minLength: 16.0)

                    // Display the published data of the image
                    HStack {
                        Text(Constants.ImageDetails.publishedDate)
                            .fontWeight(.bold)
                            .frame(width: 150, alignment: .leading)
                        Text(detailsModel.date)
                    }
                }
                .padding()
                .navigationTitle(Constants.ImageDetails.imageDetails)
            }
        }
    }
}
