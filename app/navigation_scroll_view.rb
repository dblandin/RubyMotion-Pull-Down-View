class NavigationScrollView < UIScrollView
  attr_accessor :starting_y_position, :parent

  NAVIGATION_HEIGHT  = 300
  BUTTON_SIDE_LENGTH = 100

  def initWithFrame(frame)
    if super
      self.delegate        = self
      self.bounces         = false
      self.scrollsToTop    = false
      self.contentSize     = CGSizeMake(scroll_view_width, scroll_view_height + NAVIGATION_HEIGHT)
      self.contentOffset   = CGPointMake(0, NAVIGATION_HEIGHT)
      self.backgroundColor = UIColor.clearColor
      self.showsVerticalScrollIndicator = false
    end

    addSubview(navigation)
    addSubview(label)
    addSubview(handle)

    self
  end

  def hitTest(point, withEvent: event)
    super if CGRectContainsPoint(handle.frame, point) || CGRectContainsPoint(navigation.frame, point)
  end

  def scrollViewWillBeginDragging(scroll_view)
    update_starting_y_position(contentOffset.y)
  end

  def scrollViewDidEndDragging(scroll_view, willDecelerate: decelerate)
    if navigation_moved_down?
      move_navigation_down
    elsif navigation_moved_up?
      move_navigation_up
    end
  end

  def navigation
    @_navigation ||= UIView.alloc.initWithFrame(CGRectMake(0, 0, size.width, NAVIGATION_HEIGHT)).tap do |nav|
      nav.backgroundColor = UIColor.blackColor
    end
  end

  def handle
    @_handle ||= UIView.alloc.initWithFrame(CGRectMake(0, 0, BUTTON_SIDE_LENGTH , BUTTON_SIDE_LENGTH)).tap do |handle|
      handle.center          = CGPointMake(0, NAVIGATION_HEIGHT)
      handle.transform       = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      handle.backgroundColor = UIColor.blackColor
    end
  end

  def label
    @_label ||= UILabel.alloc.initWithFrame(CGRectMake(0, 0, 200, 60)).tap do |label|
      label.text          = 'Navigation'
      label.textColor     = UIColor.blackColor
      label.center        = CGPointMake(scroll_view_width / 2, NAVIGATION_HEIGHT / 2)
      label.textAlignment = UITextAlignmentCenter
    end
  end

  def scroll_view_height
    size.height
  end

  def scroll_view_width
    size.width
  end

  def update_starting_y_position(y_position)
    self.starting_y_position = y_position
  end

  def navigation_moved_down?
    starting_y_position > contentOffset.y
  end

  def navigation_moved_up?
    starting_y_position < contentOffset.y
  end

  def navigation_is_down?
    contentOffset.y === 0
  end

  def navigation_is_up?
    contentOffset.y === NAVIGATION_HEIGHT
  end

  def dim_superview
    animate_parent_background_color(UIColor.grayColor)
  end

  def undim_superview
    animate_parent_background_color(UIColor.whiteColor)
  end

  def animate_parent_background_color(color)
    UIView.animateWithDuration(0.5, animations: lambda {
      parent_view.backgroundColor = color if parent
    })
  end

  def parent_view
    parent.view
  end

  def move_navigation_up
    move_to_offset(CGPointMake(0, NAVIGATION_HEIGHT))
  end

  def move_navigation_down
    move_to_offset(CGPointMake(0, 0))
  end

  def move_to_offset(offset)
    UIView.animateWithDuration(0.5, animations: lambda {
      UIView.setAnimationCurve(UIViewAnimationCurveEaseOut)
      self.contentOffset = offset
    })
  end
end
