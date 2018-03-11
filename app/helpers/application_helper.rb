module ApplicationHelper

  # & turns the block into a proc. proc is a block that can be reused
  def form_group_tag(errors, &block)
    css_class = "form_group"
    css_class << ' has-error' if errors.any?

    # This method is used to build HTML and CSS to display the form element
    content_tag :div, capture(&block), class: css_class
  end
end
