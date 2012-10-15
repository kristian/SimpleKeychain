SimpleKeychain
=================

This project allows to access the iOS keychain very easily. I wanted to create a simple, easy to use and flexible keychain access class for *iPhone* and *iPad*. Existing projects aim to put certain values into the keychain, like username and password. I wanted to add any value to the keychain in a dictionary style use.

The class uses the `Security` framework and the `NSKeyedArchiver` to add any kind of data to the keychain, so there is no need to include any additional resources. The code is very compact (only *80 lines*) any easy to understand. Simply get the default keychain instance and add any values to it, like adding them to a `NSDictionary`. That's it.

Please give support so I can continue to make SimpleKeychain even more awesome!

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4S886F7EHPR6Q">
<img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" />
</a>

Your help is much appreciated. Please send pull requests for useful additions you make or ask me what work is required.

License
-------

It is open source and covered by a standard MIT license. That means you have to mention *Kristian Kraljic (dikrypt.com, ksquared.de)* as the original author of this code. You can purchase a Non-Attribution-License from me.

Documentation
-------------

*Sorry, I'm to lazy to create a documentation for a single class…* ~~Documentation can be [browsed online](http://kayk.github.com/SimpleKeychain) or installed in your Xcode Organizer via the [Atom Feed URL](http://kayk.github.com/SimpleKeychain/SimpleKeychain.atom).~~

Usage
-----

SimpleKeychain needs a minimum iOS deployment target of 4.3 because of:

- Security
- ARC

The best way to use SimpleKeychain with Xcode 4.2 is to add the source files to your Xcode project with the following steps.

1. Download SimpleKeychain as a subfolder of your project folder
2. Open the destination project and drag the folder as a subordinate item in the Project Navigator (Copy all classes and headers)
3. In your prefix.pch file add:
	
		#import "SimpleKeychain.h"

4. In your application target's Build Phases add the following framework to the Link Binary With Libraries phase (you can also do this from the Target's Summary view in the Linked Frameworks and Libraries):

		Security.framework

5. Go to File: Project Settings… and change the derived data location to project-relative.
6. Add the DerivedData folder to your git ignore. 
7. In your application's target Build Settings:
	- If your app does not use ARC yet (but SimpleKeychain does) then you need to add the the -fobjc-arc linker flag to the app target's "Other Linker Flags".

If you do not want to deal with Git submodules simply add SimplePopoverView to your project's git ignore file and pull updates to SimplePopoverView as its own independent Git repository. Otherwise you are free to add SimplePopoverView as a submodule.

Known Issues
------------

*None, so far… Yay!*

If you find an issue then you are welcome to fix it and contribute your fix via a GitHub pull request.