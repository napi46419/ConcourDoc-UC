//
//  File.swift
//  
//
//  Created by Wadÿe on 24/05/2023.
//

import Vapor
import Fluent

struct CFDPresidentController: TypedController {
    let type: UserType = .cfdPresident
    
    func boot(routes: RoutesBuilder) throws {
        let controller = routes.grouped("cfd-president")
        controller.get("copies", "marked", use: getMakredCopies)
        controller.get("copies", "unmarked", use: getUnmarkedCopies)
        controller.get("copies", "third-teacher", use: getRequiringThirdTeacherCopies)
        controller.post("copies", "unmarked", use: assignTeachers)
        controller.post("copies", "third-teacher", use: assignThirdTeacher)
        controller.post("copies", "marked", "new", use: newPublishMarks)
    }
    
    func getMakredCopies(request: Request) async throws -> View {
        let user = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let copies = try await Copy.query(on: request.db)
            .with(\.$module)
            .with(\.$secretCode)
            .with(\.$candidate)
            .all()
        
        var result: [Copy.View.Marked] = []
        
        for copy in copies {
            guard let mark1 = copy.mark1, let mark2 = copy.mark2, (abs(mark1 - mark2) < 3 || copy.mark3 != nil) else {
                continue
            }
            result.append(.init(from: copy))
        }
        
        let context = Copy.Context.Marked(user: user, copies: result)
        return try await request.view.render("mark", context)
    }
    
    func getUnmarkedCopies(request: Request) async throws -> View {
        let user = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let database = request.db
        
        let copies = try await Copy.query(on: database)
            .with(\.$module)
            .with(\.$secretCode)
            .with(\.$candidate)
            .with(\.$teacher1)
            .with(\.$teacher2)
            .all()
        
        var result: [Copy.View.Unmarked] = []
        
        for copy in copies {
            guard copy.mark1 == nil, copy.mark2 == nil, copy.teacher1 == nil, copy.teacher2 == nil else {
                continue
            }
            result.append(.init(from: copy))
        }
        
        let teachers = try await User.query(on: database)
            .filter(\.$type == .teacher)
            .all()
        
        let context = Copy.Context.Unmarked(user: user, copies: result, teachers: teachers)
        return try await request.view.render("affect_teacher", context)
    }
    
    func getRequiringThirdTeacherCopies(request: Request) async throws -> View {
        let user = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let database = request.db
        
        let copies = try await Copy.query(on: database)
            .with(\.$module)
            .with(\.$secretCode)
            .with(\.$candidate)
            .with(\.$teacher3)
            .all()
        
        var result: [Copy.View.RequiringThirdTeacher] = []
        
        for copy in copies {
            guard let mark1 = copy.mark1, let mark2 = copy.mark2, copy.teacher3 == nil else {
                continue
            }
            if abs(mark1 - mark2) >= 3 {
                result.append(.init(from: copy))
            }
        }
        
        let teachers = try await User.query(on: request.db)
            .filter(\.$type == .teacher)
            .all()
        
        let context = Copy.Context.RequiringThirdTeacher(user: user, copies: result, teachers: teachers)
        return try await request.view.render("third_teacher", context)
    }
    
    func assignTeachers(request: Request) async throws -> Response {
        let database = request.db
        
        let jsonData = try request.content.decode(Copy.JSON.AssignTeachers.self)
        
        guard let copy = try? await Copy.find(jsonData.copyID, on: database) else {
            throw Abort(.notFound, reason: "Could not find copy in database.")
        }
        
        copy.$teacher1.id = jsonData.teacher1ID
        copy.$teacher2.id = jsonData.teacher2ID
        
        try await copy.save(on: database)
        
        return request.redirect(to: "/cfd-president/copies/unmarked")
    }
    
    func assignThirdTeacher(request: Request) async throws -> Response {
        let database = request.db
        
        let jsonData = try request.content.decode(Copy.JSON.AssignThirdTeacher.self)
        
        guard let copy = try? await Copy.find(jsonData.copyID, on: request.db) else {
            throw Abort(.notFound, reason: "Could not find copy in database.")
        }
        
        copy.$teacher3.id = jsonData.teacher3ID
        try await copy.update(on: database)
        
        return request.redirect(to: "/cfd-president/copies/third-teacher")
    }
    
    func newPublishMarks(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let copies = try await Copy.query(on: request.db)
            .with(\.$module)
            .with(\.$secretCode)
            .with(\.$candidate)
            .all()
        
        var markedCopies: [Copy.View.Marked] = []
        
        for copy in copies {
            guard let mark1 = copy.mark1, let mark2 = copy.mark2, (abs(mark1 - mark2) < 3 || copy.mark3 != nil) else {
                continue
            }
            markedCopies.append(.init(from: copy))
        }
        
        let candidateIDs = markedCopies.map { $0.candidateID }.uniqued()
        
        for id in candidateIDs {
            let copies = try await Copy.query(on: request.db)
                .with(\.$candidate)
                .filter(\.$candidate.$id == id)
                .all()
            
            guard copies.count == 2 else {
                continue
            }
            
            let finalMarks: [Float] = copies.map { copy in
                if let mark3 = copy.mark3 {
                    return mark3
                }
                return max(copy.mark1!, copy.mark2!)
            }
            
            let average = (finalMarks[0]+finalMarks[1])*2/3
            
            let result = Result(candidateID: id, value: average)
            try await result.save(on: request.db)
            
            for copy in copies {
                try await copy.delete(on: request.db)
            }
            
        }
        
        print(candidateIDs)
        return request.redirect(to: "/cfd-president/copies/marked")
    }
}

extension Array where Element: Hashable {
    func uniqued() -> Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
