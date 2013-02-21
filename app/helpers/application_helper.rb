module ApplicationHelper
  def class_for_flash(name)
    case name.to_s
      when "notice"
        "alert alert-info"
      when "error"
        "alert alert-error"
      else
        "alert"
    end
  end
end
