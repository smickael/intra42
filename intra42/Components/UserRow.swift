//
//  UserRow.swift
//  intra42
//
//  Created by Mickaël on 26/03/2024.
//

import SwiftUI

struct UserRow: View {
    let id: Int
    let usualFullName, login: String
    let imageURL: URL?
    
    var body: some View {
        HStack {
            if let imageURL = imageURL {
                // AsyncImage because we don't know if imageURL exists
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(usualFullName)
                Text(login)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    VStack {
        UserRow(id: 123, usualFullName: "Full Name", login: "smickael", imageURL: nil)
    }
    
}
