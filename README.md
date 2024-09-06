# SUICoordinator

A simple coordinator pattern used with SwiftUI.

## How To Use
To use the coordinator, wrap your view into the **NavigationCoordinatorView**. You can just give the coordinator dependency to your next view. 
```
NavigationCoordinatorView(
            dependencies: dependencies,
            rootView: { coordinator in
                YourView(coordinator: coordinator)
            }
        )
```

If you now want to push a new **Destination** you can use the coordinator in your view.

```
struct YourView: View {
    let coordinator: any Coordinator

    var body: some View {
        Button(action: { 
            coodinator.push(YourNextDestination())
        }, label: { 
            Text("go to next page") 
        })
    }
}
```

It`s also possible to give the coordinator dependency to a ViewModel and to push your next destination from there.

Your next destination must be a struct which inherits the **Destination** protocol:
```
struct YourNextDestination: Destination {
    let identifier: String = "NextDestinationIdentifier"
    
    func makeView(with dependencies: Dependencies, coordinator: any Coordinator) -> some View {
	    YourNextView(dependencies: dependencies)
    }
}
```

The ```makeView(with:coordinator:)``` function is used to configure and instantiate your next view which will be pushed.


## AppCoordinator
**AppCoordinator** is a default coodinator class which can be used to have the basic funcionality of a coordinator: ```push```and ```pop```


## NavigationCoordinatorView
Is the root view where your stack is wrapped in. 

## TODO
- Functionality to modify Stack