class PrintToPaperJob < ApplicationJob
  queue_as :default

  def perform(text)
    Net::SSH.start(Rails.application.credentials.printing_raspi["hostname"], Rails.application.credentials.printing_raspi["username"], password: Rails.application.credentials.printing_raspi["password"]) do |ssh|
      # Print command here
      pwd = ssh.exec!("pwd")
      puts "Tunnelled into #{pwd}"
      ssh.exec!("exit\n")
    end
  end
end
