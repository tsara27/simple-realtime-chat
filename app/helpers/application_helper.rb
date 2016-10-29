module ApplicationHelper
  def channel_name(message)
    "private-channel-#{message.sender.id}_#{message.recipient.id}"
  end
end
