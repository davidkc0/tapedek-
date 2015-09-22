module ConversationsHelper
  def participant_name(conversation)
    participant = conversation.participants.delete_if { |x| x == current_user }.first
    return participant.try(:name) || "[deleted]"
  end

  def inbox_with_notification_number
    num = current_user.mailbox.inbox({:read => false}).count
    # num_of_new_messages = current_user.mailbox.inbox(:unread => true).count(:id, :distinct => true)
    if num > 0
      "<span class='new_messages'>"\
      "inbox"\
      "</span><span class='notification_number'>"\
      "#{num}</span>".html_safe
    else
      "inbox"
    end
  end
end
