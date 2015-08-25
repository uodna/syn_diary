class UserMailer < ActionMailer::Base
  default from: "support@example.com"

  def comment_notification(comment, user_commented_to, user_commented_from)
    @comment = comment
    @user_commented_to = user_commented_to
    @user_commented_from = user_commented_from
    mail(to: @user_commented_to.email, subject: @user_commented_to.first_name + "さんの日報にコメントがありました！")
  end

end
