class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    view = ContainerViewController.alloc.init

    @window.rootViewController = view
    @window.makeKeyAndVisible

    true
  end
end
