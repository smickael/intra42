//
//  SkillsChart.swift
//  intra42
//
//  Created by Mickaël on 29/06/2024.
//

import SwiftUI
import Charts

struct SkillsChart: View {
    let skills: [Skill]
    
    var body: some View {
        ScrollView {
            VStack {
                Chart {
                    ForEach(skills, id: \.id) { skill in
                        BarMark(
                            x: .value("Level", skill.level),
                            y: .value("Skill", skill.name),
                            width: .fixed(20)
                        )
                        .foregroundStyle(.gray)
                        .cornerRadius(8)
                        .annotation(position: .top) {
                            Text("\(skill.level, specifier: "%.2f")")
                                .font(.caption)
                                .fontDesign(.monospaced)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                    }
                }
                .chartXScale(domain: 0...20) // Set max level to 20
                .chartYAxis {
                    AxisMarks(values: skills.map { $0.name }) { value in
                        AxisValueLabel() {
                            if let name = value.as(String.self) {
                                Text(name)
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(height: CGFloat(skills.count) * 100)
            Spacer()
        }
    }
}

#Preview {
    SkillsChart(skills: [
        Skill(id: 1, name: "Web", level: 10.3),
        Skill(id: 2, name: "Mobile", level: 4.78),
        Skill(id: 3, name: "UI/UX", level: 2.4)
    ])
}
