module ApplicationHelper

  include Pagy::Frontend

  def calibration_status_badge(status)
    div_classes = ["badge"]
    text = ""
    case status
    when "past_due"
      div_classes << "text-white" << "bg-red-500"
      text = "Past Due"
    when "today"
      div_classes << "text-dark" << "bg-yellow-500"
      text = "Today"
    when "next_week"
      div_classes << "text-white" << "bg-blue-500"
      text = "Next Week"
    when "next_month"
      div_classes << "text-white" << "bg-purple-500"
      text = "Next Month"
    else
      div_classes << "text-white" << "bg-green-500"
      text = "Future"
    end
    content_tag(:div, text.upcase, class: div_classes.join(" "))
  end

  def yes_no_dropdown(f, attribute, text)
    f.input attribute, label: text, collection: [["Yes", true], ["No", false]], input_html: { class: "form-select" }, include_blank: false
  end

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
    when "30"
      return "#{prefix_text}Waste Water"
    else
      return "Unknown Department"
    end
  end

  def card_list(title, items)
    list_items = []
    items.each do |item|
      unless_condition = item.fetch :unless, false
      if_condition = item.fetch :if, true
      next if unless_condition || !if_condition
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
    target = options.fetch(:target, "_self")
    icon = fa(icon, type: type, text_class: text_class)
    text = content_tag(:span, text, class: ["label", text_class])
    badge = badge.nil? ? "" : content_tag(:div, badge, class: ["badge", "rounded-pill", badge_class, badge_text_class])
    html = content_tag(:div, icon + text + badge, class: ["d-flex", "flex-row", "align-items-center", "justify-content-start"])
    link_to_unless_current(html, url, target: target, class: ["nav-link"] + link_class) do content_tag(:div, html, class: "navbar-text px-md-2") end
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
    target = options.fetch(:target, "_blank")
    link_text = content_tag(:div, text.html_safe, class: "text")
    icon = content_tag(:div, fa(icon), class: "icon")
    if tooltip.blank?
      link = link_to(icon + link_text, url, class: "home-page-link", target: target)
    else
      link = link_to(icon + link_text, url, class: "home-page-link", target: target, title: tooltip, data: {"bs-toggle": "tooltip", "bs-placement": "top", "bs-html": "true"})
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

  def receiving_note_type_badge(type)
    badge_class = case type
                  when "Purchased Item" then "bg-success"
                  when "Customer Parts" then "bg-danger"
                  when "Chemicals" then "bg-primary"
                  else "bg-warning"
                  end
    return content_tag(:div, type, class: ["badge", badge_class])
  end

  def load_json(url)
    # puts "  🔴 Loading JSON: #{url}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return nil unless response.code.to_s == "200"
    return JSON.parse(response.body, symbolize_names: true)
  end

  def shop_order_link(shop_order)
    json = load_json("http://vcmsapi.varland.com/shop_order?shop_order=#{shop_order}")
    return unless json[:valid]
    if json[:current]
      url = "http://pdfapi.varland.com/so?shop_order=#{shop_order}"
    else
      url = "http://so.varland.com/so/#{shop_order}"
    end
    link_to fa("file-pdf", text_class: "text-vp-red"), url, class: ["ms-1", "small"], target: "_blank"
  end

  def highlight_search_term(term, string)
    return string if term.blank?
    re = /'.*?'|".*?"|\S+/
    term.scan(re) do |individual_term|
      unquoted_term = individual_term
      unquoted_term = individual_term.delete_prefix("'").delete_suffix("'") if individual_term[0] == "'" && individual_term[-1] == "'"
      unquoted_term = individual_term.delete_prefix("\"").delete_suffix("\"") if individual_term[0] == "\"" && individual_term[-1] == "\""
      string.gsub!(/#{unquoted_term}/i) do |match|
        "<mark class=\"search-term\">#{match}</mark>"
      end
    end
    return string
  end

  def employee_note_icon(type)
    case type
    when "Positive"
      return "plus-circle text-success"
    when "Negative"
      return "minus-circle text-danger"
    when "Neutral"
      return "dot-circle text-secondary"
    end
  end

end