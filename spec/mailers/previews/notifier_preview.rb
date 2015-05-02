# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier/recipe_new
  def recipe_new
    Notifier.recipe_new
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifier/user_new
  def user_new
    Notifier.user_new
  end

end
