class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    view = ViewController.alloc.initWithNibName(nil, bundle: nil)

    @window.rootViewController = view
    @window.makeKeyAndVisible

    true
  end
end
