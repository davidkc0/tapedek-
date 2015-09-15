module ConversationsHelper
  def participant_name(conversation)
    participant = conversation.participants.delete_if { |x| x == current_user }.first
    return participant.try(:name) || "[deleted]"
  end
end
