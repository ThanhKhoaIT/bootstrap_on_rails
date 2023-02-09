# frozen_string_literal: true

class BootstrapOnRails::V5::ModalBuilder < BootstrapOnRails::V5::BaseBuilder

  def render
    content_tag :div, class: "modal fade", id: options[:id], tabindex: -1,
      "data-bs-backdrop" => options[:backdrop] do
        content_tag :div, class: "modal-dialog modal-#{options[:size]}" do
          content_tag :div, class: "modal-content" do
            concat header_tag
            concat content_tag(:div, capture(self, &block), class: "modal-body")
          end
        end
      end
  end

  private

  def header_tag
    times_icon = content_tag(:span, "×", class: "text-muted", aria: { hidden: true })
    content_tag :div, class: "modal-header" do
      concat content_tag(:h5, options[:title], class: "modal-title")
      concat content_tag(:button, times_icon, type: :button, class: "btn-close", "data-bs-dismiss" => "modal",
                         "aria-label" => "Close")
    end
  end

end
