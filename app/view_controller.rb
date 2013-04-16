class ViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    NavigationScrollView.alloc.initWithFrame(viewport_size).tap do |nav_view|
      nav_view.parent_view = self
      view.insertSubview(nav_view, atIndex: 100)
    end

    view.insertSubview(button, atIndex: 0)
  end

  def viewport_size
    CGRectMake(0, 0, view.size.width, view.size.height)
  end

  def button_pressed(sender)
    alert = UIAlertView.alloc.initWithTitle('You pressed the button',
                                            message: nil,
                                            delegate: nil,
                                            cancelButtonTitle: 'Sure did.',
                                            otherButtonTitles: nil)
    alert.show
  end

  def button
    UIButton.alloc.initWithFrame(CGRectMake(0, 0, 100 , 100)).tap do |button|
      button.center          = CGPointMake(view.size.width, view.size.height)
      button.transform       = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      button.backgroundColor = UIColor.blackColor
      button.addTarget(self, action: 'button_pressed:', forControlEvents: UIControlEventTouchUpInside)
    end
  end
end
