//
//  ProjectRow.swift
//  intra42
//
//  Created by Mickaël on 30/03/2024.
//

import SwiftUI

struct ProjectRow: View {
    let project: ProjectsUser
    
    var body: some View {
        HStack {
            Text(project.project.name)
            Spacer()
            
            let statusColor = getStatusColor(for: project.status, validated: project.validated)
            let borderColor = statusColor.darken(by: 0.2)
            
            
            Text(project.status.rawValue)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .foregroundStyle(.white)
                .background(statusColor)
                .cornerRadius(6)
                .font(.system(size: 10))
                .fontWeight(.semibold)
                .textCase(.uppercase)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(borderColor, lineWidth: 2)
                )
            Text(project.finalMark != nil ? "\(project.finalMark!)" : "")
//            Circle()
//                .foregroundColor(getStatusColor(for: project.status, validated: project.validated))
//                .frame(width: 10, height: 10)
        }
    }
    
    private func getStatusColor(for status: Status, validated: Bool?) -> Color {
        switch status {
        case .finished where validated == true, .success:
            return .green
        case .inProgress, .waitingGrading, .waitingCorrection:
            return .orange
        case .searchingGroup, .creatingGroup:
            return .cyan
        default:
            return .red
        }
    }
}

extension Color {
    func darken(by percentage: CGFloat = 0.1) -> Color {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return Color(hue: hue, saturation: saturation, brightness: max(brightness - percentage, 0), opacity: alpha)
    }
}

#Preview {
    ProjectRow(project: ProjectsUser(
        id: 2146197,
        occurrence: 0,
        finalMark: 104,
        status: .finished,
        validated: true,
        currentTeamID: 3529123,
        project: Project(
            id: 1479,
            name: "ft_ls",
            slug: "42cursus-ft_ls",
            parentID: nil
        ),
        cursusIDS: [21],
        markedAt: "2018-09-16T18:47:19.000Z",
        marked: true,
        retriableAt: "2021-04-03T03:02:29.817Z",
        createdAt: "2021-04-03T03:02:29.817Z",
        updatedAt: "2021-04-03T03:02:29.817Z"
    ))
}
