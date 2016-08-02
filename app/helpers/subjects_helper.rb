module SubjectsHelper
  # Returns a dynamic path based on the provided parameters
  def sti_subject_path(type = "subject", subject = nil, action = nil)
  	send "#{format_sti(action, type, subject)}_path", subject
  end
 
  def format_sti(action, type, subject)
    action || subject ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
 
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
