class PrintToPaperJob < ApplicationJob
  queue_as :default

  def perform(text)
    Net::SSH.start(Rails.application.credentials.printing_raspi["hostname"], Rails.application.credentials.printing_raspi["username"], password: Rails.application.credentials.printing_raspi["password"]) do |ssh|

      command = <<-TEXT
echo 'Betreff: Idee
Von: Ideenwürfel
------------------
#{text}' | fold -w 18 -s | lp -d POS-58-Series
TEXT

      ssh.exec!(command)
      ssh.exec!("exit\n")
    end
  end
end
