class ContainerViewController < UIViewController
  BUTTON_SIDE_LENGTH = 100

  def viewDidLoad
    super

    view.frame           = UIScreen.mainScreen.bounds
    view.backgroundColor = UIColor.clearColor

    addChildViewController(content_view_controller)

    view.addSubview(content_view_controller.view)
    view.addSubview(bottom_left_button)
    view.addSubview(overlay_view)
    view.addSubview(pull_down_view)
  end

  def content_view_controller
    @_content_view_controller ||= ContentViewController.alloc.init
  end

  def overlay_view
    @_overlay_view ||= OverlayView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def pull_down_view
    @_pull_down_view ||= PullDownView.alloc.initWithFrame(viewport_size)
  end

  def bottom_left_button
    @_bottom_left_button ||= UIButton.alloc.initWithFrame(CGRectMake(0, 0, BUTTON_SIDE_LENGTH , BUTTON_SIDE_LENGTH)).tap do |button|
      button.center          = CGPointMake(viewport_width, viewport_height)
      button.transform       = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      button.backgroundColor = UIColor.blackColor
      button.addTarget(self, action: 'button_pressed:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def button_pressed(sender)
    alert = UIAlertView.alloc.initWithTitle('You pressed the button',
                                            message: nil,
                                            delegate: nil,
                                            cancelButtonTitle: 'Sure did.',
                                            otherButtonTitles: nil)
    alert.show
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
