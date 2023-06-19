class PrintToPaperJob < ApplicationJob
  queue_as :default

  def perform(text)
    Net::SSH.start(Rails.application.credentials.printing_raspi["hostname"], Rails.application.credentials.printing_raspi["username"], password: Rails.application.credentials.printing_raspi["password"]) do |ssh|
      ssh.exec!("echo '#{text}' | lp -d POS-58-Series")
      ssh.exec!("exit\n")
    end
  end
end
