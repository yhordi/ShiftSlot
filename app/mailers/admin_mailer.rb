class AdminMailer < ApplicationMailer

  def confirmation(org)
    @org = org
    mail(to: @org.primary_admin_email, subject: "ShiftSlot Organization creation")
  end
end
