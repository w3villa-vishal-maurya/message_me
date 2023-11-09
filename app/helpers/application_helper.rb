module ApplicationHelper
  def find_last_message(user, current_user)
    name = get_name(user, current_user)
    room = Room.where(name: name).last
    message = room&.messages&.where(user_id: user.id).last if room
    message.present? ? message : nil
  end

  def get_name(user1, user2)
    if user1 && user2
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end
  end

  def update_time(datetime_value)
    # Extracting components
    current_time = Time.now

    # Calculating the difference
    time_difference = current_time - datetime_value

    # Extracting components from the difference
    hours_difference = (time_difference / 1.hour).to_i
    minutes_difference = ((time_difference % 1.hour) / 1.minute).to_i
    seconds_difference = ((time_difference % 1.minute) / 1.second).to_i

    if hours_difference >= 24
      hours_difference / 24.to_s + "d"
    elsif hours_difference == 0
      if minutes_difference == 0
        seconds_difference.to_s + "sec"
      else
        minutes_difference.to_s + "min"
      end
    else
      hours_difference.to_s + "h"
    end
  end
end
