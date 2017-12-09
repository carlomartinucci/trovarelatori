module ApplicationHelper
  # def backendSidebarThemes themes
  #   return if themes.blank?
  #   themes.map do |theme|
  #     content_tag :li do
  #       link_to theme.breadcrumb, [:backend, theme]
  #     end
  #   end.join.html_safe
  # end

  # def backendNavLinks links
  #   links.map{|my_model| backendNavLink my_model }.join.html_safe
  # end

  # def backendNavLink my_model
  #   content_tag :li do
  #     backendNavLinkWrapper my_model do
  #       # fa_icon :envelope, text: my_model.model_name.human(count: 2)
  #       my_model.model_name.human(count: 2)
  #     end
  #   end
  # end

  # def backendNavLinkWrapper my_model
  #   return params[:controller] == my_model.model_name.route_key && params[:action] == "index" ?
  #     content_tag(:span) { yield } :
  #     link_to("/backend/#{my_model.model_name.route_key}") { yield }
  # end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def toastr_error(model)
    "#{pluralize(model.errors.count, 'errore', 'errori')}: #{model.errors.full_messages.to_sentence}"
  end

  def list_names(names)
    names.uniq.map { |name| content_tag :span, name, style: 'text-decoration: underline;' }.join(', ').html_safe
  end
end
