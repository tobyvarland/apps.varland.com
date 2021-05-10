module ApplicationHelper

  include Pagy::Frontend

  def icon_for_file(file)
    excel_types = ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                   "application/vnd.ms-excel"]
    word_types = ["application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                  "application/msword"]
    powerpoint_types = ["application/vnd.openxmlformats-officedocument.presentationml.presentation",
                        "application/vnd.ms-powerpoint"]
    code_types = ["application/json",
                  "text/markdown",
                  "application/xml",
                  "text/xml",
                  "text/html"]
    case file.content_type
    when *::Attachment.allowable_image_types
      return fa("file-image")
    when *::Attachment.allowable_video_types
      return fa("file-video")
    when *::Attachment.allowable_audio_types
      return fa("file-audio")
    when "application/pdf"
      return fa("file-pdf")
    when *excel_types
      return fa("file-excel")
    when *powerpoint_types
      return fa("file-powerpoint")
    when *word_types
      return fa("file-word")
    when "application/zip"
      return fa("file-archive")
    when "text/csv"
      return fa("file-csv")
    when *code_types
      return fa("file-code")
    when "text/plain", "application/rtf"
      return fa("file-alt")
    else
      return fa("file-alt")
    end
  end

  def department_name(val, options = {})
    prefix = options.fetch(:prefix, true)
    prefix_text = prefix ? "#{val} - " : ""
    case val.to_s
    when "3"
      return "#{prefix_text}Department 3"
    when "4"
      return "#{prefix_text}BNA"
    when "5"
      return "#{prefix_text}Department 5"
    when "6"
      return "#{prefix_text}Oil Dip"
    when "7"
      return "#{prefix_text}Bake"
    when "8"
      return "#{prefix_text}Robot"
    when "9"
      return "#{prefix_text}Strip"
    when "10"
      return "#{prefix_text}Miscellaneous"
    when "11"
      return "#{prefix_text}Oil Dip"
    when "12"
      return "#{prefix_text}EN"
    else
      return "Unknown Department"
    end
  end

  def card_list(title, items)
    list_items = []
    items.each do |item|
      label = content_tag(:div, "#{item[:label]}:", class: ["text-uncolor", "small", "text-nowrap", "lh-1"])
      value = content_tag(:div, item[:value].to_s.html_safe, class: ["lh-sm", "my-0"])
      list_items << content_tag(:li, label + value, class: ["list-group-item", "d-flex", "flex-column", "align-items-top", "justify-content-start", "bg-light"])
    end
    header = content_tag(:h6, title, class: ["card-header"])
    list = content_tag(:ul, list_items.join.html_safe, class: ["list-group", "list-group-flush"])
    content_tag(:div, header + list, class: ["card", "bg-light", "mt-3"])
  end

  def fa(icon, options = {})
    fw = options.fetch(:fw, true)
    type = options.fetch(:type, "fas")
    text_class = options.fetch(:text_class, nil)
    spin = options.fetch(:spin, false)
    classes = ["fa-#{icon}", type]
    classes << "fa-fw" if fw
    classes << "fa-spin" if spin
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
    message = content_tag(:div, msg.to_s.html_safe, class: "message")
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

  def row_class_for_receiving_note(type)
    return case type
           when "Purchased Item" then "table-success"
           when "Customer Parts" then "table-danger"
           when "Chemicals" then "table-primary"
           else "table-warning"
           end
  end

end