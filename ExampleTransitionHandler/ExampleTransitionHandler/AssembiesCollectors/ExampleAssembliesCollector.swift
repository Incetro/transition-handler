//
//  ExampleAssembliesCollector.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28.01.2021.
//

import Swinject

// MARK: - ExampleAssembliesCollector

final class ExampleAssembliesCollector: AssembliesCollector {

    required init() {
    }

    func collect(inContainer container: Container) {

        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)

        objc_getClassList(autoreleasingTypes, Int32(typeCount))

        for index in 0..<typeCount {
            if let assemblyType = (types[index] as? CollectableAssembly.Type) {
                let object = assemblyType.init()
                object.assemble(inContainer: container)
            }
        }

        types.deallocate()
    }
}
