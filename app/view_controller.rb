class ViewController < UIViewController
  BUTTON_SIDE_LENGTH = 100

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    view.addSubview(button)

    NavigationScrollView.alloc.initWithFrame(viewport_size).tap do |nav_view|
      nav_view.parent = self
      view.addSubview(nav_view)
    end
  end

  def enable_controls
    controls_to_disable.each do |control|
      control.enabled = true
    end
  end

  def disable_controls
    controls_to_disable.each do |control|
      control.enabled = false
    end
  end

  def controls_to_disable
    [button]
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
    UIButton.alloc.initWithFrame(CGRectMake(0, 0, BUTTON_SIDE_LENGTH , BUTTON_SIDE_LENGTH)).tap do |button|
      button.center          = CGPointMake(viewport_width, viewport_height)
      button.transform       = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      button.backgroundColor = UIColor.blackColor
      button.addTarget(self, action: 'button_pressed:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def viewport_size
    CGRectMake(0, 0, viewport_width, viewport_height)
  end

  def viewport_width
    view.size.width
  end

  def viewport_height
    view.size.height
  end
end
