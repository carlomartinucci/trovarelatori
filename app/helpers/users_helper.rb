module UsersHelper
  def user_age dob
    return nil if dob.blank?
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def show_if_public user, attribute
    if user.send("public_#{attribute}")
      show_visible user, attribute
    else
      if attribute == :birthday
        user.birthday ? 
          "#{user_age user.birthday} anni" :
          content_tag(:em, "Privato")
      else
        content_tag :em, "Privato"      
      end
    end
  end
  
  def show_visible user, attribute
    if attribute == :email
      mail_to user.email, user.email
    elsif attribute == :birthday
      user.birthday ? 
        "#{l user.birthday} (#{user_age user.birthday} anni)" :
        "Sconosciuto"
    else
      user.send(attribute) || "Sconosciuto"
    end
  end

  def show_visibility user, attribute
    visibility_string = if user.send("public_#{attribute}")
      content_tag :em, "Pubblico"
    else
      content_tag :em, "Privato"
    end
    "(#{visibility_string})".html_safe
  end

  def current_user? user
    current_user.id == user.id
  end

  def user_expertise user
    user.expertise.sort.group_by(&:knowledge).map do |knowledge, known_topics|
      res = "#{known_topics.count} #{knowledge_fa_icon knowledge}"
      # res += " (" + t("knowledges.#{knowledge}") + ")"
      res
    end.join("&nbsp;").html_safe
  end

end
