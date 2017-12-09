module UsersHelper
  def user_age(date_of_birth)
    return nil if date_of_birth.blank?
    now = Time.now.utc.to_date
    after_birthday = now.month > date_of_birth.month ||
      (now.month == date_of_birth.month && now.day >= date_of_birth.day)
    now.year - date_of_birth.year - (after_birthday ? 0 : 1)
  end

  def show_if_public(user, attribute)
    if user.send("public_#{attribute}")
      show_visible user, attribute
    elsif attribute == :birthday && user.birthday.present?
      "#{user_age user.birthday} anni"
    else
      content_tag :em, 'Privato'
    end
  end

  def show_visible(user, attribute)
    if attribute == :email
      mail_to user.email, user.email
    elsif attribute == :birthday && user.birthday.present?
      "#{l user.birthday} (#{user_age user.birthday} anni)"
    elsif attribute == :birthday
      'Sconosciuto'
    else
      user.send(attribute) || 'Sconosciuto'
    end
  end

  def show_visibility(user, attribute)
    visibility_string = if user.send("public_#{attribute}")
                          content_tag :em, 'Pubblico'
                        else
                          content_tag :em, 'Privato'
                        end
    "(#{visibility_string})".html_safe
  end

  def current_user?(user)
    current_user.id == user.id
  end

  def user_expertise(user)
    user.expertise.sort.group_by(&:knowledge).map do |knowledge, known_topics|
      res = "#{known_topics.count} #{knowledge_fa_icon knowledge}"
      # res += " (" + t("knowledges.#{knowledge}") + ")"
      res
    end.join('&nbsp;').html_safe
  end
end
