class NavigationScrollView < UIScrollView
  attr_accessor :starting_y_position, :parent_view

  def initWithFrame(frame)
    if super
      self.delegate        = self
      self.bounces         = false
      self.scrollsToTop    = false
      self.contentSize     = CGSizeMake(size.width, size.height + 300)
      self.contentOffset   = CGPointMake(0, 300)
      self.backgroundColor = UIColor.clearColor
      self.showsVerticalScrollIndicator = false
    end

    self
  end

  def layoutSubviews
    addSubview(navigation)
    addSubview(label)
    addSubview(handle)
  end

  def hitTest(point, withEvent: event)
    super if CGRectContainsPoint(handle.frame, point)
  end

  def label
    @_label ||= UILabel.alloc.initWithFrame(CGRectMake(0, 0, 200, 60)).tap do |label|
      label.textColor = UIColor.blackColor
      label.center = CGPointMake(size.width / 2, size.height / 2)
      label.textAlignment = UITextAlignmentCenter
      label.text = 'Navigation'
    end
  end

  def handle
    @_handle ||= UIView.alloc.initWithFrame(CGRectMake(0, 0, 100 , 100)).tap do |handle|
      handle.center = CGPointMake(0, 300)
      handle.transform = CGAffineTransformMakeRotation(Math.degrees_to_radians(45))
      handle.backgroundColor = UIColor.blackColor
    end
  end

  def navigation
    @_navigation ||= UIView.alloc.initWithFrame(CGRectMake(0, 0, size.width, 300)).tap do |nav|
      nav.backgroundColor = UIColor.blackColor
    end
  end

  def scrollViewWillBeginDragging(scroll_view)
    update_starting_y_position(contentOffset.y)
  end

  def update_starting_y_position(y_position)
    self.starting_y_position = y_position
  end

  def scrollViewDidEndDragging(scroll_view, willDecelerate: decelerate)
    if navigation_moved_down?
      move_navigation_down
      dim_superview
    elsif navigation_moved_up?
      move_navigation_up
      undim_superview
    end
  end

  def navigation_moved_down?
    starting_y_position > contentOffset.y
  end

  def navigation_moved_up?
    starting_y_position < contentOffset.y
  end

  def dim_superview
    animate_parent_background_color(UIColor.grayColor)
  end

  def undim_superview
    animate_parent_background_color(UIColor.whiteColor)
  end

  def animate_parent_background_color(color)
    UIView.beginAnimations(nil, context:nil)
    UIView.setAnimationDuration(0.5)
    parent_view.view.backgroundColor = color
    UIView.commitAnimations
  end

  def move_navigation_up
    move_to_offset(CGPointMake(0, 300))
  end

  def move_navigation_down
    move_to_offset(CGPointMake(0, 0))
  end

  def move_to_offset(offset)
    UIView.beginAnimations(nil, context:nil)
    UIView.setAnimationCurve(UIViewAnimationCurveEaseOut)
    UIView.setAnimationDuration(0.5)
    self.contentOffset = offset
    UIView.commitAnimations
  end
end
