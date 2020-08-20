module PostsHelper
  def time_ago time_now, time_post
    time = (time_now - time_post).to_i / Settings.minutes
    if time < Settings.minutes
      time.to_s + t("minutes")
    elsif time < Settings.hours
      (time / Settings.minutes).to_s + t("hours")
    else
      (time / Settings.hours).to_s + t("days")
    end
  end

  def get_user post
    post.user
  end
end
