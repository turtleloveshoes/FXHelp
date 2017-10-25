> # FXHelp
A app for users of [SUMO (Support Mozilla)](http://support.mozilla.org/) to help users of us beloved web browser Firefox.

### **This branch (master)**
-----------------

### **Features**
-----------------
* Acess to guide "How Contribute" and more
* Search in Knowledge Base
* Acess to the questions of Support Forum
* Acess to the statistics about Support Forum and Knowledge Base
* You are able to activate notifications from Support Forum and Knowledge Base

### **Getting Involved**
-----------------


### **Building the code**
-----------------
1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
1. Install Carthage
    ```shell
    brew update
    brew install carthage
    ```
1. Clone the repository:
    ```shell
    git clone https://github.com/turtleloveshoes/FXHelp
    ```
1. Open `FXHelp.xcodeproj` in Xcode.
1. Build the `Velpus` scheme in Xcode.

## **Contributor guidelines**
-----------------

### Swift style
* Swift code should generally follow the conventions listed at https://github.com/raywenderlich/swift-style-guide.
  * Exception: we use 4-space indentation instead of 2.

### Whitespace
* New code should not contain any trailing whitespace.
* We recommend enabling both the "Automatically trim trailing whitespace" and "Including whitespace-only lines" preferences in Xcode (under Text Editing).
* <code>git rebase --whitespace=fix</code> can also be used to remove whitespace from your commits before issuing a pull request.

### Commits
* Each commit should have a single clear purpose. If a commit contains multiple unrelated changes, those changes should be split into separate commits.
* If a commit requires another commit to build properly, those commits should be squashed.
* Follow-up commits for any review comments should be squashed. Do not include "Fixed PR comments", merge commits, or other "temporary" commits in pull requests.
