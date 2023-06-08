class PrintToPaperJob < ApplicationJob
  queue_as :default

  def perform(text)
    # puts("This is a placeholder for the printing to paper job. The text to be printed would be this:")
    # puts(text)

    # file = Tempfile.new
    # file.write text
    # file.rewind

    # This is just a placeholder for a possible call to the printer:
    # system("lpr -P myprintername #{file.path}")
  end
end
