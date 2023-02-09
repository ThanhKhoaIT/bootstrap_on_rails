# frozen_string_literal: true

class BootstrapOnRails::V5::DescriptionBuilder < BootstrapOnRails::V5::BaseBuilder
  def render
    content_tag :dl, class: :row, id: options[:id] do
      capture(self, &block)
    end
  end

  def line(label, content = nil, &block)
    content ||= capture(&block) if block_given?
    concat content_tag(:dt, label, class: "col-sm-#{label_size}")
    content_tag(:dd, content, class: "col-sm-#{content_size}")
  end

  def presence_line(label, content = nil, &block)
    content ||= capture(&block) if block_given?
    return if content.blank?

    concat content_tag(:dt, label, class: "col-sm-#{label_size}")
    content_tag(:dd, content, class: "col-sm-#{content_size}")
  end

  private

  def label_size
    size = options[:label_size].to_i
    size.positive? ? size : 3
  end

  def content_size
    12 - label_size
  end
end
