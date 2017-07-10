module SearchHelper
  def show_for_record type, record
    case type
    when :expert
      concat link_to record.name, record
      concat "&nbsp;".html_safe
      content_tag :span, user_expertise(record), class: "pull-right"
    when :topic
      concat link_to record.name, record
      concat "&nbsp;".html_safe
      content_tag :span, class: "pull-right" do
        content_tag :em, "(#{record.theme.name})"
      end
    when :user
      link_to record.name, record
    else
      raise NotImplementedError.new("please implement SearchHelper.show_for_record when type is #{type}")
    end
  end
end
