module KnownTopicsHelper
  def knowledge_fa_icon(knowledge, options = {})
    options.reverse_merge!(title: t("knowledges.#{knowledge}"))
    icon = case knowledge
           when 'unknown'
             :question
           when 'interested'
             :book
           when 'private'
             'handshake-o'
           when 'public'
             'graduation-cap'
           when 'debate'
             :institution
           else
             :question
           end
    fa_icon icon, options
  end
end
