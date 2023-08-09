module DieHelper
  def valid_die_values
    values = []
    Die.titles.keys.each_with_index do |title, index|
      values << {title: title, shortcode: Die::VALID_SHORTCODES[index]}
    end
    values
  end
end
