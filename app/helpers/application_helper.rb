module ApplicationHelper

  def alert_message(class_name, closable = true, &block)
    text = capture(&block) if block_given?
    alert_classes = ['alert', "alert-#{class_name}"]
    alert_classes << 'alert-dismissible' if closable
    content_tag(:div, class: alert_classes) do
      concat(content_tag(:button, '&times;'.html_safe, class: 'close', 'data-dismiss' => 'alert')) if closable
      concat(text)
    end
  end

end
