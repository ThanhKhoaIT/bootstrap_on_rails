# frozen_string_literal: true

class BootstrapOnRails::V5::CardBuilder < BootstrapOnRails::V5::BaseBuilder
  def render
    css_class = [:card] << options[:class]

    content_tag :div, class: css_class, id: options[:id] do
      concat header
      concat body
    end
  end

  private

  def title
    @title ||= options[:title]
  end

  def header
    return if title.blank?

    css_class = ["card-header"] << options.dig(:header, :class)

    content_tag :div, class: css_class do
      content_tag :p, title, class: "card-title"
    end
  end

  def body
    css_class = ["card-body"] << options.dig(:body, :class)

    content_tag :div, class: css_class do
      concat capture(&block)
    end
  end
end
