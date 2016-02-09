class PostExcerpt < Redcarpet::Render::Base
  # Markdown to excerpt renderer. Only takes the text
  # in the first paragraph.

  def initialize
    super
    @done = false
  end

  def paragraph(text)
    unless @done
      @done = true

      text
    end
  end
end