class ContainerViewController < UIViewController
  attr_accessor :observers

  BUTTON_SIDE_LENGTH = 100

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    self.addChildViewController(content_view_controller)
    view.addSubview(content_view_controller.view)

    self.observers = []

    view.addSubview(pull_down_view)
    view.addSubview(bottom_left_button)
  end

  def content_view_controller
    @_content_view_controller ||= ContentViewController.alloc.init
  end

  def viewWillAppear(animated)
    add_observer('NavigationWillMoveDown') do |notification|
      disable_controls
    end

    add_observer('NavigationWillMoveUp') do |notification|
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

  def controls_to_disable
    [bottom_left_button]
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def main_notification_queue
    NSOperationQueue.mainQueue
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
