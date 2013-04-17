class ContentViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    add_subviews
  end

  def add_subviews
    view.addSubview(label)
    view.addSubview(button)
  end

  def label
    @_label ||= UILabel.alloc.initWithFrame(CGRectMake(0, 0, 200, 60)).tap do |label|
      label.text          = 'Content View'
      label.textColor     = UIColor.blackColor
      label.center        = CGPointMake(viewport_width / 2, viewport_height / 2)
      label.textAlignment = UITextAlignmentCenter
    end
  end

  def button
    @_button ||= UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle('Test', forState: UIControlStateNormal)
      button.sizeToFit
      button.center = CGPointMake(viewport_width / 2, viewport_height / 2 + 100)
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
