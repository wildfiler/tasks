module ApplicationHelper
  def bootstrap_alert_type_for(flash_type)
    case flash_type
      when :success
        "success"
      when :error
        "danger"
      when :alert
        "warning"
      when :notice
        "info"
      else
        flash_type.to_s
    end
  end

  def flash_message(flash)
    return nil if flash.empty?
    flash.map do |type, message|
      {
        message: { text: message },
        type: bootstrap_alert_type_for(type)
      }
    end
  end
end
