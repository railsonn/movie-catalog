module ApplicationHelper
  def format_email(email)
    email.split('@').first.capitalize 
  end
end
