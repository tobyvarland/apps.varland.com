module ApplicationHelper

  include Pagy::Frontend

  def fa(icon, options = {})
    fw = options.fetch(:fw, true)
    type = options.fetch(:type, "fas")
    text_class = options.fetch(:text_class, nil)
    classes = ["fa-#{icon}", type]
    classes << "fa-fw" if fw
    classes << text_class unless text_class.blank?
    content_tag(:i, nil, class: classes)
  end

  def primary_nav_link(icon, text, url, options = {})
    type = options.fetch(:type, "fas")
    text_class = options.fetch(:text_class, "")
    badge = options.fetch(:badge, nil)
    badge_class = options.fetch(:badge_class, "bg-primary")
    badge_text_class = options.fetch(:badge_text_class, "text-white")
    link_class = options.fetch(:link_class, [])
    icon = fa(icon, type: type, text_class: text_class)
    text = content_tag(:span, text, class: ["label", text_class])
    badge = badge.nil? ? "" : content_tag(:div, badge, class: ["badge", "rounded-pill", badge_class, badge_text_class])
    html = content_tag(:div, icon + text + badge, class: ["d-flex", "flex-row", "align-items-center", "justify-content-start"])
    link_to_unless_current(html, url, class: ["nav-link"] + link_class) do content_tag(:div, html, class: "navbar-text px-md-2") end
  end

  def flash_message(msg, type)
    message = content_tag(:div, msg.html_safe, class: "message")
    icon = case type
           when :alert then content_tag(:div, fa("exclamation"), class: ["icon", "flash-alert"])
           else content_tag(:div, fa("info"), class: ["icon", "flash-notice"])
           end
    inner = content_tag(:div, icon + message, class: ["flash-message", "bg-light", "rounded", "shadow-sm"])
    return content_tag(:div, inner, class: ["col-12", "px-3"])
  end

  def home_page_link(icon, text, url, options = {})
    tooltip = options.fetch(:tooltip, nil)
    link_text = content_tag(:div, text.html_safe, class: "text")
    icon = content_tag(:div, fa(icon), class: "icon")
    if tooltip.blank?
      link = link_to(icon + link_text, url, class: "home-page-link", target: "_blank")
    else
      link = link_to(icon + link_text, url, class: "home-page-link", target: "_blank", title: tooltip, data: {"bs-toggle": "tooltip", "bs-placement": "top", "bs-html": "true"})
    end
    return content_tag(:div, link, class: ["col-12", "col-md-3"])
  end

end