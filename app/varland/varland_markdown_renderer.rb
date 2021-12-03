class VarlandMarkdownRenderer < Redcarpet::Render::HTML

  def link(link, title, content)
    return "<a href=\"#{link}\" title=\"#{title}\" target=\"_blank\">#{content}</a>"
  end

  def codespan(code)
    return "<code class=\"fw-700\">#{code}</code>"
  end

end