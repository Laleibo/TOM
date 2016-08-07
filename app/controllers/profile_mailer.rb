class ProfileMailer < ActionMailer::Base
  default :from => "meagher.denise@yahoo.com"

  def
    registration_confirmation(profile)
    @profile = profile
    mail(:to => "#{profile.email}", :subject => "Registration Confirmation")
  end
end
