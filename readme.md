TIMAppLocator is a tiny Cocoa class for getting the file paths of all instances of an application identified by its bundle identifier that exist on your local system. It needs Spotlight to be enabled in order to work (which it is by default) and at least Xcode 4.4 and OS X 10.7. 

###How does it work
TIMAppLocator uses a file system metadata query to find all instances of an application, identified by its bundle identifier, which are installed on your local system. It does so in a way very similar to typing 

> mdfind "kMDItemCFBundleIdentifier == 'com.apple.Safari"

at the command line. 

###How to use it
Drop the class and the protocol declaration into your project and use the TIMAppLocator object like this:

	TIMAppLocator *appLocator = [[TimAppLocator alloc] init];
	[self.appLocator setDelegate:self];
	[self.appLocator locateAppWithBundleIdentifier:@"com.apple.Safari"];

Don’t forget to include the protocol in your class definition, e.g. like this:

	@interface AppDelegate : NSObject <NSApplicationDelegate, TIMAppLocatorProtocol>

The TIMAppLocator instance will call its delegate once it has finished gathering the locations of where the application associated with the bundle identifier, passing them on in an array of file paths:

	-(void)appLocations:(NSArray*)locations;

If something goes wrong while initializing the object, the *locateAppWithBundleIdentifier* method will return NO. If no installation of the application associated with the bundle identifier was found, the *appLocations* method will pass on *nil* instead of an array.

###License

Copyright (c) 2013 Tim Schröder

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.