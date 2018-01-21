module MarkdownHelper
  def parse_markdown(text)
    markdown.render(text).html_safe
  end

  private

  def renderer
    @renderer ||= Redcarpet::Render::HTML.new
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer)
  end
end