class OverlayView < UIView
  attr_accessor :observers

  def initWithFrame(frame)
    if super
      self.frame           = frame
      self.alpha           = 0.0
      self.hidden          = true
      self.observers       = []
      self.backgroundColor = UIColor.blackColor
    end

    self
  end

  def dimWithDuration(duration)
    self.hidden = false
    animate_alpha(0.5, duration)
  end

  def undimWithDuration(duration)
    animate_alpha(0.0, duration, lambda { |finished| self.hidden = true })
  end

  def remove_observers
    observers.each { |observer| notification_center.removeObserver(observer) }
  end

  def add_observer(name, &block)
    observers << notification_center.addObserverForName(name, object: nil,
                                                              queue: main_notification_queue,
                                                              usingBlock: block)
  end

  def willMoveToWindow(window)
    if window.nil?
      remove_observers
    end
  end

  def didMoveToWindow
    if self.window
      add_observer('NavigationWillMoveDown') do |notification|
        info = notification.userInfo
        duration = info[:duration]

        dimWithDuration(duration)
      end

      add_observer('NavigationWillMoveUp') do |notification|
        info = notification.userInfo
        duration = info[:duration]

        undimWithDuration(duration)
      end
    end
  end

  def notification_center
    NSNotificationCenter.defaultCenter
  end

  def main_notification_queue
    NSOperationQueue.mainQueue
  end

  def animate_alpha(alpha, duration = 0.5, completion = nil)
    UIView.animateWithDuration(duration, animations: lambda { self.alpha = alpha },
                                    completion: completion)
  end
end
