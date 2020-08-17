# cSwift-Package-Example

This is a simple example for creating Swift Packages with **mixed C and Swift code**.

[1. Creating the Package](https://github.com/AOx0/cSwift-Package-Example/blob/master/README.md#creating-the-package)

[2. Target with C Code](https://github.com/AOx0/cSwift-Package-Example/blob/master/README.md#target-with-c-code)

[3. Using the C Target](https://github.com/AOx0/cSwift-Package-Example/blob/master/README.md#using-the-c-target)



## Creating the Package

1. To start, create a new directory and initialize a Swift Package using the Swift Package Manager

```bash
mkdir cSwift-Package-Example
```

```bash
cd cSwift-Package-Example
```

```bash
cSwift-Package-Example % swift package init --type executable
```



Now your package's files will look like this:

**- cSwift-Package-Example/**

. . . .  **-** Package.swift

. . . .  **- Sources/**

. . . .  **- cSwift-Package-Example/**

. . . . . . . .  **-** main.swift



## Target with C Code



2. Create a new target at the `Package.swift` file. Name it whatever you want, this target is going to contain all your C code. 



3. After creating it make it a dependency for your main target. Your Package.swift should look like this:

```swift
import PackageDescription

let package = Package(
    name: "cSwift-Package-Example",
    dependencies: [],
    targets: [
        .target(name: "myCTarget"), // The C code target
        .target(
            name: "cSwift-Package-Example",
            dependencies: ["myCTarget"]), // The C code target as a dependency
    ]
)

```



4. Now create a folder with the exact name of your target inside the `Sources` folder. This folder is going to contain all our c code.

```bash
cSwift-Package-Example % cd Sources
Sources % mkdir myCTarget
Sources % cd myCTarget
```



5. Put all your C code inside the folder. I'm going to add 2 diferent files with their headers.

```bash
myCTarget % touch helloWorld1.c
myCTarget % touch helloWorld1.h

myCTarget % touch helloWorld2.c
myCTarget % touch helloWorld2.h
```

```c
// myCTarget/helloWorld1.c
  #include "HelloWorld1.h"

  void helloWorldOne() {
      printf("Hello World 1\n");
  }

// myCTarget/helloWorld1.h
  #include <stdio.h>

  void helloWorldOne(void);
```

```c
// myCTarget/helloWorld2.c
  #include "HelloWorld2.h"

  void helloWorldTwo() {
      printf("Hello World 2\n");
  }

// myCTarget/helloWorld2.h
  #include <stdio.h>

  void helloWorldTwo(void);
```



6. **Create a folder** named `include` and **move all your public headers inside it**. SwiftPM will synthesise a module map for you and you can import it in your Swift code.

   

   This `include` folder is named  **umbrella directory** and it's used by SPM to create a `module.modulemap` automatically for you, so you can import the module.

   **Note**: It is also posible to create a custom `module.modulemap` by hand.

Your directories should look like this:

**- cSwift-Package-Example/**

. . . .  **-** Package.swift

. . . .  **- Sources/**

. . . . . . . .  **- myCTarget/**				

. . . . . . . . . . . .  **- include/**

. . . . . . . . . . . . . . . .  **-** helloWorld1.h

. . . . . . . . . . . . . . . .  **-** helloWorld2.h

. . . . . . . . . . . .  **-** helloWorld1.c

. . . . . . . . . . . .  **-** helloWorld2.c

. . . . . . . .  **- cSwift-Package-Example/**

. . . . . . . . . . . .  **-** main.swift



## Using the C Target



7. **Everything is done.** Now you can import the target you created with your C files in your `main.swift` and use your C functions.

```swift
// cSwift-Package-Example/main.swift
import myCTarget

helloWorldOne()
helloWorldTwo()

```



8. In my case, I'm building the package and testing it:

```bash
cSwift-Package-Exampl % swift build
[5/5] Linking cSwift-Package-Example
```

```bash
cSwift-Package-Example % .build/x86_64-apple-macosx/debug/cSwift-Package-Example 
Hello World 1
Hello World 2
```

Everything is working.

