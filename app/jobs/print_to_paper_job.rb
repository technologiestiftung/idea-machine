class PrintToPaperJob < ApplicationJob
  queue_as :default

  def perform(text)
    Net::SSH.start(Rails.application.credentials.printing_raspi["hostname"], Rails.application.credentials.printing_raspi["username"], password: Rails.application.credentials.printing_raspi["password"]) do |ssh|
      print_command = <<~COMMAND
        echo 'Betreff: Idee
        Von: Ideenwürfel
        An: idee@ts.berlin
        ------------------
        #{text}' | fold -w 18 -s | lp -d POS-58-Series
      COMMAND

      ssh.exec!(print_command)
      ssh.exec!("exit\n")
    end
  end
end
