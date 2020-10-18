module ApplicationHelper
  def login_helper
    unless user_signed_in?
      (content_tag :li, class: active_link(new_user_session_path) do
        link_to "Login", new_user_session_path, class: "nav-link"
      end) +
      (content_tag :li, class: active_link(new_user_registration_path) do
        link_to "Register", new_user_registration_path, class: "nav-link"
        end)
    else
      (content_tag :li, class: active_link(edit_registration_path(current_user)) do
        link_to "Personal Info View", edit_registration_path(current_user), class: "nav-link"
      end) +
      (content_tag :li do
        link_to "Logged as #{current_user.role.capitalize}: #{current_user.full_name}, click her to logout", destroy_user_session_path, method: :delete, class: "nav-link"
      end)
    end
  end

  def active_link(link)
    (current_page? link) ? "active" : ""
  end
  FLASH_MAPPINGS = {
      'error' => 'danger',
      'alert' => 'warning',
      'notice' => 'success',
      'success' => 'info'
  }.freeze

  def render_flash(keep = false)
    inner_html = ''
    flash.each do |type, message|
      message = Array(message)
      message = message.join("<br/>")
      next unless type.in? %w[error alert notice success]
      next if message.blank?
      type = FLASH_MAPPINGS.fetch(type)
      inner_html += content_tag(:div,
                                content_tag(:button, '<span aria-hidden="true">&times;</span>'.html_safe,
                                            class: 'close',
                                            area: {label: "Close"},
                                            data: { dismiss: 'alert' }) +
                                    message.to_s.html_safe,
                                class: "alert alert-#{type} alert-dismissible mt-3")
    end
    flash.clear unless keep
    content_tag(:div, inner_html.html_safe, id: 'flash-section')
  end
end
