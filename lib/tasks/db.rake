require "json"

namespace :db do
  desc "Creates a game, dice, and sides based on JSON input file"
  task :create_game,
    %i[input_json_path] => :environment do |_, args|
    if args.input_json_path.blank?
      raise ArgumentError.new(
        "Please provide a path to the JSON input file"
      )
    end

    input_file = File.read(Rails.root.join(args.input_json_path))
    parsed_input_file = JSON.parse(input_file)

    ActiveRecord::Base.transaction do
      puts "Initializing game..."
      game = Game.create! title: parsed_input_file["game"]["title"]

      parsed_input_file["game"]["dice"].each do |die_input|
        die = Die.create! title: die_input["title"], shortcode: die_input["shortcode"], game: game
        die_input["sides"].each_with_index do |side, idx|
          Side.create! die: die, title: side["title"], variations: side["variations"], shortcode: idx + 1
        end
      end
    end

    puts "✅ Successfully created game and all resources."
  end
end
