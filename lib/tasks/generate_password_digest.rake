namespace :generate_password_digest do
  desc "password_digestが空のユーザーに、引数で受け取ったpassword文字列を設定する"

  task :execute, ['password'] => :environment do |task, args|
    raise 'Argument is empty!' if args.password.nil?

    users = User.where(password_digest: '');
    users.each do |user|
      user.password = args.password
      user.password_confirmation = args.password
      user.save
    end
  end
end
