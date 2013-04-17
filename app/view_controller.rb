class ViewController < UIViewController
  attr_accessor :observers

  BUTTON_SIDE_LENGTH = 100

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    view.addSubview(button)

    self.observers = []

    NavigationScrollView.alloc.initWithFrame(viewport_size).tap do |nav_view|
      view.addSubview(nav_view)
    end
  end

  def viewWillAppear(animated)
    add_observer('NavigationWillMoveDown') do |notification|
      dim_view
      disable_controls
    end

    add_observer('NavigationWillMoveUp') do |notification|
      undim_view
      enable_controls
    end
  end

  def viewWillDisappear(animated)
    observers.each { |observer| notification_center.removeObserver(observer) }
  end

  def add_observer(name, &block)
    observers << notification_center.addObserverForName(name,
                                                        object: nil,
                                                        queue: main_notification_queue,
                                                        usingBlock: block)
  end

  def enable_controls
    controls_to_disable.each { |control| control.enabled = true }
  end

  def disable_controls
    controls_to_disable.each { |control| control.enabled = false }
  end

  def dim_view
    animate_background_color(UIColor.grayColor)
  end

  def undim_view
    animate_background_color(UIColor.whiteColor)
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
    @_button ||= UIButton.alloc.initWithFrame(CGRectMake(0, 0, BUTTON_SIDE_LENGTH , BUTTON_SIDE_LENGTH)).tap do |button|
      button.center          = CGPointMake(viewport_width, viewport_height)
      button.transform       = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      button.backgroundColor = UIColor.blackColor
      button.addTarget(self, action: 'button_pressed:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def main_notification_queue
    NSOperationQueue.mainQueue
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

  def animate_background_color(color)
    UIView.animateWithDuration(0.5, animations: lambda {
      view.backgroundColor = color
    })
  end
end
