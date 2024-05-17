//
//  File.swift
//  
//
//  Created by Wadÿe on 24/05/2023.
//

import Vapor
import Fluent

struct TeacherController: TypedController {
    let type: UserType = .teacher
    
    func boot(routes: RoutesBuilder) throws {
        let controller = routes.grouped("teacher")
        controller.get(use: getAssignedCopies)
        controller.post(use: sendMarks)
    }
    
    func getAssignedCopies(request: Request) async throws -> View {
        let teacher = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let database = request.db
        
        let copiesAsTeacher1 = try await Copy.query(on: database)
            .with(\.$module)
            .with(\.$secretCode)
            .join(User.self, on: \Copy.$teacher1.$id == \User.$id)
            .filter(\.$teacher1.$id == teacher.id)
            .all()
        
        let copiesAsTeacher2 = try await Copy.query(on: database)
            .with(\.$module)
            .with(\.$secretCode)
            .join(User.self, on: \Copy.$teacher2.$id == \User.$id)
            .filter(\.$teacher2.$id == teacher.id)
            .all()
        
        let copiesAsTeacher3 = try await Copy.query(on: database)
            .with(\.$module)
            .with(\.$secretCode)
            .join(User.self, on: \Copy.$teacher3.$id == \User.$id)
            .filter(\.$teacher3.$id == teacher.id)
            .all()
        
        let rawAssignedCopies = copiesAsTeacher1 + copiesAsTeacher2 + copiesAsTeacher3
        
        let assignedCopies = rawAssignedCopies.map { copy in
            return Copy.View.TeacherPerspective(from: copy)
        }
        
        let context = Copy.Context.TeacherPerspective(teacher: teacher, copies: assignedCopies)
        
        return try await request.view.render("Teacher", context)
    }
    
    fileprivate func extractedFunc(_ copy: Copy, _ teacher: User) {
        if copy.teacher1 != nil {
            if copy.$teacher1.id == teacher.id {
                copy.teacher1 = nil
            }
        }
        
        if copy.teacher2 != nil {
            if copy.$teacher2.id == teacher.id {
                copy.teacher2 = nil
            }
        }
        
        if copy.teacher3 != nil {
            if copy.$teacher3.id == teacher.id {
                copy.teacher3 = nil
            }
        }
    }
    
    func sendMarks(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        print("Decoding...")
        
        let decoder = JSONDecoder()
        let jsonData = try request.content.decode([Copy.JSON.TeacherPerspective].self, using: decoder)
        print(jsonData)
        
        for data in jsonData {
            print("Updating copy...")
            guard let copy = try? await Copy.find(data.copyID, on: request.db) else {
                throw Abort(.notFound, reason: "Could not find copy in database.")
            }
            
            let mark = data.mark
            
            guard copy.mark1 != nil else {
                copy.mark1 = mark
                print("Saving as mark1")
                try await copy.update(on: request.db)
                continue
            }
            print("mark1 already exists. Trying mark2...")
            
            guard copy.mark2 != nil else {
                copy.mark2 = mark
                print("Saving as mark2")
                try await copy.update(on: request.db)
                continue
            }
            print("mark2 already exists. Trying mark3...")
            
            guard copy.mark3 != nil else {
                copy.mark3 = mark
                print("Saving as mark3")
                try await copy.update(on: request.db)
                continue
            }
            print("mark3 already exists. No update can be done.")
            
        }
        
        return request.redirect(to: "/teacher")
    }
}
