# frozen_string_literal: true

class BootstrapOnRails::V5::TableBuilder < BootstrapOnRails::V5::BaseBuilder
  def render
    css_class = [:table, table_styles] << options[:class]

    content_tag :table, class: css_class.flatten, id: options[:id] do
      capture(self, &block)
    end
  end

  def header(options = {}, &block)
    header_content ||= capture(&block) if block_given?
    content_tag :thead, class: options[:class] do
      content_tag :tr, header_content
    end
  end

  def body(collection: [], partial: nil, as: nil, locals: {}, &block)
    content_tag :tbody do
      if collection.empty?
        concat content_tag(:caption, empty_message, class: "text-center empty-message", align: :bottom)
      end
      collection.each_with_index do |item, index|
        if block_given?
          primary_key_value = item.try(:primary_key_value) || index
          concat content_tag(:tr, capture(item, index, &block), "data-key" => primary_key_value)
        else
          as ||= collection.model.model_name.i18n_key
          partial ||= collection.model.model_name.element
          locals = locals.merge(as.to_sym => item, item_index: index)
          concat content_tag(:tr, render_view(partial: partial, locals: locals),
                             "data-key" => item.try(:primary_key_value) || index)
        end
      end
    end
  end

  private

  def empty_message
    options[:empty_message].presence || "No data"
  end

  def table_styles
    return if options[:styles].blank?

    options[:styles].map { |style| "table-#{style}" }
  end

end
